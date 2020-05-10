select property_location  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and
cast(p.number_of_stories as tinyint) >= 7 and
cast(p.number_of_stories as tinyint) <= 8;
