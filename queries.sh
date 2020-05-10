select count(*) from property p, address a 
where 
p.block = a.block and 
p.lot = a.lot and 
p.parcel_number = a.parcel_number;

select count(*) from property where cast(number_of_stories as tinyint) >  10;
select count(*) from property where cast(number_of_stories as tinyint) >  50;
select property_location,number_of_stories  from property where cast(number_of_stories as tinyint) >  60;
select property_location,number_of_stories  from property where cast(number_of_stories as tinyint) = 61;

select count(property_location),assessor_neighborhood from property 
where cast(number_of_stories as tinyint) = 7 
group by assessor_neighborhood order by count(property_location) desc; 

select count(property_location),assessor_neighborhood from property 
where cast(number_of_stories as tinyint) = 6 
group by assessor_neighborhood order by count(property_location) desc; 


# 555 California
select property_location,number_of_stories  from property where cast(parcel_number as int)  = 0259027;


# 525 Market
select property_location,number_of_stories  from property where cast(parcel_number as int)  = 3708056;

# 302 silver
select property_location,number_of_stories  from property where property_location like '%302 SILVER%';

select max(closed_roll_year), parcel_number  from property group by parcel_number

# use subselct to eliminabte duplicate rows
select property_location,number_of_stories  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and p.property_location like '%302 SILVER%';

select count(property_location), assessor_neighborhood  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and 
cast(p.number_of_stories as tinyint) = 6 
group by assessor_neighborhood order by count(property_location) desc;





