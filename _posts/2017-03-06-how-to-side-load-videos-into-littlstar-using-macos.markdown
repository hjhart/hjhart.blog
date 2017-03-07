---
title: "How to Side Load Videos into Littlstar using MacOS"
layout: post
date: 2017-03-06 23:39:29 PST
summary: "Side loading 3D SBS videos into Littlstar media player on the PS4 can be a bit tricky. Get help here."
comments: true
---

<span class='newthought'>Alright, let's get right into it. You're trying to side load</span> some videos on a USB stick from MacOS or OSX into Littlstar media player. For the sake of simplicity, we're going to erase the entire contents of your USB drive in this tutorial. Be prepared to lose all data on that drive!

Step 1: Open up Disk Utility. Under `Applications > Utilities > Disk Utilities`. It looks like this.

<img src="/images/littlstar/disk_utility.png" alt="Disk Utility"/>

Step 2: Grab your USB Stick, plug it in. I just bought [this USB stick][usb_stick] specifically for side loading. At $10 for 32 GB, it's a pretty hard deal to beat.

Step 3: Let's start formatting the drive. Click on the drive you just plugged in on the left column, and click the "Erase Button".

<img src="/images/littlstar/erase_clicks.png" alt="Erase Clicks"/>

Step 4: Format the drive. Your name can be anything you want, but the `ExFat` and `Master Boot Record` settings are important.

<img src="/images/littlstar/erase_settings.png" alt="Erase Settings"/>

I've noticed that GUID Partition does NOT work. I haven't had success with MS-DOS (FAT) either.

Step 5: Ignore this error if you see it. Click "Done" and repeat Step 4 again.

<img src="/images/littlstar/error_message.png" alt="Oh noes! Erasing failed."/>

Step 6: Amaze in the glory that is a success message.

<img src="/images/littlstar/success_message.png" alt="Success!"/>

Step 7: Eject that disk.


Alright, now this part is how I've figured out if things will work or will not work. Turn on your PS4, plug the newly formatted USB drive (without content) into your PS4. Open the Littlstar App. Navigate to your `Library`[^1]. You'll need to have created an account and be logged in. You'll see a message that says "You have not yet downloaded any videos, downloaded videos show here."

<img src="/images/littlstar/littlstar_message.jpg" alt="Littlstar Message!"/>

Now, Littlstar will have tried to create a directory on that USB stick. If it is formatted correctly, the directory will be created. If not, there will be no directory.

Plug your USB drive back into your computer. If the directory called LITTLSTAR has been created on your USB drive, then congratulations! The hard part is over!

<img src="/images/littlstar/created_directory.png" alt="Even more Success!"/>

You can now drag files with the [appropriate naming conventions][naming_conventions] into the `LITTLSTAR` directory.

Good job! Now go enjoy your PSVR.

**Edit:** User /u/hellsfoxes on reddit [pointed out not to load the files][hells_foxes_comment] that look like `._filename_sbs_180.mp4`. Instead, load files that look like `filename_sbs_180.mp4` (note the leading period and underscore). Loading the first style of files will make the app go into an indefinite loading screen.

[hells_foxes_comment]: https://www.reddit.com/r/PSVR/comments/5y1fr0/how_to_side_load_videos_into_littlstar_using_macos/demzpw0/?context=3
[usb_stick]: https://www.amazon.com/gp/product/B013CCTOC2/ref=as_li_ss_tl?ie=UTF8&psc=1&linkCode=ll1&tag=hjhartblog-20&linkId=5d919eca9cadfe6414cb007a3aa11d66
[naming_conventions]: http://docs.littlstar.com/display/CG/PlayStation+VR+Video+Sideloading#PlayStationVRVideoSideloading-HarddriveorUSBflashdrivesetup

[^1]: Hint, if you can't figure out how to get to the "Library" part in Littlstar, press the circle button once or twice.