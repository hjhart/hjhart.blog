---
title: "Let the emojis guide your shell prompt"
layout: post
date: 2015-08-13 23:50:23 PDT
summary: "Shell prompts can be useful if they are configured properly (and let's have some fun while we're at it)."
comments: true

---
<span class='newthought'>Okay, so you're wondering what</span> the hell I'm talking about. Fair enough.

I've got this problem, see, where sometimes I don't know what status code with which my bash utilities exit.  Say I'm trying to add an SSL certificate to `openssl` and it's the first time I've ever run any `openssl` commands. I run the command to add a cert, and it has no output. That's a good thing, right? I successfully just trusted a new OpenSSL certificate, so I can scrape that insecure website now, right?

Wrong.

The certificate wasn't added. It returned a non-zero status code of 255, but I'd never know that, because my shell prompt didn't let me know that. And I'd go on trying to debug `openssl` further because I didn't see any error output!

Well, then I saw the light, and I let the emojis guide my `PS1` variable.

Here is what our `PS1` looks like at on my workstation (the idea was actually complements of [indirect][indirect_github], so thank you, André)

<img src="/images/shell_prompt.png" alt="Beautiful shell prompt that we made at wanelo"/>

We show a happy, healthy, loving heart for anything that exits with a status code of zero. We show a broken, horribly pained heart for anything that exits non-zero (see the grep command).

Simple!

Now, keep in mind we have a two-line prompt, and we use [bash-it][bash-it] with our shell prompt. The two-line prompt is because emojis do not have monospaced compatible fonts. An emoji sometimes will take the width of two characters, sometimes one, and anywhere in between. So it will inevitably look like shit.

So, when you're having fun with emojis in your shell prompts make sure you do so responsibly. Put it on another line than the one you type.

Here's a link to our [bash-it theme][bash-it-theme], if you wanna use it. Enjoy!


[indirect_github]: https://github.com/indirect
[bash-it]: https://github.com/Bash-it/bash-it
[bash-it-theme]: https://github.com/wanelo/bash-it/blob/7c1ecce354da0c2fbef8c7d365c754d934aff585/themes/wanelo/wanelo.theme.bash "wanelo's bash-it theme"

