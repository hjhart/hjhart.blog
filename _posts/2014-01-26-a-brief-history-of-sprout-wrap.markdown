# A Brief History of Sprout Wrap

When Wanelo gets a brand new workstation the first thing we install on it is Sprout. Sprout is a collection of OSX specific recipes that allow you to install common utilities and applications that every ruby developer has and will appreciate.

Anyone who has worked at Pivotal Labs would feel comfortable with the workstations that spawn from `sprout-wrap`, because they've probably worked on one before. Sprout is based on [chef-soloist](https://github.com/mkocher/soloist) that allows a developer to run a set of chef recipes from their local machine. Recipes have been built for applications like chrome, rubymine, and iterm. Other common OSX settings — ones that have to be changed on *every* new workstation — can be switched, including turning SSH on, changing the default keyboard repeat rate, installing sane git aliases, rbenv, and bash completion.

You can automatically clone git repositories into your `~/workspace` directory. You can install postgres, imagemagick, node, dropbox, phantomjs, gitx, caffeine, and heroku toolbelt. If you've used found a utility useful in a development setting, or flipped a switch somewhere in System Preferences, a recipe probably exists in one of sprout's cookbooks.

## So who is this useful for?

We have grown considerably in the last six months I've been there. We've hired four new people. That's two pairing stations that two pairs would normally have to set up. We took the time to set up a `soloistrc` file – the file where you specify which recipes to run. 

Here's a snippet from a standard `soloistrc` file:

    # development (rails) 
    - pivotal_workstation::rbenv
    - pivotal_workstation::gem_setup
    - pivotal_workstation::postgres
    - sprout-osx-apps::imagemagick
    - sprout-osx-apps::node_js
    - sprout-osx-apps::qt
    
    # apps 
    - sprout-osx-apps::skype
    - sprout-osx-apps::chrome
    - sprout-osx-apps::textmate
    - sprout-osx-apps::1password
    - sprout-osx-apps::hub
    - sprout-osx-apps::phantomjs
    - sprout-osx-apps::gitx
    - sprout-osx-apps::propane

Running `bundle exec soloist` inside the proper directory will ensure all applications are installed. After unboxing new workstations (or formatting the out-of-date ones) a full run of sprout-wrap takes about two and a half hours. Subsequently, each run takes about 3 minutes.

## Customize!

At Wanelo we wrote a recipe that runs `bundle install` and sets up our development database. It gets our ruby web application to a state where we can run `foreman start` on a brand new machine. We also wrote a recipe that installs our VPN on our machines. The most recent recipe we wrote installs our favorite vim plugins, configurations, and theme. 

## We Have Reached Convergence

Sprout-wrap has the benefit of following chef's principals and requires recipes to be idempotent. So when a developer includes the recipes that, for instance, installs `cowsay`, going forward each workstation will now have cowsay. Which means every developer is happy to work on any workstation. Because, hey, now you have cowsay on every workstation. 

     ________
    < Moo. >
     --------
            \   ^__^
             \  (oo)\_______
                (__)\       )\/\
                    ||----w |
                    ||     ||

Sprout enables us as pairing developers to build a stable cluster of similar machines where there are minimal development bottlenecks. Having someone who is familiar and can set up sprout-wrap on your machines is hugely valuable for a growing organization, and can save hours, likely _days_ of developer's time.

You can learn and find instructions on how to set up and install sprout on [github](https://github.com/pivotal-sprout/sprout-wrap).

