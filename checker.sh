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
            status=$(curl -s https://www.amazon."$region"/dp/"$version" -H 'User-Agent: Mozilla/5.0 (X11; Linux i686; rv:88.0) Gecko/20100101 Firefox/88.0' \
            | grep -i "div id=\"availability\"" -A 10 | sed -n '7 p')

            if [[ ! "$status" =~ ^(Currently unavailable.|Derzeit nicht verfügbar.)$ ]]; then
                echo "AVAILABLE!"
            else
                echo "$(date):Amazon ""$region"":""$status"""
            fi
        done
    done
}

check_amazon "$amazondig $amazonstd"