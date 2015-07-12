Enable / start cron / crontab on OpenWrt:

```
/etc/init.d/cron start
/etc/init.d/cron enable
```

crontab entry:
```
root@OpenWrt:~# crontab -l
*/5 * * * *   date > /www/P1/cron-date.txt
*/5 * * * *   /root/get-P1-counter.sh
```
