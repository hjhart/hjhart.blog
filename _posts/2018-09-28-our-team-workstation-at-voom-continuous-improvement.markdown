---
title: "Our Team Workstation at Voom: Continuous Improvement"
layout: post
date: 2018-09-28 21:42:29 UTC
comments: true
---

> This blog post was originally posted on the Voom Flights blog, <a href="https://blog.voom.flights/our-team-workstation-at-voom-continuous-improvement-a1cf35ec1a43">here</a>.

Having a standardized workstation on our pairing machines allows us to set a baseline for the tooling at Voom. By allowing any engineer on the team to make changes to that baseline, we empower our team to contribute improvements, which allows us to ship code faster. When you have complete control over your workstation tooling, you no longer feel limited to using “someone else’s machine” – you are now contributing to the team’s workstation.

<img src="/images/continuous_improvement.jpg" alt="Typing!"/>

The importance of a shared workstation comes from pairing every day and rotating machines often. No _one_ engineering workstation is owned solely by _one_ engineer at the office. This makes having a comfortable and familiar and nearly identical setup a requirement for a productive team.

At Voom, we have a fairly standard Ruby on Rails development set up on macOS. Alongside the web app, we are developing a native iOS app in react-native. Each workstation is identical to reduce surprises and inefficiencies, and to allow engineers to share fixes to common pitfalls when they encounter them. Having a tool that everybody knows how to use, troubleshoot, customize, and extend is important to iterating on our team’s workstation. Enter [voomflights/workstation-setup](https://github.com/voomflights/workstation-setup).

<img src="/images/workstation_setup.gif" alt="A single run of Voom’s workstation setup"/>

## An Introduction to Our Tool

The workstation-setup tool is a series of bash scripts that allow a team to manage their workstations in a single git repository, using a language that is familiar to veterans, easy to learn for newcomers, and quick to troubleshoot.

Want to add an alias? Add it to our common alias file that gets copied over every run!

Want to install the newest version of Slack? Add it to the list of applications we install!

Want to install a new plugin in Sublime Text? Add it to the version-controlled json preferences file!

Want to enable another bash_it plugin, alias, or completion? Simple!

Want to tweak your shell prompt? A simple change to a single file will customize and update the next time you open a shell.

## Understanding the Goals of the Tool

The tool is fairly opinionated about the environment and gives the user recommendations on how to do things and what the standard setup should be. Some of these things I don’t agree with, but most are useful, and in an environment as flexible as your workspace, it’s good to have a bit of structure. I’ll give you a bit of background as to what we at Voom like, and what we’ve changed.

## What workstation-setup Does Right

- Installs homebrew and homebrew cask
- Installs popular text editors, code environments, and data stores — Sublime Text, rbenv, ruby 2.5.1, bundler, postgresql, redis
- Installs useful applications for development — ShiftIt, KeyCastr, Dash, FlyCut, Postman, MacDown, Slack
- Installs [bash_it](https://github.com/Bash-it/bash-it), a popular shell, and customizes the prompt to assist in git pairing tools.
- Makes macOS “awesome” — faster key repeat rates, hide / show dock, pins Chrome and iTerm to the dock, customizes the clock in the menu bar
- Installs custom scripts you want [opt-in](https://github.com/pivotal/workstation-setup/tree/master/scripts/opt-in) to, designer tools, docker tools, golang dev tools

## Voom’s Modifications to Suit Our Needs

- Install our currently used version of ruby, node, and any dependencies for the Voom web app or iOS app
- Checked in our sublime preferences json file, allowing us to share settings and installed plugins
- There seems to be an aversion to running the workstation setup repeatedly, like you’d want to do if you’re testing a new change. We’ve adjusted that on our fork, which we will address in another post.
- Added a custom background to our workstations
- No longer install IDEs that we don’t use (Jetbrains, emacs, Atom)

From a philosophical standpoint, when something goes wrong that is environment specific on a workstation, one pair can diagnose and repair the problem, then commit and push the fix. During standup or in Slack, we can notify everyone to update and run the workstation setup — thereby avoiding a problem that could be affecting every computer and wasting everyone’s time. At this point, we are not automatically pushing updates to computers — we want the updates to be “opt-in” as well as to adhere to the [principle of least surprise](https://en.wikipedia.org/wiki/Principle_of_least_astonishment). This follows the same pattern as security updates, or package management systems like apt.

## How to Iterate With Your Team

Establish a mutual agreement with your team so that when changes are made to the workstations, you let people know the next day at standup! Overriding commonly used keyboard shortcuts at an operating system level could confuse your fellow coworkers. Make sure you understand the implications of the changes you’re making, and communicate those to your coworkers.

Better yet, set up a system of pull requests where at least one other pair needs to agree to the changes you’ve made before accepting. Don’t be afraid to make mistakes and revert those changes if unexpected things happen.

## Before Adopting… Caveat Emptor

### Secrets

Do NOT check in secrets. When you fork this repository (and you should), you need to make sure that any changes you make are safe for the world to see. If you have many secret environment variables (e.g. API keys, login credentials) you will want to manage those in some other way, not within this repo.

### Destructive

From their README:

> Warning: the automation script is currently aggressive about what it does and will overwrite vim configurations, bash-it configurations, etc.

I wouldn’t run this on a personal machine that you’ve been configuring for months or years — this should be run on a fresh machine with a modern version of macOS installed (currently 10.13.6 at Voom).
