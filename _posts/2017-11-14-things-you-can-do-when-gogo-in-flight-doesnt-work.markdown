---
title: "Things you can do when gogo in flight doesn't work"
layout: post
date: 2017-11-14
comments: true
---

Okay, I've been on this flight for 30 minutes now, and I'm still trying to figure out what is going on.

```
dig gogoinflight.com
# No response

iconfig en0
# Nothing interesting, was trying to find the router.
```

Open up your wireless settings in macOS, find the router. For example, if your IP address is 172.19.131.149, it should look like 172.19.131.2.

```
curl 172.19.131.2
# dy>
Questa pagina dovrebbe rinviarvi subito verso il sito di autenticazione.<p>
curl: (56) Recv failure: Connection reset by peer
Se la ridirezione non avviene, <a href="http://airborne.gogoinflight.com/abp/page/abpDefault.do?REP=127.0.0.1&AUTH=172.19.131.149&CLI=54273&PORT=54272&RPORT="
```

Okay, now lets try going to that website.

```
open http://airborne.gogoinflight.com/abp/page/abpDefault.do?REP=127.0.0.1&AUTH=172.19.131.149&CLI=54273&PORT=54272&RPORT=
open http://airborne.gogoinflight.com/abp/page/abpDefault.do?REP=127.0.0.1&AUTH=172.19.131.149&CLI=54273&PORT=54272
```

It's not working! Why??  Let's try flushing the dns cache.

```
dscacheutil -flushcache
```

dig airborne.gogoinflight.com
# NOTHING!
```

Okay, something is wrong with DNS. Let's remove DNS server (8.8.8.8) from the DNS tab within the wireless settings. Turns out I had it set to 8.8.8.8 manually to avoid my ISPs weird default 404 page rife with advertisements.

Once I removed the default DNS server I started getting that sweet, delicious internet!

So I guess the lesson learned is that DNS goes FIRST. Get DNS working first. If `dig airborne.gogoinflight.com` is returning nothing, you're gonna have a bad time. 

I probably could've diagnosed that by looking closer at my `sudo tcpdump -i en0 -v` command, and now that I have internet it all makes sense. But, if you have problems with gogoinflight, some of those commands may help you!


Also something to note, is that now I am able to `dig`.

The return value is `10.241.151.31`, so if you want to browse to that IP to try and see if DNS is the problem more power to you!
