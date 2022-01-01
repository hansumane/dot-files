#!/bin/sh

fdate(){
    date +"%d/%m %H:%M"
}

generate_content(){
        echo "  |  $(fdate)  |  "
}
 
while true; do
    xsetroot -name "$(generate_content)"
    sleep 5s
done
