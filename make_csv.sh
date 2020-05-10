OUT=$1.csv
SQL=$1.sql
TMP=$1.raw
REM=$1.rem
impala-shell.sh  -B < $SQL -o $TMP
echo "Address,City" > $OUT
cat $TMP | tr -d \" | cut -c 6- | cut -c -27 | sort -u |\
    awk '{street=$2; addr=$1; gsub ("^0*", "", addr); gsub ("^0*", "", street); print addr, street, $3, $4, $5 }' |\
    sed 's/$/,San Francisco/' | sed 's/ TE *,/ TERRACE ,/' |\
    grep -v -f $REM >> $OUT

