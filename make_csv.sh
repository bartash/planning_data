OUT=$1
SQL=$2
TMP=$3
impala-shell.sh  -B < $SQL -o $TMP
echo "Address,City" > $OUT
cat $TMP | cut -c 6- | cut -c -25 | sort -u |\
    awk '{street=$2; addr=$1; gsub ("^0*", "", addr); gsub ("^0*", "", street); print addr, street, $3, $4, $5 }' |\
    sed 's/$/,San Francisco/' >> $OUT
