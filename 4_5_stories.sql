select property_location,number_of_stories  from property where cast(number_of_stories as tinyint) >= 4 and
cast(number_of_stories as tinyint) <= 5;

