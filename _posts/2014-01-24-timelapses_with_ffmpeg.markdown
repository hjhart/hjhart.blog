---
layout: post
title: "Timelapses and FFmpeg"
summary: "Create timelapses with open source software"
---

### Timelapses and FFmpeg

I'm writing this down so I don't forget it. `-r` forces 24 frames per second.

	ffmpeg -r 24 -q:v 2 -i '%*.jpg' timelapse.mp4

Which will produce something like this

<iframe src="//player.vimeo.com/video/85014164" width="600px" height="400px" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"> </iframe>


Or this!


<iframe src="//player.vimeo.com/video/31471869" width="600px" height="400px" frameborder="0" webkitallowfullscreen="true" mozallowfullscreen="true" allowfullscreen="true"> </iframe>



