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
SELECT p.namefirst, p.namelast, sc.schoolname, SUM(s.salary) AS total_salary
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
--Answer: David Price came in first at $245,553,888

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

--Number 5 -- Use teams table
SELECT DISTINCT g, CASE WHEN yearid BETWEEN 1920 AND 1929 THEN 'From 1920 to 1929'
		    WHEN yearid BETWEEN 1930 AND 1939 THEN 'From 1930 to 1939'
		    WHEN yearid BETWEEN 1940 AND 1949 THEN 'From 1940 to 1949'
		    WHEN yearid BETWEEN 1950 AND 1959 THEN 'From 1950 to 1959'
		    WHEN yearid BETWEEN 1960 AND 1969 THEN 'From 1960 to 1969'
		    WHEN yearid BETWEEN 1970 AND 1979 THEN 'From 1970 to 1979'
		    WHEN yearid BETWEEN 1980 AND 1989 THEN 'From 1980 to 1989'
		    WHEN yearid BETWEEN 1990 AND 1999 THEN 'From 1990 to 1999'
		    WHEN yearid BETWEEN 2000 AND 2009 THEN 'From 2000 to 2009'
		    WHEN yearid BETWEEN 2010 AND 2016 THEN 'From 1920 to 1929'
		    END AS decade,
	        ROUND(AVG(so + soa), 2)  AS avg_strikeout, ROUND(AVG(hr + hra), 2) AS avg_homeruns
  FROM teams
  GROUP BY g, decade
  ORDER BY decade;
  
  SELECT  *
  FROM teams;
  

--Number 6
SELECT p.namefirst, p.namelast, b.sb AS bases_stolen, b.cs AS caught_stealing, b.sb + b.cs AS stealing_attempts,
b.sb/b.s + b.cs AS success_stealing_perc
FROM people AS p
LEFT JOIN batting AS b
ON p.playerid = b.playerid
WHERE b.yearid = 2016 AND b.sb + b.cs > 20
ORDER by stealing_attempts DESC;
--Answer: 


/*SELECT namefirst, namelast, subquery.sb/subquery.stealing_attempts AS successful_stealing_perc
FROM people, 
  (SELECT sb, sb + cs AS stealing_attempts
   FROM batting
   WHERE yearid = 2016 AND sb + cs >= 20
   ORDER BY stealing_attempts DESC) AS subquery;*/
   
--Number 7

--Number 8
SELECT p.park_name, h.team, AVG(attendance)
FROM homegames AS h
LEFT JOIN parks AS p
ON h.park = p.park
ORDER BY p.park_name, t.name DESC
LIMIT 5;

SELECT *
FROM homegames;

--Number 9
SELECT p.namefirst, p.namelast, am.awardid, am.lgid
FROM awardsmanagers AS am
LEFT JOIN people AS p
ON am.playerid = p.playerid
WHERE awardid LIKE 'TSN%' AND lgid = 'AL';





  

