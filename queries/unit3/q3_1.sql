--Question 3.1

SELECT
    post_id,
    post_title,
    like_count,
    is_visible
FROM posts
WHERE is_visible = TRUE
  AND like_count > 100
ORDER BY like_count DESC, post_id
LIMIT 10;

SELECT DISTINCT
    reaction_status
FROM likes
ORDER BY reaction_status;

SELECT
    reaction_status,
    COUNT(*) AS reaction_count
FROM likes
GROUP BY reaction_status
ORDER BY reaction_status;

SELECT
    like_id,
    user_id,
    post_id,
    dwell_ms
FROM likes
WHERE dwell_ms BETWEEN 10000 AND 30000
ORDER BY like_id;

SELECT
    like_id,
    reaction_status,
    removal_reason
FROM likes
WHERE reaction_status IN ('removed', 'flagged')
ORDER BY like_id;

SELECT
    post_id,
    post_title
FROM posts
WHERE post_title LIKE 'Post\_0%' ESCAPE '\'
ORDER BY post_id;

SELECT
    COUNT(*) AS missing_reason_count
FROM likes
WHERE removal_reason IS NULL;

SELECT
    like_id,
    reaction_status,
    COALESCE(
        removal_reason,
        'No reason provided'
    ) AS readable_reason
FROM likes
ORDER BY like_id
LIMIT 25;


SELECT
    like_id,
    user_id,
    post_id,
    reaction_status,
    ROUND(dwell_ms / 1000.0, 2) AS dwell_seconds,
    CASE
        WHEN reaction_status = 'removed'
             AND removal_reason = 'Spam detected'
            THEN 'Spam removal'
        WHEN reaction_status = 'removed'
            THEN 'Other removal'
        WHEN reaction_status = 'flagged'
            THEN 'Needs review'
        ELSE 'Active reaction'
    END AS business_category
FROM likes
ORDER BY like_id
LIMIT 30;


SELECT
    COUNT(*) AS total_reactions,

    COUNT(*) FILTER (
        WHERE reaction_status = 'active'
    ) AS active_reactions,

    COUNT(*) FILTER (
        WHERE reaction_status = 'flagged'
    ) AS flagged_reactions,

    COUNT(*) FILTER (
        WHERE reaction_status = 'removed'
    ) AS removed_reactions,

    COUNT(*) FILTER (
        WHERE reaction_status = 'removed'
          AND removal_reason = 'Spam detected'
    ) AS spam_removals,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE reaction_status = 'removed'
              AND removal_reason = 'Spam detected'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS spam_removal_pct

FROM likes;