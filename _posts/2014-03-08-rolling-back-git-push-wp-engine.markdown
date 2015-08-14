---
layout: post
title: "Rollback commits in WPEngine"
summary: "Rolling back to a specific commit using the Git Push feature for WPEngine"
comments: true
---

To push an arbitrary git commit from your git repository to WPEngine, you can issue this simple command:

```bash
git push —force production fd35212b59f1d302dc598abab0849c429fa251e9:master
```

This will force the git server on WPEngine to take the revision (in this case, `fd35212b59f1d302dc598abab0849c429fa251e9`) your git client is sending it. Perfect for rolling back a shitty commit to master.

Also, this works for arbitrary reflogs, so a branch, a ref, or a tag would be perfectly acceptable in this situation.