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

# 1250 ocean just is not there properly
select closed_roll_year, property_location,number_of_stories  from property where property_location like '%1150 OCEAN%';
select closed_roll_year, property_location,number_of_stories  from property where property_location like '%1250 OCEAN%';

select max(closed_roll_year), parcel_number  from property group by parcel_number

# use subselct to eliminabte duplicate rows
select property_location,number_of_stories  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and p.property_location like '%302 SILVER%';

# count of six storey buildings by neighborhood
select count(property_location), assessor_neighborhood  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and 
cast(p.number_of_stories as tinyint) = 6 
group by assessor_neighborhood order by count(property_location) desc;

# count of 6,7 storey buildings by neighborhood
select count(property_location), assessor_neighborhood  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and 
cast(p.number_of_stories as tinyint) > 5  and
cast(p.number_of_stories as tinyint) < 8 
group by assessor_neighborhood order by count(property_location) desc;


# check some outlier addresses
select property_location, assessor_neighborhood  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and 
cast(p.number_of_stories as tinyint) > 5  and
cast(p.number_of_stories as tinyint) < 8;


# 6 storey buildings
select property_location  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number and 
cast(p.number_of_stories as tinyint) = 6;

# bad join but runs
select p.property_location  from address a ,property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number 
and p.lot = a.lot 
and p.block = a.block 
and p.parcel_number = a.parcel_number and 
cast(p.number_of_stories as tinyint) = 6;

# try to fix inner join
select property_location  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number 
where
cast(p.number_of_stories as tinyint) = 6;

# 
select property_location  from address a, property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number 
where
p.lot = a.lot 
and p.block = a.block 
and p.parcel_number = a.parcel_number and 
cast(p.number_of_stories as tinyint) = 6;

# impala cant do this
select property_location  from property p  where (p.parcel_number, p.closed_roll_year) in (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number where p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number );

select property_location  from property p  where p.parcel_number, p.closed_roll_year in (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number where p.closed_roll_year = sub.year
and p.parcel_number = sub.parcel_number );


# use 2 tables
create table property6 as 
select property_location, lot, p.parcel_number, block  from 
property p  
inner join ( select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub 
on p.closed_roll_year = sub.year and 
p.parcel_number = sub.parcel_number and
cast(p.number_of_stories as tinyint) = 6


select * from property6 p, address a where
p.lot = a.lot 
and p.block = a.block
and p.parcel_number = a.parcel_number;



# 11000 ocena hacking

# gets 2
select closed_roll_year, property_location,number_of_stories  from property where property_location like '%1100 OCEAN%'

# gets 0
select property_location  from property p  inner join (
select max(closed_roll_year) as year, parcel_number  from property group by parcel_number) sub on p.closed_roll_year = sub.year
and p.property_location like '%1100 OCEAN%' and
cast(p.number_of_stories as tinyint) >= 4 and
cast(p.number_of_stories as tinyint) <= 5;

