# buid the csv files
OUT=6_stories.csv
TMP=6_stories.raw
impala-shell.sh  -B < 6_stories.sql -o $TMP
echo "Address,City" > $OUT
cat $TMP | cut -c 6- | cut -c -25 |\
    awk '{street=$2; gsub ("^0*", "", street); print $1, street}' |\
    sed 's/$/,San Francisco/' >> $OUT

