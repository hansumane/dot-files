#!/bin/sh

fdate()
{
    date +"%d/%m %H:%M"
}

flayout()
{
    if [ "$(xset -q | grep LED | awk '{print $10}')" == '00000000' ]
    then
        echo 'EN'
    else
        echo 'RU'
    fi
}

generate_content()
{
    echo " [  $(flayout) ] [  $(fdate) ] "
}

while true
do
    xsetroot -name "$(generate_content)"
    sleep 2s
done
