---
title: "View and reset PostgreSQL query statistics"
layout: post
category: 
date: 2016-09-06 14:54:00 PDT
comments: true
---

<span class='newthought'>When trying to understand how to alleviate pressure </span> from our PostgreSQL instances, we were using a query like this:

{% gist hjhart/65a5ab33623c14995b48e1e7bdd3ff51 query.sql %}

Which displays the 12 most expensive queries that postgres has spent time doing. It's pretty useful for finding out where you should be putting indexes, or where you can change your application code to alleviate the pressure.                                                                                                                                                          
                                                                                                                                                          
{% gist hjhart/65a5ab33623c14995b48e1e7bdd3ff51 results.sql %}

Once you've optimized all the things on the `posts` table and deployed out new code, you will want to get those statistics updated. I had a hard time figuring this one out, so I'm leaving it here for myself for later:

{% gist hjhart/65a5ab33623c14995b48e1e7bdd3ff51 reset.sql %}
