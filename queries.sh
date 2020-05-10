select count(*) from property p, address a 
where 
p.block = a.block and 
p.lot = a.lot and 
p.parcel_number = a.parcel_number;

