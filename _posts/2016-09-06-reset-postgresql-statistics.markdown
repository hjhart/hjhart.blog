---
title: "View and reset PostgreSQL query statistics"
layout: post
category: 
date: 2016-09-06 14:54:00 PDT
comments: true
---

<span class='newthought'>When trying to understand how to alleviate pressure </span> from our PostgreSQL instances, we were using a query like this:

```sql
psql=# select query, calls, to_char(total_time/(60*60), '999,999,9999,999') as "Cumulative Time (hrs)", rows, to_char(total_time/calls, '999.999') as per_call_ms from pg_stat_statements order by total_time desc limit 12;
```

Which displays the 12 most expensive queries that postgres has spent time doing. It's pretty useful for finding out where you should be putting indexes, or where you can change your application code to alleviate the pressure.                                                                                                                                                          
                                                                                                                                                          
```sql                                                                                                                                                          
                                 query                                         |    calls    | Cumulative Time (hrs) |    rows    | per_call_ms
-------------------------------------------------------------------------------+-------------+-----------------------+------------+-------------
 SELECT  "posts".* FROM "posts"  WHERE "posts"."crush_id" = ? LIMIT ?          |   256078900 |          1510,418     |   35940202 |   21.234
 UPDATE "posts" SET "state" = ?, "updated_at" = ? WHERE "posts"."id" = ?       |    48610033 |          1086,287     |   48610033 |   80.449
 etc... etc...
(12 rows)

```

Once you've optimized all the things on the `posts` table and deployed out new code, you will want to get those statistics updated. I had a hard time figuring this one out, so I'm leaving it here for myself for later:

```sql
select pg_stat_statements_reset()
```
