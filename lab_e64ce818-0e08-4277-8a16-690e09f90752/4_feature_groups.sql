SELECT * FROM grp ;

-- classify rating into categories for all groups

SELECT 
   group_id,
   rating,
    CASE 
  WHEN rating BETWEEN 1 and 1.99 THEN 'VERY LOW'
  WHEN rating BETWEEN 2 and 2.99 THEN 'LOW'
  WHEN rating BETWEEN 3 and 3.99 THEN  'MEDIUM'
  WHEN rating BETWEEN 4 and 4.99 THEN 'HIGH'
  when rating >=5 then '5-STAR'
  WHEN rating = 0 THEN 'NO ratings'
  END AS  ratingCLASS
  FROM grp
  order by rating;
  
  -- number of groups with 5-star rating
  
  SELECT 
    COUNT(group_id) AS rated_as_5
FROM
    grp
WHERE
    rating = 5;
   
 -- % of 5-star groups in groups WITH rating
 
 SELECT 
    (a.rated_as_5 / b.rated) * 100 AS percent_5star
FROM
    (SELECT 
        COUNT(group_id) AS rated_as_5
    FROM
        grp
    WHERE
        rating = 5) AS a,
    (SELECT 
        COUNT(group_id) AS rated
    FROM
        grp
    WHERE
        rating > 0) AS b;
  
 
 -- 2. Top groups with 5-star ratings with highest members
 
SELECT 
    group_id,
    rating, 
    members, 
    group_name
FROM
    grp
WHERE
    rating = 5
ORDER BY members DESC;
 
 -- 3. Top groups with 5-star ratings with highest members (city column included)
 
  SELECT 
    group_id, 
    rating,
    members, 
    group_name, 
    city.city
FROM
    grp,
    city
WHERE
    grp.rating = 5
        AND grp.city_id = city.city_id
ORDER BY members DESC;
 
 -- 4. Top groups with 5-star ratings with highest members (city and category columns included)
  
SELECT 
    group_id, 
    rating, 
    members, 
    group_name, 
    city.city, 
    category.category_name
FROM
    grp,
    city,
    category
WHERE
    grp.rating = 5
        AND grp.city_id = city.city_id AND grp.category_id = category.category_id
ORDER BY members DESC;
