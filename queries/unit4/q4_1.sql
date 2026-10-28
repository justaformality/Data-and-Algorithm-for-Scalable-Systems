-- Arshia Rajeshnarayanan
-- EX603 Project Assignment 4
-- Task 4.1: Measure the Platform
-- Theme: Social Media
-- Database: ex603_data

-- QUESTION 1
-- Calculate the following statistics across the entire event table using your theme's metric: the count, total, average, minimum, and maximum of your theme’s metric across the whole event table, and how many distinct actors appear.
-- Review your results carefully.
-- For example, if your metric should never be zero but your minimum value is zero, this may indicate another data-quality issue that needs investigation.

SELECT
    COUNT(dwell_ms) AS metric_count,
    SUM(dwell_ms) AS total_dwell_ms,
    ROUND(AVG(dwell_ms), 2) AS average_dwell_ms,
    MIN(dwell_ms) AS minimum_dwell_ms,
    MAX(dwell_ms) AS maximum_dwell_ms,
    COUNT(DISTINCT user_id) AS unique_users
FROM likes;


-- QUESTION 2
-- Write a query that calculates the event count and average metric for each producer.
-- Sort the results from the producer with the most events to the producer with the fewest.
-- Consider what these results tell you about differences in activity and performance across producers.

SELECT
    post_id,
    COUNT(*) AS total_reactions,
    ROUND(AVG(dwell_ms), 2) AS average_dwell_ms
FROM likes
GROUP BY post_id
ORDER BY total_reactions DESC, post_id;


-- QUESTION 3
-- Which producers have enough volume for their rate to mean anything?
-- A producer with only a few events may have a high failure rate that is not representative of their usual performance.
-- Choose a minimum event-count threshold and use HAVING to include only producers who meet that threshold.
-- Explain why you selected your threshold.

SELECT
    post_id,
    COUNT(*) AS total_reactions,
    ROUND(AVG(dwell_ms), 2) AS average_dwell_ms
FROM likes
GROUP BY post_id
HAVING COUNT(*) >= 10
ORDER BY total_reactions DESC, post_id;


-- QUESTION 4
-- How does the picture change along two dimensions at once?
-- Leadership also wants to understand how performance varies across regions.
-- Write a query that groups the data by two dimensions, including region, and calculates the relevant summary statistics.
-- Your results should contain one row for each combination of the two dimensions so that regional leaders can review their results.

SELECT
    post_id,
    client_country,
    COUNT(*) AS total_reactions,
    ROUND(AVG(dwell_ms), 2) AS average_dwell_ms,
    MIN(dwell_ms) AS minimum_dwell_ms,
    MAX(dwell_ms) AS maximum_dwell_ms
FROM likes
GROUP BY post_id, client_country
ORDER BY post_id, client_country;
