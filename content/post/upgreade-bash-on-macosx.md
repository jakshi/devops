+++
date = "2019-06-14T10:23:00+07:00"
description = ""
draft = false
markup = "md"
title = "Upgrade bash on mac os x"
categories = ["announcement"]
truncate = false
+++

# Intro

MacOS X has old 3.x bash.
I found it's very uncomfortable, as it doesn't fit >4.x bash on most linux host.
So you need to remember where do you want to run your scripts:

* on linux with bash >4.x?
* on mac os x with bash 3.x?

So - why not upgrade.
I found comprehenisve article here: [Upgrading Bash on macOS](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba)

And now:

```
$ bash --version
GNU bash, version 5.0.2(1)-release (x86_64-apple-darwin18.2.0)
Copyright (C) 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

Much better.
