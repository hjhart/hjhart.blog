---
layout: post
title: "Compiling PHP on SmartOS"
summary: "Compiling PHP on SmartOS is a pain in the neck. Here's how I did it."
---


Recently I was trying to compile PHP 5.5.13 from source on SmartOS. While running `./configure --prefix=/opt/local/php --enable-cli --enable-zip --enable-cgi` I ran into this error: 

```bash
checking libxml2 install dir... no
checking for xml2-config path...
configure: error: xml2-config not found. Please check your libxml2 installation.
```

SmartOS keeps it's xml2-config bin in /opt/local/bin (like many other binaries), but `configure` doesn't check there. Specify `--with-libxml-dir=/opt/local/` to ensure that libxml2 will be found.

On the next run, since I'm installing PHP with the zip extension (a lot of wordpress plugins use zip files) I received this error: 

```bash
error: zip support requires ZLIB. Use --with-zlib-dir=<DIR> to specify prefix where ZLIB include and library are located
```

I quickly checked to see if I had zlib installed on the machine: 

```bash
$ pkgin list | grep zlib
zlib-1.2.8nb1        General purpose data compression library
```

And then investigated where it was installed with `pkgin pkg-build-defs zlib` :

```
CFLAGS=-O2    -I/opt/local/include -I/usr/include -pipe -O2
...
PROVIDES=/opt/local/lib/libz.so
PROVIDES=/opt/local/lib/libz.so.1
PROVIDES=/opt/local/lib/libz.so.1.0.2
```

Cool! So it looks like the C libraries were installed into /opt/local/lib, and the include files were installed into /opt/local/include. That means we can set the `--with-zlib-dir` to `/opt/local`.

After a few more iterations, I ended up with a robust but **working** ./configure command.

The configure command that finally did the deed for me on SmartOS Image 14.1 was the following: 

```
./configure --with-config-file-path=/opt/local/etc --with-config-file-scan-dir=/opt/local/etc/php.d --sysconfdir=/opt/local/etc --localstatedir=/var --without-mysql --without-iconv --without-pear --disable-posix --disable-dom --disable-opcache --disable-pdo --disable-json --enable-cgi --enable-mysqlnd --enable-xml --with-libxml-dir=/opt/local --enable-ipv6 --with-openssl=/opt/local --with-readline=/opt/local --enable-dtrace --prefix=/opt/local --build=x86_64-sun-solaris2.11 --host=x86_64-sun-solaris2.11 --mandir=/opt/local/man --without-sqlite3
```

Hope that command comes in handy for the next poor fella trying to compile PHP on SmartOS.