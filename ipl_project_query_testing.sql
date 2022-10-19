USE ipl_project


SELECT
	winner as VS,
	COUNT(CASE WHEN winner NOT IN ('CSK','NONE') THEN 1 END) as CSK

FROM all_season_summary$
WHERE short_name LIKE'%CSK%'
GROUP BY winner


SELECT
	winner as VS,
	COUNT(CASE WHEN winner NOT IN ('KKR','NONE') THEN 1 END) as KKR

FROM all_season_summary$
WHERE short_name LIKE'%KKR%'
GROUP BY winner


SELECT
	winner as VS,
	COUNT(CASE WHEN short_name LIKE'%GL%' AND winner NOT IN ('GL','NONE') THEN 1 END) as GL

FROM all_season_summary$
WHERE short_name LIKE'%GL%'
GROUP BY winner


SELECT
	winner as VS,
	COUNT(CASE WHEN winner NOT IN ('MI','NONE') THEN 1 END) as MI

FROM all_season_summary$
WHERE short_name LIKE'%MI%'
GROUP BY winner


SELECT
	winner as VS,
	COUNT(CASE WHEN winner NOT IN ('GT','NONE') THEN 1 END) as GT

FROM all_season_summary$
WHERE short_name LIKE'%GT%'
GROUP BY winner

SELECT
	winner as VS,
	COUNT(CASE WHEN winner NOT IN ('Kochi','NONE') THEN 1 END) as Kochi

FROM all_season_summary$
WHERE short_name LIKE'%Kochi%'
GROUP BY winner


SELECT
	winner as VS,
	COUNT(CASE WHEN winner NOT IN ('KXIP','NONE') THEN 1 END) as KXIP

FROM all_season_summary$
WHERE short_name LIKE'%KXIP%'
GROUP BY winner















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

























SELECT
	venue_name,
	COUNT(winner) as Total,
	COUNT(CASE WHEN short_name LIKE'%CSK%' AND winner  IN ('CSK') THEN 1 END) as CSK,
	COUNT(CASE WHEN name LIKE'%Delhi%' AND winner  IN ('DC') THEN 1 END) as DC,
	COUNT(CASE WHEN name LIKE'%Deccan Chargers%' AND winner IN ('Deccan Chargers') THEN 1 END) as Deccan_Chargers,
	COUNT(CASE WHEN short_name LIKE'%GL%' AND winner IN ('GL') THEN 1 END) as GL,
	COUNT(CASE WHEN short_name LIKE'%GT%' AND winner IN ('GT') THEN 1 END) as GT,
	COUNT(CASE WHEN short_name LIKE'%KKR%' AND winner IN ('KKR') THEN 1 END) as KKR,
	COUNT(CASE WHEN short_name LIKE'%Kochi%' AND winner IN ('Kochi') THEN 1 END) as Kochi,
	COUNT(CASE WHEN short_name LIKE'%LSG%' AND winner IN ('LSG') THEN 1 END) as LSG,
	COUNT(CASE WHEN short_name LIKE'%MI%' AND winner IN ('MI') THEN 1 END) as MI,
	COUNT(CASE WHEN name LIKE'%Punjab%' AND winner IN ('PBKS') THEN 1 END) as PBKS,
	COUNT(CASE WHEN short_name LIKE'%PWI%' AND winner IN ('PWI') THEN 1 END) as PWI,
	COUNT(CASE WHEN short_name LIKE'%RCB%' AND winner IN ('RCB') THEN 1 END) as RCB,
	COUNT(CASE WHEN short_name LIKE'%RPS%' AND winner IN ('RPS') THEN 1 END) as RPS,
	COUNT(CASE WHEN short_name LIKE'%RR%' AND winner IN ('RR') THEN 1 END) as RR,
	COUNT(CASE WHEN short_name LIKE'%SRH%' AND winner IN ('SRH') THEN 1 END) as SRH
	

FROM all_season_summary$
GROUP BY venue_name











SELECT id,name,winner,result

FROM all_season_summary$
WHERE result LIKE'%tied%'


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