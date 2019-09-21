+++
date = "2019-09-21T19:01:00+07:00"
title = "MySQL/Percona 5.7+ and indefinitely growing temporary tables on the disk"
draft = false
categories = ["technical", "mysql", "percona", "systems", "pitfalls"]
postsummary = """
Some time ago I saw an alert in our monitoring, the alert notified us that production MySQL/Percona server had less than 10% of disk space left.  
I was worried and curious - where did a 300 GB of free space go?
And started to investigate the issue.

I found huge MySQL temporary table on the disk.  
Issue was fixed by restarting MySQL server (temporary table become small again).

Incident was serious enough to have a post-mortem.  
And we found out that by default in MySQL/Percona 5.7 temporary tables are growing indefinitely on the disk.  
So how to fix that?  
"""
+++

<!-- more -->

Some time ago I saw an alert in our monitoring,
The alert notified that production MySQL/Percona server had less than 10% of disk space left.  
I was worried and curious - where did a 300 GB of free space go?
And started to investigate the issue.

I found huge MySQL temporary table on the disk.  
Issue was fixed by restarting MySQL server (temporary table become small again).

Incident was serious enough to have a post-mortem.  
And we found out that by default in MySQL/Percona 5.7 temporary tables are growing indefinitely on the disk.  
So how to fix that?  

# MySQL 5.7 and temporary tables on the disk

I should also mention that indefinite growing of temporary tables on the disk didn't happen when we had MySQL/Percona 5.6.  
That gave us some clue to investigate the issue.  
We started to look what's changed between MySQL/Percona 5.6 and 5.7.  

And it appears that in MySQL/Percona 5.7 default storage engine for temporary tables on the disk was changed from MYISAM to InnoDB.  
And InnoDB temporary tables on the disk cannot shrink, they can only grow - till you restart the MySQL server.  

The best possible fix we found - change storage engine for temporary tables on the disk back to MYISAM.  
You just need to add to mysql server config file:

```
[mysqld-5.7]
internal_tmp_disk_storage_engine=MYISAM
```

We did that - and live happily ever after.

# References

* [Internal Temporary Tables in MySQL 5.7](https://www.percona.com/blog/2017/12/04/internal-temporary-tables-mysql-5-7/)
