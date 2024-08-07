-- Create Database if it doesn't exist
CREATE DATABASE IF NOT EXISTS hotel_reservation;

-- Use the database
USE hotel_reservation;

-- Create table if it doesn't exist
CREATE TABLE IF NOT EXISTS hotel_reservations (
	Booking_ID VARCHAR(20),
    no_of_adults INT,
    no_of_children INT,
    no_of_weekend_nights INT,
    no_of_week_nights INT,
    type_of_meal_plan VARCHAR(50),
    room_type_reserved VARCHAR(50),
    lead_time INT,
    arrival_date VARCHAR(20),
    market_segment_type VARCHAR(50),
    avg_price_per_room DECIMAL(10, 2),
    booking_status VARCHAR(20)
);


-- Check table cotnent (should return 0 rows if table is empty)
SELECT * FROM hotel_reservations LIMIT 0, 2000;

-- Count rows in the table
SELECT COUNT(*) FROM hotel_reservations;


-- (01) Total number of reservation in the dataset ?
SELECT COUNT(*) AS total_no_of_reservations FROM hotel_reservations;


-- (02) Most popular meal plan among guests?
SELECT type_of_meal_plan, COUNT(*)
AS count
FROM hotel_reservations
GROUP BY type_of_meal_plan
ORDER BY count DESC
LIMIT 1;


-- (03) Average price per room involving children ?
SELECT AVG(avg_price_per_room) AS average_price
FROM hotel_reservations
WHERE no_of_children > 0;


-- (04) Number of reservations made for the year 2024?
SELECT COUNT(*) AS reservations_in_year_2024
FROM hotel_reservations
WHERE YEAR(arrival_date) = 2024;


-- (05) Most commonly booked type room ?
SELECT room_type_reserved, COUNT(*) AS count
FROM hotel_reservations
GROUP BY room_type_reserved
ORDER BY COUNT DESC
LIMIT 1;


-- (06) Number of reservation fall on a weekend
SELECT COUNT(*) AS weekend_reservations
FROM hotel_reservations
WHERE no_of_weekend_nights > 0;


-- (07) Highest and Lowest lead time for reservations ?
SELECT MAX(lead_time) AS maximum_lead_time,
MIN(lead_time) AS minimumn_lead_time
FROM hotel_reservations;


-- (08) Most common market segment type for reservations ?
SELECT market_segment_type, COUNT(*) AS count
FROM hotel_reservations
GROUP BY market_segment_type
ORDER BY count DESC
LIMIT 1;


-- (09) Number of reservation have a booking status of "Confirmed" ?
SELECT COUNT(*) AS confirmed_reservations
FROM hotel_reservations
WHERE booking_status = 'Confirmed';


-- (10) Total number of adults and children across all reservations ?
SELECT SUM(no_of_adults) AS total_adults,
SUM(no_of_children) AS total_children
FROM hotel_reservations;


-- (11) Average number of weekend nights for reservations involving children ?
SELECT AVG(no_of_weekend_nights) AS average_weekend_nights
FROM hotel_reservations
WHERE no_of_children > 0;


-- (12) Number of reservations made in each month of the year ?
SELECT MONTH(arrival_date) AS month,
COUNT(*) AS reservation_count
FROM hotel_reservations
GROUP BY MONTH(arrival_date)
ORDER BY MONTH;


-- (13) Average number of nights (both weekend and weekday) spend by guests for each room type ?
SELECT room_type_reserved,
AVG(no_of_weekend_nights + no_of_week_nights) AS average_nights
FROM hotel_reservations
GROUP BY room_type_reserved
ORDER BY room_type_reserved ASC;


-- (14) For reservations involving children, most common room type and average price for that room type ?
SELECT room_type_reserved, COUNT(*) AS count,
AVG(avg_price_per_room) AS average_price
From hotel_reservations
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY count DESC
LIMIT 1;


-- (15) Market segment type that generate the highest price per room
SELECT market_segment_type, 
AVG(avg_price_per_room) AS average_price
FROM hotel_reservations
GROUP BY market_segment_type
ORDER BY average_price DESC
LIMIT 1;