select property_location,number_of_stories  from property where cast(number_of_stories as tinyint) >= 7 and
cast(number_of_stories as tinyint) <= 8;
