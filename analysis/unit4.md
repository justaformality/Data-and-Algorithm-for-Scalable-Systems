# Unit 4: From Rows to Insight

## Task 4.1: Measure the Platform

### Question 1

I used SQL aggregate functions to calculate the overall dwell-time statistics for the platform.

The dataset has 200 reactions from 30 unique users. The total dwell time was 3,628,190 milliseconds, with an average of 18,140.95 milliseconds (18.14 seconds). The shortest dwell time was 0 milliseconds, while the longest was 70,860 milliseconds (70.86 seconds).

One thing I noticed was the minimum dwell time of 0 milliseconds. This could mean that a user reacted to a post without spending any time viewing it, or there could be an issue with how the time was recorded. I would look into these records to understand why the dwell time was zero.

These results give us a general idea of user engagement across the platform, but they don't tell us how engagement differs between individual posts.

### Question 2

I used GROUP BY to find the total number of reactions and average dwell time for each post. The query returned results for 13 posts.

Post 6 had the most reactions, with 21 reactions and an average dwell time of 17.84 seconds. Post 8 followed with 20 reactions and an average dwell time of 22.63 seconds. Post 10 had 19 reactions, with an average dwell time of 20.97 seconds.

I also noticed that Post 5 had the highest average dwell time at 23.06 seconds, even though it had fewer reactions than Posts 6, 8, and 10. On the other hand, Post 11 had 16 reactions but a much lower average dwell time of 11.94 seconds.

This shows that having more reactions does not always mean users spend more time engaging with a post. Looking at both the reaction count and average dwell time gives us a better idea of how each post performs.

### Question 3

I chose a minimum threshold of 10 reactions per post because the dataset is fairly small, and I wanted to leave out posts with very little activity.

Before applying the threshold, there were 13 posts. After using HAVING COUNT(*) >= 10, the query returned 12 posts. The only post excluded was Post 4, which had 6 reactions and an average dwell time of 19.49 seconds.

I chose this threshold because posts with very few reactions can have misleading failure rates. For example, if a post only has a few reactions, even one or two spam removals could make its failure rate look unusually high.

Although this helps remove posts with very little activity, 10 reactions is still a small sample. I would also consider the total number of reactions before deciding whether a post needs further investigation.

### Question 4

I grouped the reactions by post ID and country to see how engagement differs across regions. The query returned 62 post-country combinations from five countries: Brazil, India, the UK, the US, and Vietnam.

The results showed some clear differences in average dwell time between countries. For example, Post 5 had an average dwell time of 30.69 seconds in India, compared to only 5.13 seconds in Vietnam. Post 13 had an average dwell time of 34 seconds in the UK, while its only reaction from the US had a dwell time of 0 seconds.

Another interesting result was Post 4 in India, which had a dwell time of 70.86 seconds. However, this was based on just one reaction, so it would not be accurate to say that users in India generally spend more time viewing that post.

These results show that engagement can vary across posts and countries. However, since some groups have very few reactions, I would need more data before making any conclusions about regional engagement patterns.

### Who Would Use These Results?

A Trust and Safety manager or content operations manager could use these results to identify posts that may need further investigation.

Looking only at averages can hide important details about individual reactions. Similarly, knowing the total number of reactions does not tell us which users are responsible for that activity.

To understand these results better, I would look at individual reactions, user activity, timestamps, and removal reasons. This would help identify whether unusual activity is a repeated issue or just an isolated case.

## Task 4.2: Build the Breakdown Leadership Asked For

### Part A: Two numbers in one pass

I used conditional aggregation to calculate the total number of reactions and spam removals for each post in one query.

This helped me answer two questions at the same time: how many reactions each post received and how many of those reactions were removed for spam. I also calculated the spam-removal percentage to compare failure rates between posts.

Post 2 had the highest failure rate at 18.75%, with 3 spam removals out of 16 reactions. Post 4 followed at 16.67%, with 1 removal out of 6 reactions. Post 3 had a failure rate of 15.38%, with 2 removals out of 13 reactions.

Even though Post 4 had the second-highest failure rate, it only had 6 reactions. Since it did not meet the minimum threshold of 10 reactions from Task 4.1, I would focus on Posts 2, 3, and 1 instead. Their failure rates were 18.75%, 15.38%, and 9.09%.

This shows why it is important to look at both the failure rate and the total number of reactions. A high percentage does not always mean there is a major issue, especially when there are very few reactions.

### Part B: Subtotals and a grand total

I used ROLLUP to calculate the total reactions and spam removals for each country, along with the overall platform total.

A regional Trust and Safety director could use these results to compare failure rates between countries without having to look at every individual post.

The five country rows show the regional subtotals, while the row labeled PLATFORM TOTAL shows the total for the entire platform.

India had the highest failure rate at 10%, with 4 spam removals out of 40 reactions. The US followed at 7.89%, and Brazil had a rate of 7.69%. The UK and Vietnam had lower rates of 2.50% and 2.33%.

Across the entire platform, there were 200 reactions and 12 spam removals, giving an overall failure rate of 6%.

The regional results help identify which countries may need more attention, while the platform total shows the overall situation. Leadership can use this total to decide whether the issue needs to be addressed across the whole platform rather than in just one region.

### Part C: A two-step pipeline

I used a two-step pipeline to answer the question: What is the overall spam-removal rate for posts with at least 10 reactions?

First, I used a WITH clause to calculate the total reactions and spam removals for each post. Then, I filtered the results to include only posts with at least 10 reactions and calculated their combined failure rate.

The query returned 12 posts with 194 total reactions and 11 spam removals. This gave a failure rate of 5.67% for posts that met the minimum threshold.

This rate is slightly lower than the overall platform failure rate of 6%. The difference is because Post 4 was excluded from this calculation since it only had 6 reactions and 1 spam removal.

The 5.67% rate gives us a baseline to compare posts with enough activity. For example, Posts 2 and 3 had failure rates of 18.75% and 15.38%, which were much higher than this baseline.

This helps leadership identify which posts may need further investigation while also considering how many reactions each post received.