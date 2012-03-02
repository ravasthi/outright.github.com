---
title: "Compiling REE on Mac OS 10.7 /ext/purelib.rb:2: BUG Segmentation fault"
author: trobrock
layout: post
---

I ran into an interesting issue today, I was trying to reinstall my rvm after messing it up with a script last week. The reinstall wen fine until I needed to reinstall ree via `rvm install ree`

This led to this error:
<pre>
  /ext/purelib.rb:2: BUG Segmentation fault
</pre>

After some digging I realized this was some issue with the gcc compiler being used after an update of Xcode. The solution:
<pre>
  CC=/usr/bin/gcc-4.2 rvm install ree --force
</pre>

Thanks to the solution here: [http://comments.gmane.org/gmane.comp.lang.ruby.enterprise/174](http://comments.gmane.org/gmane.comp.lang.ruby.enterprise/174)
