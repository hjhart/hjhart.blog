---
title: "How do I find Core Dumps on Circle CI?"
layout: post
category:
date: 2016-09-09 14:29:18 PDT
comments: true
---

<span class='newthought'>We were getting a lot of core dumps and segfaults </span> in our CI builds. We've been getting them for a while, now, but they were so infrequent we just let them slide by the wayside.

As soon as we switched over from Travis Pro to Circle CI for our private repositories at Wanelo we noticed the frequency of segmentation faults were increasing. Great! If this is more reproducable, now we can actually troubleshoot.

Well, it turns out that core dumps aren't saved on Circle CI currently. Apport appears to be configured to handle the core dumps (as configured on `/proc/sys/kernel/core_pattern`). It also appears to be installed on the boxes when I SSH into them. However, checking out `/etc/security/limits.conf` showed that ubuntu wasn't allowing core dumps to be created (the default max file size is 0 bytes on Ubuntu).

The good news is that upon submitting a request ticket to Circle CI Support, a gentleman got back to me and verified that core dumps are not currently created there, but should be in a couple of weeks. They'll announce it on [discuss](https://discuss.circleci.com/) when they release it.

That's some pretty good news from a company I'm just starting to get acquainted with. I'll probably stick with Circle CI next time I am setting up a new CI environment.

## Need it before then?

It's possible that you might be able to add a couple of lines into `/etc/security/limits.conf` when setting up the machine in a custom build step that sets the limit of user ubuntu for the core process. I never ended up needing to spike into that, but if you go that route and succeed, let me know.

