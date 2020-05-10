# buid the csv files
impala-shell.sh  -B < 6_stories.sql -o 6_stories.raw
cat 6_stories.raw | cut -c 6- | cut -c -25 | sed 's/$/,San Francisco/' 
