#!/bin/bash
function print {
  echo "start thread ..."
  # doing something
  sleep 3
  echo "stop thread ..."
}

fifo_filename="/tmp/$$.fifo"
mkfifo $fifo_filename
exec 6<>$fifo_filename
rm $fifo_filename

thread_num=15
for((i=0;i<$thread_num;i++))
do
  echo 
done >&6

for((i=0;i<50;i++))
do
  read -u6
  {
    print && echo "function print is finished" || echo "function print is error" 
    echo >&6
  }&
done

wait
exec 6>&-

exit 0
