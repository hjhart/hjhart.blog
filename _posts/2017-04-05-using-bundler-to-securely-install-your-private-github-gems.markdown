---
title: "Using Bundler to Securely Install Your Private Github Gems"
layout: post
date: 2017-04-05 12:56:06 PDT
comments: true
excerpt: "We needed to figure out a way to download our private gems from github securely. Here's how we did it."
---

Do you see this message all the time when you run `bundle install`?

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e bundler_warning_message %}

It's true. The git protocol is not fully secure, meaning that the server that you are pulling code from is not verified by certificate authorities. Seems a bit scary!

Now, when converting, most of your gems in your `Gemfile` will be fine converting from git protocol to https. However, it is the private repositories that you'll need to authenticate.

In order to switch to the HTTPS protocol, for these private gems from github, you'll need to figure out how you're going to authenticate when deploying, shipping to CI, or setting up a new workstation.

So how do we go about doing this?

## OAuth Verification

In a very old post on github's blog, they [announced][github_announcement] that they were going to support a HTTP Basic Auth implementation allowing OAuth generated tokens. When you normally do a `bundle install`, your workstation will ask you for a username and a password, but when you're deploying or running a build in CI, you won't be able to enter that. You want to be able to run a uninterrupted, non-interactive `bundle install`.

Let's break it down to a more simple problem. We want to be able to do a `git clone https://github.com/hjhart/private_repo` without being asked for a username or a password. We can do that by adding some basic authentication parameters to the URL, with the username being a newly generated OAuth token.

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e git_clone_basic_auth.sh %}

The above command will no longer ask you for a password! You can also omit the password `x-oauth-token` if that fits your workflow better.

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e git_clone_basic_auth_no_passwd.sh %}

## The Gemfile

We will use the same strategy in your Gemfile to clone these repositories in your deployments or your CI scripts.

Inside your Gemfile, you'll want to replace lines that use `git: 'git@github.com...'` with HTTPS urls, like so:

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e Gemfile %}

## Bundle Config

Now we just need to instruct bundler where the find the credentials. We can do that by issuing a bundle config command.

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e bundle_config %}

This creates an environment variable in your `~/.bundle/config` file, which will exist every time you run a `bundle` command.

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e ~.bundle_config %}

Now, running a `bundle install` will authenticate using those credentials specified. For CI environments, or deployment environments, you can also just specify the environment variable when issuing bundle commands, but I find it more consistent to place the authentication token inside of the `bundle config`

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e bundle_install.sh %}

## A Quick Side Note

For gems that are defined like this: `gem 'private_repo', github: 'hjhart/private_repo'`, bundler 2.0 will default to using HTTPS. For now, you can also issue a `bundle config github.https true` to allow this convenient notation to use HTTPS. See this [github issue][github_issue] for more details.

## Generate Your Token

To generate a new token, just replace the `--user` and `note` in the command below.

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e curl_request.sh %}

After being prompted for your password, a response will be returned like this:

{% gist hjhart/c1fb019a2ef3320f690e1076cabdb44e curl_response.json %}

Use the generated token as described in the Bundle Config section of this blog post for your workstations, your CI environment, and any app servers you deploy to.

Now, when you run a `bundle install` your gems will be downloaded in a secure manner, and you won't get any more warnings from bundler! Happy bundling!

You can see all of your active tokens on [github here][github_oauth_tokens].

## Caveat Emptor

When changing from the git protocol to the HTTPS protocol, bundler loses "track" of which version or git SHA the gem will be locked to. It sometimes will help to grab the git reference from the Gemfile.lock, and placing it into the `Gemfile` while making the switch. That way, the gems code will not unexpectedly change!

However, if all gems are recent (which they most likely will, as these are your private gems), you won't have any problems.

[github_announcement]: https://github.com/blog/1270-easier-builds-and-deployments-using-git-over-https-and-oauth
[thoughtbot_gist]: https://gist.github.com/masonforest/4048732
[github_issue]: https://github.com/bundler/bundler/issues/4978
[github_oauth_tokens]: https://github.com/settings/tokens
