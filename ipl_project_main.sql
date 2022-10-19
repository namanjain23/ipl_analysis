USE ipl_project;


--UPDATING NECESSARY RECORDS

UPDATE all_season_summary$ SET description = 'Final (N), Indian Premier League at Johannesburg, May 24 2009'
WHERE description = 'Final (D/N), Indian Premier League at Johannesburg, May 24 2009'

UPDATE all_season_summary$ SET description = '2nd Semi-Final (N), Indian Premier League at Johannesburg, May 23 2009'
WHERE description = '2nd Semi-Final (D/N), Indian Premier League at Johannesburg, May 23 2009'

UPDATE all_season_summary$ SET winner = 'Deccan Chargers'
WHERE id=392239

UPDATE all_season_summary$ SET home_team = 'Deccan Chargers'
WHERE id=392239

UPDATE all_season_summary$ SET description = '2nd Semi-Final (N), Indian Premier League at Mumbai, May 25 2011'
WHERE description = 'Elimination Final (N), Indian Premier League at Mumbai, May 25 2011'

UPDATE all_season_summary$ SET description = '2nd Semi-Final (N), Indian Premier League at Chennai, May 25 2012'
WHERE description = '2nd Qualifying Match (N), Indian Premier League at Chennai, May 25 2012'

UPDATE all_season_summary$ SET winner = 'Deccan Chargers'
WHERE name LIKE'%Deccan Chargers%' AND winner = 'SRH'

UPDATE all_season_summary$ SET winner = 'PBKS'
WHERE name LIKE'%Punjab%' AND winner = 'KXIP'

UPDATE all_season_summary$ 
SET winner = 
	CASE WHEN id = 1254077 THEN  'DC'
		 WHEN id = 1216547 THEN  'RCB'
		 WHEN id = 1216512 THEN  'KKR'
		 WHEN id = 729315 THEN  'RR'
		 WHEN id = 1178426 THEN  'MI'
		 WHEN id = 392190 THEN  'RR'
		 WHEN id = 419121 THEN 'PBKS'
		 WHEN id = 1216493 THEN 'DC'
		 ELSE winner
	END
WHERE result LIKE'%tied%'




--MOST CONSISTENT TEAMS ON THE BASIS OF MOST NUMBER OF FINAL PLAYED


--1) selecting teams from all seasons who played the finals

SELECT
	 season,
	 --description,
	 home_team as team_1,
	 away_team as team_2,
	 winner	 
FROM all_season_summary$
WHERE description LIKE'Final (N)%' --or description LIKE'Qualifier 2 (N)%' or description LIKE'2nd Semi-Final (N)%' 
ORDER BY 1
;

--2) grouping by team name and counting number of finals played and won

SELECT
     winner,
	 COUNT(winner) as final_played
FROM all_season_summary$
WHERE description LIKE'Final (N)%' or description LIKE'Qualifier 2 (N)%' or description LIKE'2nd Semi-Final (N),%'
GROUP BY winner
ORDER BY 2 DESC
;

SELECT
	 winner,
	 COUNT(winner) as final_won
FROM all_season_summary$
WHERE description LIKE'Final (N)%'
GROUP BY winner
ORDER BY 2 DESC
;

SELECT 
	A.team_name,
	final_played,
	final_won
FROM ( SELECT
     winner as team_name,
	 COUNT(winner) as final_played
	 
FROM all_season_summary$
WHERE description LIKE'Final (N)%' or description LIKE'Qualifier 2 (N)%' or description LIKE'2nd Semi-Final (N),%'
GROUP BY winner ) A 
JOIN (SELECT
	 winner as team_name,
	 COUNT(winner) as final_won
FROM all_season_summary$
WHERE description LIKE'Final (N)%' 
GROUP BY winner
) B ON A.team_name =B.team_name




--BOWLERS STATS (RUNS_CONCEDED,TOTAL_WICKETS,BOWLING_AVERAGE,BOWLING_STRIKE-RATE AND ECONOMY_RATE)

--1)calculating runs_conceded,total_wickets and bowling_average

SELECT 
	fullName,
	SUM(conceded) AS runs_conceded,
	SUM(wickets) AS wickets,
	SUM(conceded)/NULLIF(SUM(wickets),0) AS bowling_average
FROM all_season_bowling_card$
GROUP BY fullName
ORDER BY SUM(wickets) DESC

--2)calculating Economy_Rate

SELECT 
	fullName,
	SUM(conceded) AS runs_conceded,
	SUM(overs) AS total_overs,
	SUM(conceded)/NULLIF(SUM(overs),0) AS economy_rate
FROM all_season_bowling_card$
GROUP BY fullName
ORDER BY SUM(wickets) DESC

--3) calculating BOWLING_STRIKE-RATE



--4) combining all stats

SELECT 
	fullName,
	SUM(conceded) AS runs_conceded,
	SUM(overs) AS total_overs,
	SUM(wickets) AS wickets,
	SUM(conceded)/NULLIF(SUM(wickets),0) AS bowling_average,
	SUM(conceded)/NULLIF(SUM(overs),0) AS economy_rate
FROM all_season_bowling_card$
GROUP BY fullName
ORDER BY SUM(wickets) DESC





--BATSMEN STATS (RUNS,STRIKE_RATE,BATTING AVERAGE) 

SELECT 
	fullName,
	SUM(runs) AS total_runs_scored,   --RUNS
	(SUM(runs)/NULLIF(SUM(ballsFaced),0))*100 AS strike_rate,  --STRIKE_RATE
	SUM(runs)/NULLIF(COUNT(CASE WHEN isNotOut NOT IN ('TRUE') THEN 1 END), 0) AS batting_average  --BATTING AVERAGE
FROM all_season_batting_card$
GROUP BY fullName
ORDER BY 2 DESC




-- ALL-ROUNDER STATS

SELECT 
	A.fullName,
	A.runs,
	batting_average,
	B.overs,
	wickets,
	bowling_average

FROM ( SELECT 
	fullName,
	SUM(runs) AS runs,   --RUNS
	(SUM(runs)/NULLIF(SUM(ballsFaced),0))*100 AS strike_rate,  --STRIKE_RATE
	SUM(runs)/NULLIF(COUNT(CASE WHEN isNotOut NOT IN ('TRUE') THEN 1 END), 0) AS batting_average  --BATTING AVERAGE
FROM all_season_batting_card$
GROUP BY fullName
 ) A 
JOIN (SELECT 
	fullName,
	SUM(conceded) AS runs_conceded,
	SUM(overs) AS overs,
	SUM(wickets) AS wickets,
	SUM(conceded)/NULLIF(SUM(wickets),0) AS bowling_average,
	SUM(conceded)/NULLIF(SUM(overs),0) AS economy_rate
FROM all_season_bowling_card$
GROUP BY fullName


) B ON A.fullName =B.fullName
WHERE A.runs >500 AND B.wickets > 20
ORDER BY 2 DESC






--TEAM PERFORMANCE AGAINST EACH OTHER


SELECT
	winner as 'V/S',
	COUNT(CASE WHEN short_name LIKE'%CSK%' AND winner NOT IN ('CSK','NONE') THEN 1 END) as CSK,
	COUNT(CASE WHEN name LIKE'%Delhi%' AND winner NOT IN ('DC','NONE') THEN 1 END) as DC,
	COUNT(CASE WHEN name LIKE'%Deccan Chargers%' AND winner NOT IN ('Deccan Chargers','NONE','SRH') THEN 1 END) as Deccan_Chargers,
	COUNT(CASE WHEN short_name LIKE'%GL%' AND winner NOT IN ('GL','NONE') THEN 1 END) as GL,
	COUNT(CASE WHEN short_name LIKE'%GT%' AND winner NOT IN ('GT','NONE') THEN 1 END) as GT,
	COUNT(CASE WHEN short_name LIKE'%KKR%' AND winner NOT IN ('KKR','NONE') THEN 1 END) as KKR,
	COUNT(CASE WHEN short_name LIKE'%Kochi%' AND winner NOT IN ('Kochi','NONE') THEN 1 END) as Kochi,
	COUNT(CASE WHEN short_name LIKE'%LSG%' AND winner NOT IN ('LSG','NONE') THEN 1 END) as LSG,
	COUNT(CASE WHEN short_name LIKE'%MI%' AND winner NOT IN ('MI','NONE') THEN 1 END) as MI,
	COUNT(CASE WHEN name LIKE'%Punjab%' AND winner NOT IN ('PBKS','NONE') THEN 1 END) as PBKS,
	COUNT(CASE WHEN short_name LIKE'%PWI%' AND winner NOT IN ('PWI','NONE') THEN 1 END) as PWI,
	COUNT(CASE WHEN short_name LIKE'%RCB%' AND winner NOT IN ('RCB','NONE') THEN 1 END) as RCB,
	COUNT(CASE WHEN short_name LIKE'%RPS%' AND winner NOT IN ('RPS','NONE') THEN 1 END) as RPS,
	COUNT(CASE WHEN short_name LIKE'%RR%' AND winner NOT IN ('RR','NONE') THEN 1 END) as RR,
	COUNT(CASE WHEN short_name LIKE'%SRH%' AND winner NOT IN ('SRH','NONE') THEN 1 END) as SRH

FROM all_season_summary$
GROUP BY winner
ORDER BY 1
