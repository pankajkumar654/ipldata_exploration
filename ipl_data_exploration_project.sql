
select * from ipl_data_exploration.ipl_ball_by_ball ibbb ;
select * from ipl_data_exploration.ipl_matches im ;


--challenge first
--i change datestyle because in postgresql if i apply extract in the style of dmy its not working but if
-- apply to date to 
SELECT TO_DATE(date, 'DD-MM-YYYY') AS converted_date
FROM ipl_data_exploration.ipl_matches im ;


-- how many matches are there for each season
select seasonyear,count(distinct match_id) from
(select extract(year from (to_date(date,'dd-mm-yyyy'))) seasonyear,
id match_id 
from ipl_data_exploration.ipl_matches im )t1
group by 1;

-- most player of match
select  player_of_match,count(*) 
from  ipl_data_exploration.ipl_matches im 
group by 1
order by 2 desc;

-- most player of match in every season

select player_of_match,season,ct from
(
select *,
row_number() over(partition by season order by ct desc) rn
from
(
select player_of_match ,extract(year from (to_date(date,'dd-mm-yyyy'))) season ,
count(player_of_match) ct
from ipl_data_exploration.ipl_matches im 
group by 1,2 
order by 2,3 desc
)t1
)t2
where rn = 1;

-- most wins by any team
-- the team that wins a most of time in the every season
-- no of matches that win

select winner,count(winner) from ipl_data_exploration.ipl_matches im 
where winner not in ('NA')
group by 1
order by 2 desc;


-- top 5 venues where match is played
select venue,count(venue) from ipl_data_exploration.ipl_matches im 
group by 1
order by 2 desc
limit 5;

-- most runs by any batsman

select batsman ,sum(total_runs) from ipl_data_exploration.ipl_ball_by_ball ibbb 
group by 1
order by 2 desc
limit 5;

--select sum(total_runs) from ipl_data_exploration.ipl_ball_by_ball ibbb ;


-- percent of total runs scored by each batsman
select *,round((tr *1.0/sum(tr)  over(order by tr rows between unbounded preceding and unbounded following))*100 ,2)from
(
select batsman,sum(total_runs) tr from ipl_data_exploration.ipl_ball_by_ball ibbb 
group by 1
order by 2 desc)a
order by 2 desc;



-- most sixes by any batsman

select batsman,count(batsman_runs) from ipl_data_exploration.ipl_ball_by_ball ibbb 
where batsman_runs = 6
group by 1
order by 2 desc
limit 1;



-- most fours by any batsman

select batsman,count(batsman_runs) from ipl_data_exploration.ipl_ball_by_ball ibbb 
where batsman_runs = 4
group by 1
order by 2 desc
limit 1;


-- strike rates of batsmen who have scored 3000 runs in a ipl ?

select batsman,batsman_runs,round((batsman_runs *1.0/total_balls)*100,2) strike_rate from
(
select batsman ,sum(batsman_runs) batsman_runs,count(batsman) total_balls 
from ipl_data_exploration.ipl_ball_by_ball ibbb 
group by 1
)a
where batsman_runs >=3000
order by 3 desc


--lowest economy rate for the bowler who has bowled at least 50 overs

select bowler,round(( 1.0*total_runs_conceded/total_balls)*100,2) economy_rate from
(
select bowler,sum(total_runs) total_runs_conceded ,count(bowler) total_balls 
from ipl_data_exploration.ipl_ball_by_ball ibbb 
group by 1
)a
where total_balls >=300
order by 2
limit 1;

-- total number of matches have played till 2020

select count(distinct id) from ipl_data_exploration.ipl_matches im 
where date < '30-12-2020';

select count(distinct id) from ipl_data_exploration.ipl_matches im ;


-- total number of matches win by each team
--its a last question so please complete 