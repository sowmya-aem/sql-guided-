/*
 STEP 1: Redundant Columns
venue_ : address_2,country,localized_country_name,RAND(),state
grp    : The grp table has no redundant columns 
city   : country,distance,localized_country_name
event  : maybe_rsvp_count,visibility,why,utc_offset,headcount
category : shortname ,sort_name
grp_member : country
*/

-- STEP 2 : Eliminate Redundant Columns 

/*
Removing address_2 column from venue_ table as the values in the column are  all "NULL" 
*/
ALTER TABLE venue_
DROP COLUMN address_2 ; 
/* 
Removing localized_country_name column  from venue_ ,because it exists in the city table already and this column is uninformative column within the table
*/
ALTER TABLE venue_
DROP COLUMN localized_country_name;

/*
Removing distance column from city table as the column is uninformative column within the table
*/
ALTER TABLE city
DROP COLUMN distance;

/*
Removing shortname column from category table,because it does not provide any useful information about the category and it contain repetitive information from the category name column
*/
ALTER TABLE category
DROP COLUMN shortname;
/*
Removing sort_name column from category table , because it does not provide any useful information about the category and it contain repetitive information from the category name column
*/

ALTER TABLE category 
DROP COLUMN sort_name;

-- STEP 3 : Split grp_member Table

/*
 A. Create a new table called group_sign_ups that includes only group_id,member_id and joined 
*/

CREATE TABLE group_sign_ups  AS
SELECT DISTINCT 
       group_id ,
       member_id,
       joined 
FROM grp_member;

/* 
B. Create a new table called members 
*/

CREATE TABLE members AS
SELECT DISTINCT 
      member_id,
      member_name,
      city,
      hometown,
      member_status 
FROM grp_member;

/* 
C. Alter the members table to include a PRIMARY KEY
*/
ALTER TABLE members 
ADD PRIMARY KEY(member_id);

/*
D. Alter the group_sign_ups table to include a foreign key that references the members table
Alter the group_sign_ups table to include a foreign key that references the grp table
*/
ALTER TABLE group_sign_ups  ADD FOREIGN KEY(member_id) REFERENCES members(member_id);
ALTER TABLE group_sign_ups ADD FOREIGN KEY(group_id) REFERENCES grp(group_id);

/* 
DROP the grp_member table
*/
DROP TABLE grp_member;

/*
finally, the updated ERD is saved in "Projects" folder 
*/
     