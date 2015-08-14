---
layout: post
title: "HALog is for calculating percentiles"
summary: "Herein lies some debugging with some issues using HALog, where no lines were being parsed."
comments: true
---

So, I had some issues parsing my halog files

```bash
time ./halog -st < /var/log/haproxy.log
424784 lines in, 0 lines out, 424784 parsing errors
real    0m0.198s
user    0m0.166s
sys     0m0.030s
```

That's a lot of parsing errors. Not one single good line out!

Our log files looked like this:

```
2014-09-26T11:45:02-07:00 10.100.17.240 haproxy[70430]: 10.100.17.60:5532 [26/Sep/2014:11:45:02.773] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:02-07:00 10.100.18.27 haproxy[48948]: 10.100.104.215:62749 [26/Sep/2014:11:45:02.537] admin admin/<NOSRV> 238/-1/-1/-1/238 503 212 - - LR-- 130/0/0/0/0 0/0 "GET /favicon.ico HTTP/1.1"
2014-09-26T11:45:02-07:00 10.100.17.239 haproxy[1643]: 10.100.17.70:1859 [26/Sep/2014:11:45:02.922] tea tea/tea-app001.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:02-07:00 10.100.17.240 haproxy[70430]: 10.100.17.61:11508 [26/Sep/2014:11:45:02.953] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:03-07:00 10.100.17.239 haproxy[1643]: 10.100.17.62:2634 [26/Sep/2014:11:45:03.106] tea tea/tea-app001.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:03-07:00 10.100.17.239 haproxy[1643]: 10.100.17.59:24674 [26/Sep/2014:11:45:03.136] tea tea/tea-app001.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:03-07:00 10.100.17.240 haproxy[70430]: 10.100.17.69:7808 [26/Sep/2014:11:45:03.155] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:03-07:00 10.100.17.240 haproxy[70430]: 10.100.17.59:59204 [26/Sep/2014:11:45:03.191] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:03-07:00 10.100.17.239 haproxy[1643]: 10.100.17.60:58474 [26/Sep/2014:11:45:03.547] tea tea/tea-app001.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-26T11:45:03-07:00 10.100.17.239 haproxy[1643]: 10.100.17.61:59542 [26/Sep/2014:11:45:03.553] tea tea/tea-app001.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
```


When I changed the dates to look like this:

```
2014-09-25 01:01:42 07:00 10.100.17.240 haproxy[70430]: 10.100.17.59:21444 [26/Sep/2014:01:01:42.049] tea tea/tea-app002.prod 0/0/0/0/1 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-25 01:01:42 07:00 10.100.17.239 haproxy[1643]: 10.100.17.62:43604 [26/Sep/2014:01:01:42.116] tea tea/tea-app001.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-25 01:01:42 07:00 10.100.17.240 haproxy[70430]: 10.100.17.62:42645 [26/Sep/2014:01:01:42.232] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-25 01:01:42 07:00 10.100.17.240 haproxy[70430]: 10.100.17.70:61065 [26/Sep/2014:01:01:42.282] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-25 01:01:42 07:00 10.100.18.28 haproxy[68195]: 10.100.104.199:59735 [26/Sep/2014:01:01:42.189] admin admin/<NOSRV> 201/-1/-1/-1/201 503 212 - - LR-- 1/0/0/0/0 0/0 "GET /favicon.ico HTTP/1.1"
2014-09-25 01:01:42 07:00 10.100.17.240 haproxy[70430]: 10.100.17.60:18221 [26/Sep/2014:01:01:42.516] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-25 01:01:42 07:00 10.100.17.239 haproxy[1643]: 10.100.17.61:32228 [26/Sep/2014:01:01:42.550] tea tea/tea-app001.prod 0/0/0/1/1 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-25 01:01:42 07:00 10.100.17.240 haproxy[70430]: 10.100.17.61:37975 [26/Sep/2014:01:01:42.568] tea tea/tea-app002.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
2014-09-25 01:01:42 07:00 10.100.17.239 haproxy[1643]: 10.100.17.60:61821 [26/Sep/2014:01:01:42.590] tea tea/tea-app001.prod 0/0/0/0/0 200 125 - - CL-- 2/0/0/0/0 0/0 "GET /status_check HTTP/1.0"
```

Everything worked fine.  See the difference? I replaced the timestamp formatted like this: `2014-09-26T11:45:02-07:00` with three separate space delimited fields: date, time, and zone. The output looked like this:


```
85.0 3844 0 0 1 0
90.0 4070 0 0 1 0
91.0 4115 0 0 1 0
92.0 4161 0 0 1 0
93.0 4206 0 0 1 0
94.0 4251 0 0 1 0
95.0 4296 0 0 1 0
96.0 4342 0 1 1 0
97.0 4387 0 3 1 0
98.0 4432 0 5 2 0
98.1 4437 0 5 2 0
98.2 4441 0 6 2 0
98.3 4446 0 6 2 0
98.4 4450 0 6 2 0
98.5 4455 0 6 2 0
98.6 4459 0 6 2 0
98.7 4464 0 7 2 0
98.8 4468 0 7 2 0
98.9 4473 0 7 2 0
99.0 4477 0 7 2 0
99.1 4482 0 8 2 1
99.2 4486 0 8 2 1
99.3 4491 0 8 2 1
99.4 4495 0 8 2 1
99.5 4500 1 9 5 1
99.6 4504 2 9 8 1
99.7 4509 2 9 9 1
99.8 4513 4 9 11 1
99.9 4518 6 10 15 4
100.0 4523 9 1002 42 10
37634 lines in, 4523 lines out, 1 parsing errors

```

Good luck with HALog!