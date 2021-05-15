#!/bin/bash

# ps5 digital edition
amazonukdig='https://www.amazon.co.uk/dp/B08H97NYGP'

# ps5 standard edition
amazonukstd='https://www.amazon.co.uk/dp/B08H95Y452'

check_amazon() {
    versions="$@"

    for version in $versions; do
        status=$(curl -s "$version" -H 'User-Agent: Mozilla/5.0 (X11; Linux i686; rv:88.0) Gecko/20100101 Firefox/88.0' \
        | grep -i "div id=\"availability\"" -A 10 | sed -n '7 p')

        if [ "$status" != "Currently unavailable." ]; then
            echo "AVAILABLE!"
        else
            echo "$(date):out of stock"
        fi
    done
}

check_amazon "$amazonukdig $amazonukstd"