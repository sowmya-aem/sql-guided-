-- Answer the questions from the Sales team in this file.
-- Active Cities

/*What cities have active members?

/* Answer: There are 10 cities that have active members .
The cities are New York, San Francisco , Chicago, South San Francisco , West New York , Chicago Heights, East Chicago, North Chicago , Chicago Ridge , West Chicago .
				
SELECT 
    city, 
    member_status, 
    COUNT(member_id) AS number_of_members
FROM
    grp_member
WHERE
    member_status = 'active'
GROUP BY city
ORDER BY number_of_members DESC;

/*Are there any cities listed in the city table with no active members? If so , what state are those cities in ?
/* Answer : There are 3 cities listed in the city table with no active members . The cities are New York Mills , Chicago Park . The cities are in NY, MN and CA .


				SELECT 
					*
					FROM
						(SELECT 
						city_id, 
                        state, 
                        city
					FROM
						city) AS c
					LEFT JOIN
					(SELECT 
							city, 
                            member_status, 
                            COUNT(member_id) AS number_of_members
					FROM
						grp_member
					WHERE member_status = 'active'
					GROUP BY city
					ORDER BY number_of_members DESC) AS b ON b.city = c.city
					WHERE b.number_of_members IS NULL;

---ROUGH WORK

SELECT *
from city ;
SELECT * 
FROM grp;

-- Groups

/* How many groups are currently open, waiting for approval , and/or closed?

/* Answer : The  number of groups that are currently open are 3602 .
            The number of groups that are currently waiting for approval are 723 .
            The number of groups that are currently closed are 15.

SELECT 
    join_mode,
    COUNT(group_id) AS number_of_groups
FROM grp
GROUP BY join_mode;




-- Categories
/* What are the five categories that contain the most groups? 
/* Answer : The five categories that contain the most groups are Tech , Career & Business ,Socializing , Health & Wellbeing , Language & Ethnic Identity.
										
SELECT 
    a.category_name, 
    COUNT(group_id) AS number_of_groups
FROM
    (SELECT 
        grp.group_id, 
        grp.category_id, 
        category.category_name
    FROM
        grp
    LEFT JOIN category ON grp.category_id = category.category_id) a
GROUP BY a.category_name
ORDER BY number_of_groups DESC
LIMIT 5;
                                        
/* What are the five categories that contain the least number of groups ?
/* Answer : The five categories that contain the least number of groups are Paranormal, Cars & Motorcycles , Sci-Fi & Fantasy, Lifestyle , Fashion & Beauty.
			
SELECT 
    a.category_name, 
    COUNT(group_id) AS number_of_groups
FROM
    (SELECT 
        grp.group_id, 
        grp.category_id, 
        category.category_name
    FROM
        grp
    LEFT JOIN category ON grp.category_id = category.category_id) a
GROUP BY a.category_name
ORDER BY number_of_groups
LIMIT 5;

-- Members

/* How many members are there ?

/*Answe :  The total members are 43470 

/* What percentage of members are in Chicago ?

/* Answer : The percentage of members that are in chicago is 20.83 %.

SELECT 
    total_members,
    chicago_members,
    chicago_members / total_members * 100 AS chicago_percent
FROM
    (SELECT 
        COUNT(member_id) AS total_members
    FROM
        grp_member) b,
    (SELECT 
        COUNT(member_id) AS chicago_members
    FROM
        grp_member
    WHERE
        city = 'Chicago') c;

--- rough work

SELECT *
FROM (SELECT city_id,state,city from city) as c
left join 
(SELECT 
    city, 
    member_status,
    count(member_id) AS number_of_members
FROM
    grp_member
WHERE
    member_status = 'active'
GROUP BY city
ORDER BY number_of_members DESC) as b
on b.city = c.city
WHERE b.number_of_members IS NULL;





