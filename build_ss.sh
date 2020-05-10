# buid the csv files
OUT=6_stories.csv
SQL=6_stories.sql
TMP=6_stories.raw
impala-shell.sh  -B < $SQL -o $TMP
echo "Address,City" > $OUT
cat $TMP | cut -c 6- | cut -c -25 | sort -u |\
    awk '{street=$2; addr=$1; gsub ("^0*", "", addr); gsub ("^0*", "", street); print addr, street, $3, $4, $5 }' |\
    sed 's/$/,San Francisco/' >> $OUT

OUT=4_5_stories.csv
SQL=4_5_stories.sql
TMP=4_5_stories.raw
impala-shell.sh  -B < $SQL -o $TMP
echo "Address,City" > $OUT
cat $TMP | cut -c 6- | cut -c -25 | sort -u |\
    awk '{street=$2; addr=$1; gsub ("^0*", "", addr); gsub ("^0*", "", street); print addr, street, $3, $4, $5 }' |\
    sed 's/$/,San Francisco/' >> $OUT

