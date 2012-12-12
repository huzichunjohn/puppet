#!/bin/bash
cat /dev/null > del.txt
cat /dev/null > ssh_failed.txt
for i in `cat result.txt`
do
  ip=`echo $i|awk -F':' '{print $1}'`
  total=`echo $i|awk -F':' '{print $2}'`
  path=`echo $i|awk -F':' '{print $2}'|awk -F'/' '{print $1"/"$2"/"$3}'`
  file=`echo $i|awk -F':' '{print $2}'|awk -F'/' '{print $4}'`
  sudo ssh -o ConnectTimeout=10 $ip "find /data*/www/$path -name $file -exec du -s {} \;|awk '{if(\$1"x"!="x"){if(\$1/1024<5){print \"$ip:rm -f\",\$2}}else {print \"$ip does not have $file.\";}}'" >> del.txt
  if [ "$?" -ne 0 ];then
    echo "$ip ----> $file  failed."; >> ssh_failed.txt
  else
    echo "$ip ----> $file  successed.";
  fi
done
