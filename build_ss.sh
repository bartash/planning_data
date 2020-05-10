# buid the csv files
OUT=6_stories.csv
SQL=6_stories.sql
TMP=6_stories.raw
./make_csv.sh $OUT $SQL $TMP

OUT=4_5_stories.csv
SQL=4_5_stories.sql
TMP=4_5_stories.raw
./make_csv.sh $OUT $SQL $TMP

