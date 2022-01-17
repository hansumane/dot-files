#!/bin/sh

kill "$(ps -aux | grep 'sbar' | grep '/bin/sh' | awk '{print $2}')";
if [ ! $? == 0 ]; then echo 'Error! Process is not running!'; fi;
