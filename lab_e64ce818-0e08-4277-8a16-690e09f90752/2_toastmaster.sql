SELECT * FROM event ;

 -- Events with word "toastmaster"

SELECT 
    event_id, 
    event_name
FROM
    event
WHERE
    LOWER(event_name) LIKE '%toastmasters%';
  
  -- toastmaster events with city column
  
  SELECT 
    a.event_id,
    a.event_name, 
    city.city
FROM
    (SELECT 
        event_id, 
        event_name, 
        group_id
    FROM
        event
WHERE LOWER(event_name) LIKE '%toastmasters%'
) AS a
        LEFT JOIN
    grp ON a.group_id = grp.group_id
        LEFT JOIN
    city ON grp.city_id = city.city_id;
  
 
 -- count of toastmaster events by city
   SELECT 
   city.city,
   COUNT(a.event_id) AS count_of_events 
   FROM 
   (SELECT
      event_id ,
      event_name,
      group_id
      FROM event  
      WHERE lower(event_name)LIKE '%toastmasters%') AS a
      LEFT JOIN 
      grp ON a.group_id = grp.group_id 
      LEFT JOIN 
      city ON grp.city_id = city.city_id 
      GROUP BY city;