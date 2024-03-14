# ipldata_exploration
IPL Data Exploration Project Summary:
In my project, I explored cricket match data from the Indian Premier League (IPL). I looked at details of each ball played in matches (like runs scored) and overall match information (like who won).

Challenges and Solutions:

1. Date Confusion:  To solve this, I used the TO_DATE function. It helped ensure the database understood the dates correctly, even with different formats.

2. Season Sorting:  I used the EXTRACT function to pull out the years from the dates. This helped me group matches by season, making it easier to analyze.

4. Putting Data Together: To combine and summarize the data, I used a mix of SQL functions like COUNT, SUM, and ROW_NUMBER. These functions helped me find interesting facts about players and matches.
