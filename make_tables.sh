# create date
# https://docs.cloudera.com/documentation/enterprise/6/6.3/topics/impala_txtfile.html

PROPERTY=Assessor_Historical_Secured_Property_Tax_Rolls.csv
PROPERTY2=Property.csv
PROPERTY_TABLE=property
STR1=$(head -1 $PROPERTY | sed 's/ /_/g' | sed 's/-/_/g')
# remove header from data
LEN=$(wc -l $PROPERTY | awk '{print $1}')
NEWLEN=$(($LEN -1))
tail -$NEWLEN $PROPERTY > $PROPERTY2

CREATE="create table $PROPERTY_TABLE ( $(echo $STR1 , | sed 's/,/ string,/g') dummy int ) row format delimited fields terminated by \",\";"

impala-shell.sh -q "drop table if exists $PROPERTY_TABLE"
impala-shell.sh -q "$CREATE"

hdfs dfs -put $PROPERTY2 /test-warehouse/$PROPERTY_TABLE
hdfs dfs -ls /test-warehouse/$PROPERTY_TABLE

impala-shell.sh -q "refresh $PROPERTY_TABLE"
impala-shell.sh -q "select count(*) from $PROPERTY_TABLE"


ADDRESS=Addresses_with_Units_-_Enterprise_Addressing_System.csv 
ADDRESS2=Address.csv
ADDRESS_TABLE=address
STR1=$(head -1 $ADDRESS | sed 's/ /_/g' | sed 's/-/_/g')
# remove header from data
LEN=$(wc -l $ADDRESS | awk '{print $1}')
NEWLEN=$(($LEN -1))
tail -$NEWLEN $ADDRESS > $ADDRESS2

CREATE="create table $ADDRESS_TABLE ( $(echo $STR1 , | sed 's/,/ string,/g') dummy int ) row format delimited fields terminated by \",\";"

impala-shell.sh -q "drop table if exists $ADDRESS_TABLE"
impala-shell.sh -q "$CREATE"

hdfs dfs -put $ADDRESS2 /test-warehouse/$ADDRESS_TABLE
hdfs dfs -ls /test-warehouse/$ADDRESS_TABLE

impala-shell.sh -q "refresh $ADDRESS_TABLE"
impala-shell.sh -q "select count(*) from $ADDRESS_TABLE"





