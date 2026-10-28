# Unit 4: Write the Finding

## Overview

I analyzed the Social Media dataset to find the actual failure rate across the platform and identify which posts may need further investigation. For this analysis, a failure refers to a reaction that was removed because it was detected as spam.

The dataset contains 200 reactions, and 12 of them were removed for spam. This means the overall platform failure rate is **6%**.

## Producer Comparison

The failure rates were different across posts. Some posts had much higher spam-removal rates than the platform average.

Post 2 had the highest failure rate at **18.75%**, with 3 spam removals out of 16 reactions. Post 4 had the second-highest rate at **16.67%**, but it only had 6 reactions. Post 3 followed with a failure rate of **15.38%**, with 2 removals out of 13 reactions.

Other posts had lower failure rates. For example, Post 1 had a rate of **9.09%**, while Posts 5, 8, 10, and 13 had no spam removals.

These results show why we need to look at both the failure rate and the total number of reactions. A high percentage does not always mean there is a major issue, especially when the post has very few reactions.

## Posts Recommended for Investigation

Based on these results, I would recommend investigating **Posts 2, 3, and 1**.

**Post 2** would be my first priority because it had the highest failure rate at 18.75%. It had 3 spam removals out of 16 reactions, which is more than three times the platform average.

**Post 3** would be my second priority because its failure rate was 15.38%, with 2 spam removals out of 13 reactions. This is also much higher than the overall failure rate.

**Post 1** would be my third choice because it had a failure rate of 9.09%, with 1 spam removal out of 11 reactions. Although this is lower than Posts 2 and 3, it is still above the platform average.

I did not include Post 4 in my recommendations, even though it had the second-highest failure rate. This is because it only had 6 reactions and did not meet the minimum threshold of 10 reactions that I selected in Task 4.1.

## Recommendation

I think the Trust and Safety team should start by reviewing Posts 2 and 3, followed by Post 1 if needed.

They should look more closely at the individual reactions, user activity, timestamps, and removal reasons to understand why these posts have higher failure rates.

Since the dataset is relatively small, I would not make any final decisions based only on these results. Further investigation would help determine whether these are repeated issues or just isolated cases.