--Select the three longest trips while it was raining

WITH rainy AS
(
SELECT
	DATE(date) rain_date
FROM
	weather
WHERE
	events = 'Rain'
GROUP BY 1
)

SELECT
	t.trip_id,
	t.duration,
	DATE(t.start_date)
FROM
	trips t
JOIN
	rainy r
ON DATE(t.start_date) = r.rain_date
ORDER BY
	duration
	DESC
LIMIT 3;

--Which station has is most full on average

SELECT
	AVG(dockcount),
	station_id,
	name
FROM
	stations
GROUP BY
	station_id,
	name
ORDER BY
	AVG(dockcount)
	DESC;
	
--Return a list of stations with a count of number of trips starting at that 
--station but ordered by dock count

SELECT
	s.name,
	AVG(s.dockcount),
	COUNT(*) trip_no
FROM
	stations s
JOIN
	trips t
ON
	s.name = t.start_station
GROUP BY
	1
ORDER BY
	2
	DESC;
	

	--(Challenge) What's the length of the longest trip for each day it rains anywhere?

WITH rainy AS
(
SELECT
	DATE(date) w_date
FROM 
	weather
WHERE
	events = 'Rain'
GROUP BY 1
),
rain_trips AS
(SELECT
	trip_id,
	duration,
	DATE(trips.start_date) rain_trips_date
FROM
	trips
JOIN
	rainy
ON
	rainy.w_date = DATE(trips.start_date)
ORDER BY
	duration
	DESC
)
SELECT
	rain_trips_date,
	MAX(duration) max_duration
FROM
	rain_trips
GROUP BY 1
ORDER BY
	max_duration
	DESC
