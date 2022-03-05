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
--Answer: Battery: 41,424, Infield: 58,934, Outfield: 29,560

--Number 5 -- Use teams table
