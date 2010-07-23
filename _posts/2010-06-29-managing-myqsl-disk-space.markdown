--- 
category: sysadmin
layout: post
title: Managing MySQL Disk Space
---
<img style="margin-left: 0px; margin-right: 10px;" title="logo-mysql-110x57" src="http://developers.outright.com/files/2010/06/logo-mysql-110x57.png" alt="logo-mysql-110x57" width="120" align="left" />We have hundreds of gigabytes allocated for database partitions, and yet the database seemed hungry still - that is, <a href="http://www.nagios.org/">Nagios</a> kindly informed us of a low-disk-space condition. Sweet - but what's causing it?

My first intuition was to free space that had been allocated to a bunch of deleted rows in a table we'd recently purged of less-useful data, using OPTIMIZE TABLE.  Sure enough, it did clear up some space.  Like, 2 percent.  I was looking to get to 50% free, though.

After more investigation, I found that we hadn't configured Mysql to automatically purge binary logs.  After adding the purge setting, *poof*, 60% free.  Perfect!

<a href="http://dev.mysql.com/doc/refman/5.1/en/purge-binary-logs.html">http://dev.mysql.com/doc/refman/5.1/en/purge-binary-logs.html</a>

Note the caveats about deleting binary logs that your slave server hasn't yet processed.  That's a reason to be cautious when you use this.

If you don't use a master/slave configuration, you can disable binary logs entirely.  But a master/slave configuration is an awfully good idea - a topic for another day.
