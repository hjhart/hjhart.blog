---
title: "Troubleshooting an upgrade from postgres 9.2 to 9.4"
layout: post
category: 
date: 2016-06-28 19:46:49 PDT
comments: true
---

<span class='newthought'>When attempting to upgrade from Postgres 9.2.8 to 9.4.5</span> I encountered a bizarre error that was difficult to troubleshoot:

```
pg_restore: creating VIEW tables
pg_restore: [archiver (db)] Error while PROCESSING TOC:
pg_restore: [archiver (db)] Error from TOC entry 1206; 1259 10190710 VIEW tables postgres
pg_restore: [archiver (db)] could not execute query: ERROR:  column pg_class.reltoastidxid does not exist
LINE 19:             ELSE ( SELECT "pg_class"."reltoastidxid"
                                   ^
    Command was:
-- For binary upgrade, must preserve pg_type oid
SELECT binary_upgrade.set_next_pg_type_oid('10190712'::pg_catalog.oid);

```

I found a message in the postgresql.org message board [here][postgres-forums], but there were no answers posted. Also – it doesn't seem possible to respond to that mailing-list....
 
The solution ended up being to drop the pg_repack extension, then performing the pg_upgrade after it was dropped.

This got rid of the problematic views that couldn't successfully recreate themslves through the respective `pg_dump` and `pg_restore` commands that `pg_upgrade` performs.

The upgrade worked successfully. We don't use pg_repack anymore, so I was just able to uninstall and upgrade, but the postgresql `pg_upgrade` documentation even states if the problem is a contrib module, it may need to be uninstalled, then postgresql upgraded, then the extension reinstalled again. This appears to have been the case.

[postgres-forums]: https://www.postgresql.org/message-id/flat/A68AE592-FAA0-4A63-A3FF-967895A0E3BF%40classmates.com#A68AE592-FAA0-4A63-A3FF-967895A0E3BF@classmates.com
