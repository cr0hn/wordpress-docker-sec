#!/usr/bin/env bash

random_strings() {
    local result=$1
    local V=$(echo "" | awk 'BEGIN {for (i=0;i<=rand()*20;i++){printf " "}}')
    eval $result="'$V'"
}


for i in twentyfifteen twentyseventeen twentysixteen; do
    random_strings SPACES

    #
    # Change signature
    #
    echo $SPACES >> /var/www/html/wp-content/themes/$i/style.css

    #
    # Remove versions
    #
    cat /var/www/html/wp-content/themes/$i/style.css | grep -iv version | grep -iv "theme name" | grep -iv "theme uri"| grep -iv "text domain"| grep -iv "author uri"| grep -iv "author" | grep -iv "tags" | grep -iv "description" > /tmp/kkk.txt
    mv /tmp/kkk.txt /var/www/html/wp-content/themes/$i/style.css
    chown www-data:www-data /var/www/html/wp-content/themes/$i/style.css
done

