STR1=$(head -1 Assessor_Historical_Secured_Property_Tax_Rolls.csv | sed 's/ /_/g' | sed 's/-/_/g')

CREATE="create table property ( $(echo $STR1 , | sed 's/,/ string,/g') dummy int ) row format delimited fields terminated by \",\";"

impala-shell.sh -q "$CREATE"

