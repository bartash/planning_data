# create date
# https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/impala_txtfile.html

PROPERTY=Assessor_Historical_Secured_Property_Tax_Rolls.csv
PROPERTY2=Property.csv
STR1=$(head -1 $PROPERTY | sed 's/ /_/g' | sed 's/-/_/g')

# remove header from data
LEN=$(wc -l $PROPERTY | awk '{print $1}')
NEWLEN=$(($LEN -1))
tail -$NEWLEN $PROPERTY > $PROPERTY2


CREATE="create table property ( $(echo $STR1 , | sed 's/,/ string,/g') dummy int ) row format delimited fields terminated by \",\";"

impala-shell.sh -q "drop table if exists property"
impala-shell.sh -q "$CREATE"


hdfs dfs -put $PROPERTY2 /test-warehouse/property 
hdfs dfs -ls /test-warehouse/property


impala-shell.sh -q "refresh property"
impala-shell.sh -q "select count(*) from property"
