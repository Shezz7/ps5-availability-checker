#!/bin/bash

# ps5 digital edition
amazondig='B08H97NYGP'

# ps5 standard edition
amazonstd='B08H95Y452'

check_amazon() {
    versions=$*
    regions="co.uk de"

    for version in $versions; do
        for region in $regions; do
            if [ "$version" == "$amazondig" ]; then
                model='Digital Edition'
            else
                model='Standard Edition'
            fi

            status=$(curl -s https://www.amazon."$region"/dp/"$version" -H 'User-Agent: Mozilla/5.0 (Linux x86_64; rv:88.0) Gecko/20100101 Firefox/88.0' \
            | grep -i "div id=\"availability\"" -A 10 | sed -n '7 p')

            if [[ $status != "Currently unavailable." && $status != "Derzeit nicht verfügbar." ]]; then
                echo "Go get your PS5 here: https://www.amazon.$region/dp/$version" \
                | mail -s "PS5 is in stock!" shehzaadsaifulla@gmail.com
		        echo "$(TZ="Europe/Stockholm" date):Amazon ""$region"":""$model"":AVAILABLE!!!" >> /opt/ps5.log
            else
                echo "$(TZ="Europe/Stockholm" date):Amazon ""$region"":""$model"":""$status""" >> /opt/ps5.log
            fi
            sleep 10
        done
    done
}

check_amazon "$amazondig $amazonstd"