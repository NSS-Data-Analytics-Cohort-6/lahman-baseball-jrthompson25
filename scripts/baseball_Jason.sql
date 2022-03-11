--Number 1
	SELECT MIN(yearid)
	FROM appearances;

	SELECT MAX(yearid)
	FROM appearances;
--Answer: 1871 to 2016


--Number 2 
	SELECT p.namelast, p.namefirst, p.height, a.G_all, a.teamid
	FROM  people AS p
	LEFT JOIN appearances AS a
	ON p.playerid = a.playerid
	GROUP BY p.namelast, p.namefirst, p.height, a.G_all, a.teamid
	ORDER BY height;
--Answer: Eddie Gaedel at 43 inches. He played in 1 game and his team is SLA.

--Number 3 
	SELECT p.namefirst, p.namelast, sc.schoolname, SUM(DISTINCT s.salary) AS total_salary
	FROM people AS p
	LEFT JOIN salaries AS s
	ON p.playerid = s.playerid
	LEFT JOIN collegeplaying AS c
	ON p.playerid = c.playerid
	LEFT JOIN schools AS sc
	ON c.schoolid = sc.schoolid
	WHERE sc.schoolname = 'Vanderbilt University' AND salary IS NOT NULL
	GROUP BY p.namefirst, p.namelast, sc.schoolname
	ORDER BY SUM(s.salary) DESC;
--Answer: David Price came in first at $81,851,296

--Number 4
	SELECT SUM(po),
		CASE WHEN pos = 'OF' THEN 'Outfield'
			 WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
			 WHEN pos IN ('P', 'C') THEN 'Battery'
			 END AS position 
	FROM fielding
	WHERE yearid = 2016
	GROUP BY position;
--Answer: Battery: 41,424 | Infield: 58,934 | Outfield: 29,560

--Number 5
--Average strikeouts by batters (so) and homeruns by batters (hr) per game for each decade
		SELECT 
		  CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
		       WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
		       WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
		       WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
		       WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
		       WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
		       WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
		       WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
		       WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
		       WHEN yearid BETWEEN 2010 AND 2016 THEN '2010s'
		       END AS decade,
			   ROUND(1.0 * SUM(COALESCE(so,0))/SUM(g), 2) AS avg_strikeouts_per_game,
			   ROUND(1.0 * SUM(hr)/SUM(g), 2) AS avg_homeruns_per_game
    FROM teams
	GROUP BY decade
	ORDER BY decade;
	
--Average strikeouts by pitchers (soa) and homeruns allowed (hra) per game for each decade
	SELECT 
		  CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
		       WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
		       WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
		       WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
		       WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
		       WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
		       WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
		       WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
		       WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
		       WHEN yearid BETWEEN 2010 AND 2016 THEN '2010s'
		       END AS decade,
			   ROUND(1.0 * SUM(soa)/SUM(g), 2) AS avg_strikeouts_per_game,
			   ROUND(1.0 * SUM(hra)/SUM(g), 2) AS avg_homeruns_per_game
    FROM teams
	GROUP BY decade
	ORDER BY decade;

--Average strikeouts by batters (so) and pitchers (soa) combined for each game and decade and
--average homeruns by batters (hr) and homeruns allowed (hra) for each game and decade
	SELECT 
		  CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
		       WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
		       WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
		       WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
		       WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
		       WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
		       WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
		       WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
		       WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
		       WHEN yearid BETWEEN 2010 AND 2016 THEN '2010s'
		       END AS decade,
			   ROUND(1.0 * SUM(COALESCE(so,0)+ soa)/SUM(g), 2) AS avg_strikeouts_per_game,
			   ROUND(1.0 * SUM(hr + hra)/SUM(g), 2) AS avg_homeruns_per_game
    FROM teams
	GROUP BY decade
	ORDER BY decade;
	--Answer: Both strike outs and homeruns appear to have a generally upward trend from decade-to-decade. This could be based
	--on a number of factors such as advancements in technology offering more sophisticated workouts and workout machinery, better knowledge over time       --about what would increase pitching and homerun performance, and sadly, also performance enhancing drugs. 
	
 
--Number 6
	SELECT p.namefirst, p.namelast, b.sb AS stolen_bases, b.cs AS caught_stealing, b.sb + b.cs AS stealing_attempts,
	CONCAT(ROUND(100.0 * b.sb/(b.sb+b.cs), 0), '%') AS success_stealing_perc
	FROM people AS p
	LEFT JOIN batting AS b
	ON p.playerid = b.playerid
	WHERE b.yearid = 2016 AND b.sb + b.cs > 20
	ORDER by success_stealing_perc DESC;
--Answer: Chris Owings at 91%

--Number 7
--Largest number of wins for a team that did not win the world series
	SELECT DISTINCT name, yearid, w, wswin
	FROM teams 
	WHERE yearid BETWEEN 1970 AND 2016 AND wswin = 'N'
	ORDER BY w DESC;

--Smallest number of wins for a team that did win the world series
	SELECT DISTINCT name, yearid, w, wswin
	FROM teams 
	WHERE yearid BETWEEN 1970 AND 2016 AND yearid <> 1981 AND wswin = 'Y'
	GROUP BY name, yearid, w, wswin
	ORDER BY w;

--Frequency of team with most season wins also winning the world series
	SELECT subquery.name, subquery.yearid, subquery.w, subquery.wswin
	FROM 
		(SELECT name, yearid, w, MAX(w) AS most_wins, wswin
			FROM teams 
			WHERE yearid BETWEEN 1970 AND 2016 AND yearid <> 1981 AND wswin IS NOT NULL 
			GROUP BY name, yearid, w, wswin
			ORDER BY yearid) AS subquery
	WHERE wswin = 'Y' AND w = subquery.most_wins
	GROUP BY subquery.name, subquery.yearid, subquery.w, subquery.most_wins, subquery.wswin
	ORDER BY subquery.yearid;


	--Percentage by year
	SELECT subquery.yearid, 
		CONCAT(ROUND(100.0 * AVG(CASE WHEN wswin = 'Y' AND w = subquery.most_wins THEN 1
					   WHEN wswin = 'N' AND w = subquery.most_wins THEN 0
					   END), 2), '%') AS max_and_ws_win_perc
	FROM 
		(SELECT yearid, w, MAX(w) AS most_wins, wswin
		 FROM teams 
		 WHERE yearid BETWEEN 1970 AND 2016 AND yearid <> 1981 AND wswin IS NOT NULL 
		 GROUP BY yearid, w, wswin
		 ORDER BY yearid) AS subquery
	GROUP BY subquery.yearid
	ORDER BY subquery.yearid;	   
	/*Answer: Largest number of wins for a team that did not win the world series - Seatle Mariners with 116   
	          Smallest number of wins for a team that did win the world series - St. Louis Cardinals with 83
			  Percentage of time a team had the most season wins also won the world series (By year) - Refer to query above*/
			  
--Number 8
	SELECT team, park, (attendance/games) AS avg_attendance
	FROM homegames
	WHERE year = 2016 AND games >= 10
	GROUP BY team, park, games, attendance
	ORDER BY avg_attendance DESC
	LIMIT 5;
--Answer (Top 5): LAN	LOS03	45719
----------SLN	STL10	42524
----------TOR	TOR02	41877
----------SFN	SFO03	41546
----------CHN	CHI11	39906
	SELECT team, park, (attendance/games) AS avg_attendance
	FROM homegames
	WHERE year = 2016 AND games >= 10
	GROUP BY team, park, games, attendance
	ORDER BY avg_attendance
	LIMIT 5;
--Answer (Bottom 5):  TBA	STP01	15878
-----------OAK	OAK01	18784
-----------CLE	CLE08	19650
---------- MIA	MIA02	21405
---------- CHA	CHI12	21559

--Number 9
	SELECT winners.manager_name, winners.team_name
	FROM 
		(SELECT CONCAT( p.namefirst, ' ', p.namelast) as manager_name, am.awardid, am.lgid, t.name AS team_name
		 FROM awardsmanagers AS am
		 INNER JOIN people AS p
		 ON am.playerid = p.playerid
		 INNER JOIN teams as t
		 ON am.yearid = t.yearid
		 WHERE am.awardid LIKE 'TSN%' AND am.lgid IN ('NL','AL')
		 GROUP BY manager_name, am.awardid, am.lgid, team_name) AS winners
	GROUP BY winners.manager_name, winners.team_name
	HAVING COUNT(winners.manager_name) > 1;
--Answer: Jim Leyland and Davey Johnson

	SELECT name
	FROM 
		(SELECT CONCAT(p.namefirst, ' ', p.namelast) AS name, am.awardid, am.lgid
		 FROM awardsmanagers AS am
		 INNER JOIN people AS p
		 ON am.playerid = p.playerid
		 WHERE am.awardid LIKE 'TSN%' AND am.lgid IN ('NL','AL')
		 GROUP BY name, am.awardid, am.lgid) AS winners
	GROUP BY name
	HAVING COUNT(name) > 1;


--Number 10 *******************
	SELECT p.namefirst, p.namelast, b.yearid, b.hr, CAST(p.finalgame AS date) - CAST(p.debut AS date) AS league_days
	FROM batting AS b
	LEFT JOIN people AS p
	ON b.playerid = p.playerid
	WHERE yearid = 2016 AND CAST(p.finalgame AS date) - CAST(p.debut AS date) >= 3650 AND b.hr >= 1
	ORDER BY hr DESC;



SELECT * FROM batting;
SELECT * FROM appearances;
SELECT * FROM people;
;
