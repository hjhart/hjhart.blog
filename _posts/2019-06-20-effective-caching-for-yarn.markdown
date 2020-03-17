---
title: "Effective Caching for Yarn, Bundler, and the Rails Asset Pipeline in CircleCI"
layout: post
date: 2019-06-20 02:21:16 UTC
comments: true
---

> This blog post was originally posted on the Voom Flights blog, <a href="https://blog.voom.flights/effective-caching-for-yarn-bundler-and-the-rails-asset-pipeline-in-circleci-5ba60c22c983">here</a>.

Phil Karlton said: “There are two hard problems in computer science: cache invalidation, naming things, and off-by-1 errors.”

Well, maybe he didn’t say exact that, but it’s a <a href="https://martinfowler.com/bliki/TwoHardThings.html">decent joke</a> anyway.

In this article I’ll talk about the first of those problems, caching. And in doing so effectively, how we reduced our CircleCI build times by 36%. For those of you raising your eyebrows and saying “36% off of what?!”, I’ll direct your eyeballs to the graph below for some absolute numbers.
Average speed up of 36%! Total reduction of 19 minutes per workflow.

<img src="/images/effective_caching/build_times.png" alt="Build Times"/>

Amazing, right?!

Now I’ll show you how. But first, a note on all of the code snippets in this blog post!

> All of the code snippets I’m sharing are <a href="https://circleci.com/docs/2.0/configuration-reference/#commands-requires-version-21">CircleCI commands</a>, so they can be copy and pasted easily if you’re using CircleCI config version 2.1.

## Yarn Caching

The important thing to do is to know when to invalidate caches. In this case, we know that the `node_modules` directory will update if and only if our `yarn.lock` file updates. So yarn is actually pretty easy!

{% gist hjhart/1f421479e56f58fa5959dda01ec36ffe circle_ci.yarn_install.config.yml  %}

## Bundler Caching

Bundler is similar too. The `Gemfile.lock` file is explicit with dependencies, so only when it changes do we need to invalidate the cache and generate a new one.

{% gist hjhart/6a0fe4acd5eaf1b728e83ae7e4edbf2b circleci.bundle_install.yml %}

You’ll notice that there are two keys within the `restore_cache` step. The first key, `bundle-{{ arch }}-{{ checksum "~/voom/Gemfile.lock" }}` will always match if the `Gemfile.lock` matches.

But what if the `Gemfile.lock` changes?

Well, it will fall back to the `bundle-{{ arch }}-` key, which was created the same time the first `bundle-{{ arch }}-{{ checksum "~/voom/Gemfile.lock" }}` was saved.

Caches are immutable in CircleCI, so once you create them you will not create them again.

Which presents us with a challenging caching scenario. Let’s say that I run this job in January of this year. Then, in six months, when I run this job again and the `bundle-{{ arch }}` key matches, that means the cache is six months old. That might not be an improvement!

So it is good to invalidate those caches every so often. So, let’s manipulate that key to invalidate every month or so.

This allows us to fall back to a cache if the initial key doesn’t match.

{% gist hjhart/d6162db7802021e4d04b10c9b3adf0e4 better_circleci.bundle_install.yml %}

Okay, this looks better.

Now, if our `Gemfile.lock` changes at most we will be falling back to a cache generated at the beginning of the month, so instead of a 6 month old cache, we will get a 1 month old cache.

You can tighten or loosen the time-based invalidation based on what you prefer. The first job where the cache is invalidated will be slow, and you should expect each subsequent build to be fast after that.

At this point, I need to point out a huge time waster that I discovered in my journey: **If you are using checksum for cache invalidation, make sure the file does not change in between `restore_cache` and `save_cache`**.

For instance, I was running `bundle install` with a different version of bundler inside of CircleCI. That would update the `Gemfile.lock` to change the version of bundler used.

That means that the checksum when saving the cache was based off a file that was never checked into version control.

So that’s why we are using bundlers `--frozen` flag during bundles to make sure that doesn't happen (again).

## Asset Pipeline and Webpacker Caching

We currently use both sprockets and webpacker to generate our assets. Eventually, we will migrate all of our assets to webpacker. In the meantime, this is what it looks like to cache both:

{% gist hjhart/a33d677da341bc89ab0b1de1d8aac159 rails_assets.config.yml %}

Here is another strategy for cache invalidation:

`find ~/voom/app/javascript ~/voom/app/assets -type f -exec md5 -q {} \; > ~/voom/dependency_checksum`

What it says is: If any file within these directories (`~/voom/app/javascript` or `~/voom/app/assets`) then let's generate a new cache.

I suspect there are holes in this cache key, like, if a `yarn.lock` file changes potentially it should invalidate the cache. And since caching is hard, and I don't really want to think too hard about it, I like to add the note to bump the cache when things get too slow (with a threshold, so anyone can bump the cache prefix).

## Bonus: MacOS Homebrew caching

I’m going to post this one here because it took about a minute off of each macOS build for me, and it is working great. You’ve seen the strategies already, so I won’t go into them:

{% gist hjhart/ec8d2484f19763dc22a73064a06308f0 homebrew.config.yml %}

## Wrapping Up

Well, we have come a long way, but we still have a lot to go. Cocoapod installation still takes 3 minutes. xCode building takes about 5 minutes. We stand to gain a lot from a better caching strategy!

Please reach out to anyone on the Voom engineering team if this article helped, or if you’ve found some other strategies that work well for you. Making CI faster means we can ship better features, faster!
