-- Arshia Rajeshnarayanan
-- EX603 Project Assignment 4
-- Task 4.2: Build The Breakdown Leadership Asked For
-- Theme: Social Media
-- Database: ex603_data

-- PART A: Two numbers in one pass
-- For each producer, compute the total number of events and the total number of events classified as failures, in a single pass over the event table, without a WHERE clause filtering the whole query.
-- The outliers here are the producers you will name in your finding.
-- ✓  CASE used inside an aggregate — for example SUM(CASE WHEN ... THEN 1 ELSE 0 END) or COUNT(CASE WHEN ... END).
-- ✓  Both totals appearing as separate columns in one result set.

SELECT
    post_id,
    COUNT(*) AS total_reactions,
    SUM(
        CASE
            WHEN reaction_status = 'removed'
             AND removal_reason = 'Spam detected'
            THEN 1
            ELSE 0
        END
    ) AS spam_removals,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN reaction_status = 'removed'
                 AND removal_reason = 'Spam detected'
                THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS spam_removal_pct
FROM likes
GROUP BY post_id
ORDER BY spam_removal_pct DESC, total_reactions DESC, post_id;


-- PART B: Subtotals and a grand total
-- The regional director wants subtotals per region and a platform grand total, not the detail rows.
-- Write a query that produces regional subtotals and a platform-wide grand total without including the individual detail rows.
-- ✓  GROUP BY ROLLUP (...), or GROUPING SETS or CUBE.
-- ✓  A written note identifying which rows are the subtotals and which is the grand total.

SELECT
    CASE
        WHEN GROUPING(client_country) = 1
        THEN 'PLATFORM TOTAL'
        ELSE client_country
    END AS region,
    COUNT(*) AS total_reactions,
    SUM(
        CASE
            WHEN reaction_status = 'removed'
             AND removal_reason = 'Spam detected'
            THEN 1
            ELSE 0
        END
    ) AS spam_removals,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN reaction_status = 'removed'
                 AND removal_reason = 'Spam detected'
                THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS spam_removal_pct
FROM likes
GROUP BY ROLLUP(client_country)
ORDER BY GROUPING(client_country), client_country;


-- PART C: A two-step pipeline
-- Leadership wants to establish a baseline for evaluating high-volume producers.
-- That needs two steps: use a WITH clause to create an intermediate result that summarizes performance for each producer, then use a second aggregation or filter on that intermediate result to calculate a baseline for high-volume producers.
-- ✓  A WITH clause producing an intermediate aggregate.
-- ✓  A second aggregation or filter applied to that intermediate result.

WITH post_performance AS (
    SELECT
        post_id,
        COUNT(*) AS total_reactions,
        SUM(
            CASE
                WHEN reaction_status = 'removed'
                 AND removal_reason = 'Spam detected'
                THEN 1
                ELSE 0
            END
        ) AS spam_removals
    FROM likes
    GROUP BY post_id
)
SELECT
    COUNT(*) AS high_volume_posts,
    SUM(total_reactions) AS total_reactions,
    SUM(spam_removals) AS total_spam_removals,
    ROUND(
        100.0 * SUM(spam_removals)
        / NULLIF(SUM(total_reactions), 0),
        2
    ) AS high_volume_spam_rate_pct
FROM post_performance
WHERE total_reactions >= 10;
