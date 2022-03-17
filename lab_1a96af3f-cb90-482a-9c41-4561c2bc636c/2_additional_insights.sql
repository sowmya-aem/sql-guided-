/* VENUE 

/* Question: What is the RAND() column in this table? Doesit have any relation to the venues ? 
/* Answer : RAND() column in this table seems like just a random number . No, it does not have any relation to the venue table or other columns in the table.

/* Question: Which city has the most venues ? 
/* Answer : New York has the most venues - over 50% of all venues are in NYC. The city column needs to be cleaned further. In a small number of cases, city names are spelled slightly differently sometimes and need to be standardized for better analysis (example: "New York" is sometimes "New York City")
			   
SELECT 
    city, 
    COUNT(venue_id) AS number_of_venues
FROM venue_
GROUP BY city
ORDER BY number_of_venues DESC; 


/* Question : Which zip code has the most venues? What neighbourhood is this ?
/* Answer : Grouping venue data by zip indicates that most common zipcodes are "-1" and "1" which is probably invalid data or error. However, checking the address_1 column grouping indicates that Central Park neighborhood of New York has the highest number of venues (=24) of all other neighborhoods. 

SELECT 
    zip, 
    COUNT(venue_id) AS number_of_venues
FROM venue_
GROUP BY zip
ORDER BY number_of_venues DESC; 
               
			SELECT 
				address_1,  
                city, 
                zip, 
                COUNT(venue_id) as nvenues
			FROM venue_
			GROUP BY address_1, city, zip
			ORDER BY nvenues DESC;              
			

/* -----------------------------------------------------------------------------------------------------

TABLE GRP 

/* Question: What is the longest running group on LetsMeet ? How many members are there ? 
/* Answer: 'New York City Poker Group' is the longest running group (created 8th Oct 2002). It has 1797 members.

SELECT 
    *
FROM
    grp
ORDER BY created;

 
/*Question: What does public_limited mean? How many groups are public_limited ?
/*Answer: The visibilty column indicates if a group membership is "public"/"public_limited"/"members". There are 514 groups are there in public_limited.

SELECT 
    visibility, 
    COUNT(group_id) AS ngroups
FROM grp
GROUP BY visibility;


/* Question: You notice the who column. What values comeup most frequently in the who column ?
/* Answer : Members (count=1643) and Friends (count=29) are the top 2 values in the "who" column

SELECT 
    who, 
    COUNT(group_id) AS ngrp
FROM grp
GROUP BY who
ORDER BY ngrp DESC;
				

Other insights: The rating column indicates the group rating on a scale of 0 to 5 - 745 groups are rated 5 out of 5 however 1548 groups have 0.00 rating (which is likely a missing data rather than bad ratings)

SELECT 
    rating, 
    COUNT(group_id) AS ngrp
FROM
    grp
GROUP BY rating
ORDER BY rating DESC;

/* ----------------------------------------------------------

GRP_MEMBER 

SELECT 
    *
FROM
    grp_member;

/* Question Who was the first LetsMeet member that is still active? What member is a part of the most groups? 
/* Answer :  Christine is the first member who is active since Apr 14 2003. There are 7 members (Sam, Steve, Kaushik, Nitin, Lucy, Ana and Huang) each of whom belong to 7 groups (most in this table).

SELECT 
    member_name, 
    member_status, 
    joined,
    group_id
FROM
    grp_member
WHERE
    member_status = 'active'
ORDER BY joined;


SELECT 
    member_id,
    member_name, 
    COUNT(group_id) AS ngroups
FROM
    grp_member
GROUP BY member_id , member_name
ORDER BY ngroups DESC;


/* Can you use this table to determine the total number of members ? why or why not?

Answer:  There are 39980 unique members who belong to at least one group. But, there might be members who are not part of any group currently which is not counted from this table. 

SELECT DISTINCT
    member_id
FROM
    grp_member
WHERE
    member_status = 'active';

Other insights: From the member_status column, we find that out of the 39980 members, 39941 members are active and 39 are 'prereg'

	SELECT 
    member_status, 
    COUNT(member_id)
FROM
    (SELECT DISTINCT
        member_id, 
        member_status
    FROM
        grp_member) a
GROUP BY member_status;

/* -------------------------------------------------------------------------------------------------------------

CITY 

/* What is the ranking colmn? Is it providing any additional useful information about cities?
/* Answer : The ranking column seems uninformative. Even for a single city like New York, the rank is 0 or 32 or 109 etc which seems unrelated to city table or other columns in the table.

/* Other insights: The distance column also seems not very useful in this table. However SFO has the lowest distances and New york has the largest indicating perhaps the distance of city from San Francisco itself. 

SELECT * 
FROM 
city; 

DESCRIBE city ;

/* ---------------------------------------------------------------------

EVENT :

/* Question: What is the average duration of all events? In minutes?Hours ?
/* Answer : The avearge duration of all events is 179.48 minutes. This equates to roughly 3 hours .

/* Question: Which venue is the most popular and how many events were held there ?
/* Answer: venue_id # '24102474' ("The Ainsworth" in NYC) is most popular and had 279 events held there so far.

/* Other insights: columns "why" always has values of "not_found". Column "event_status" is always "upcoming". Perhaps, these columns are not very informative currently. 

				 SELECT * FROM event ;
				 
				 DESCRIBE event ;
				 
				SELECT 
					avg(duration) / 60
				FROM event ;


SELECT 
    *
FROM
    (SELECT 
        venue_id, COUNT(event_id) AS nevents
    FROM event
    GROUP BY venue_id
    ORDER BY nevents DESC) e
        LEFT JOIN
    venue_ v ON e.venue_id = v.venue_id;



SELECT 
    event_status, 
    COUNT(event_id) AS nevents
FROM event
GROUP BY event_status;
                
                
/*-------------------------------------------------------------
Category :

SELECT * FROM category ;

DESCRIBE category ; 

/*Question: How can you combine the catgory data with other data to determine the most popular categories ?
/* Answer: we can join category with grp table on category_id column in order to determine the most popular category. The five categories that contain the most groups are Tech , Career & Business ,Socializing , Health & Wellbeing , Language & Ethnic Identity.

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
                     
