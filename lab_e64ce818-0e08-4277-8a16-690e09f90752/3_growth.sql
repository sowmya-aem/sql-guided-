
SELECT 
    *
FROM
    grp_member;

-- 2. total number of members joining each year

SELECT 
    A.YEAR_OF_JOINED, 
    COUNT(A.member_id) as number_of_members
FROM
    (SELECT distinct -- distinct is to drop duplicates in case a member joins more than one group in his first year 
        member_id, 
        member_name, 
        YEAR(MIN(joined)) AS YEAR_OF_JOINED
    FROM
        grp_member
    GROUP BY member_id) A
GROUP BY A.YEAR_OF_JOINED
ORDER BY A.YEAR_OF_JOINED;


-- 3. Rename smaller cities with larger urban areas
    
SET SQL_SAFE_UPDATES =0;

UPDATE grp_member 
SET 
    city = 'Chicago'
WHERE
    city IN ('East Chicago' , 'West Chicago',
        'North Chicago',
        'Chicago Heights',
        'Chicago Ridge',
        'Chicago');
    
UPDATE grp_member 
SET 
    city = 'San Francisco'
WHERE
    city IN ('San Francisco' , 'South San Francisco');
    
UPDATE grp_member 
SET 
    city = 'New York'
WHERE
    city IN ('New York' , 'West New York');

-- 4. The annual growth for the larger geographical areas of chicago, san francisco and new york 

-- chicago
    SELECT 
    A.YEAR_OF_JOINED, 
    COUNT(A.member_id), 
    A.city
FROM
    (SELECT 
        member_id,
            member_name,
            city,
            YEAR(MIN(joined)) AS YEAR_OF_JOINED
    FROM
        grp_member
    WHERE
        city = 'Chicago'
    GROUP BY member_id) AS A
GROUP BY A.YEAR_OF_JOINED
ORDER BY A.city , A.YEAR_OF_JOINED;
    
-- sfo     
   SELECT 
    A.YEAR_OF_JOINED, 
    COUNT(A.member_id),
    A.city
FROM
    (SELECT 
        member_id,
            member_name,
            city,
            YEAR(MIN(joined)) AS YEAR_OF_JOINED
    FROM
        grp_member
    WHERE
        city = 'San Francisco'
    GROUP BY member_id) AS A
GROUP BY A.YEAR_OF_JOINED
ORDER BY A.city , A.YEAR_OF_JOINED;
    
-- nyc
   SELECT 
    A.YEAR_OF_JOINED, 
    COUNT(A.member_id),
    A.city
FROM
    (SELECT 
        member_id,
            member_name,
            city,
            YEAR(MIN(joined)) AS YEAR_OF_JOINED
    FROM
        grp_member
    WHERE
        city = 'New York'
    GROUP BY member_id) AS A
GROUP BY A.YEAR_OF_JOINED
ORDER BY A.city , A.YEAR_OF_JOINED;
    
-- 5. Month by month growth for LetsMeet in the year 2017  

SELECT 
    month_join, COUNT(member_id)
FROM
    (SELECT DISTINCT
        member_id,
            member_name,
            MONTH(MIN(joined)) AS month_join,
            YEAR(MIN(joined)) AS YEAR_OF_JOINED
    FROM
        grp_member
    GROUP BY member_id) A
WHERE
    A.YEAR_OF_JOINED = 2017
GROUP BY month_join
ORDER BY month_join;




    
    
    