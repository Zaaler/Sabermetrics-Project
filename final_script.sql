use lahman2016;
SHOW VARIABLES LIKE 'secure_file_priv';
SHOW VARIABLES LIKE 'tmpdir';

# The analysis to score players by batter, starting or relieving pitcher will be evaluated from
# the years 2000. If they have achieved a score that is great enough they will be evaluated for
# the next years until 2017 or they retire.

# ********************** TEMPORARY TABLE FOR ENOUGH YEARS IN THE LEAGUE - DOESNT WORK YET*****************************

# THIS IS FOR ALL POSSIBLE PLAYERS WITH A CAREER LONGER THAN 5 YEARS FROM 2005 - 2017
drop table if exists years_in_league;
create table years_in_league as
select m.playerID, substring(m.finalGame, 1, 4) as final, substring(m.debut,1,4) as deb
from master m
where substring(m.finalGame, 1, 4) != '' and substring(m.debut,1,4) != '';

drop table if exists tot_years;
create table tot_years as
select years_in_league.playerID, convert(years_in_league.final,unsigned) - convert(years_in_league.deb, unsigned) as total_years
from years_in_league
where cast(years_in_league.deb as unsigned) >= 2005 and convert(years_in_league.final,unsigned) - convert(years_in_league.deb, unsigned) > 5 and cast(years_in_league.final as unsigned) <= 2017 ;

select * from tot_years
INTO OUTFILE 'C:\\data\\tot_years.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';


# NOW NEED TO COMPUTE BEST BATTER FOR ALL THE PLAYERS IN TOTAL_YEARS_BATTING
# FIRST BATTING QUERY
drop table if exists BestBatters;
create temporary table BestBatters
select tb.playerID, (b.RBI*0.4 + b.2B*0.3 + b.3B*0.3 + b.HR*0.3 - b.CS*0.2 - b.GIDP*0.5) as battingScore
from tot_batting tb
join batting b on b.playerID = tb.playerID
where (b.AB > 200 and b.yearID = 2005) or (b.yearID = '' and b.AB = '')
order by tb.playerID;

# THIS RESULTS IN A POSSIBLE 525 PLAYERS
select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2005
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2005.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2006
order by tot_years.playerID
INTO OUTFILE 'C:\\Users\\zacka\\Documents\\GitHub\\Sabermetrics-Project\\data\\2006.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2007
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2007.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2008
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2008.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2009
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2009.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2010
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2010.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2011
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2011.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2012
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2012.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2013
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2013.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2014
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2014.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2015
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2015.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2016
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2016.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';

select tot_years.playerID, b.yearID, b.RBI, b.2B, b.3B, b.HR, b.CS, b.GIDP
from tot_years
join batting b on b.playerID = tot_years.playerID
where b.AB >= 200 and b.yearID = 2017
order by tot_years.playerID
INTO OUTFILE 'C:\Users\zacka\Documents\GitHub\Sabermetrics-Project\data\2017.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ';'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n';
# BATTERS STATISTICS:
# RBIs - most important (overlooks lead off hitters but, if you don't hit a HR you don't change the game as a single hitter)
# Doubles, Triples - put yourself in scoring position (More important than the actual run, because it is out of your hands)
# Home Runs - you'll get double recognition because of RBIs (if it applies) - still very prevalent 14.2% in 2017 https://www.washingtonpost.com/news/fancy-stats/wp/2017/06/01/mlb-home-run-spike-shows-statcast-science-is-more-potent-than-steroids/?noredirect=on&utm_term=.fae6480cafea
# Walks and Intentional Walks will not be included (I wanna base players on their performance not on the pitchers they play against)
# Caught Stealing - minor penalty because you cost your team while trying to, most of the time, advance to scoring position
# Ground into Double Play - bigger penalty (this is very costly, you eliminated a players positive and forced 2 outs)

# REQUIREMENTS TO BE CONSIDERED:
# At Bats > 450
# Career Lasted Till At Least 2015
# Strikeouts (might consider if time, don't know enough to deem this important yet)

# FINAL WEIGHTS: 
# RBIs = .4
# Doubles & Triples = .3
# Home Runs = .3
# Caught Stealing = -.2
# Ground into Double Play = -.5
# SCORE = .4*RBI + .3*Doub_or_Trip + .3*HR - .2*CS -.5*GIDP

# FIRST BATTING QUERY
drop table if exists BestBatters;
create temporary table BestBatters
select b.playerID, b.yearID, (b.RBI*0.4 + b.2B*0.3 + b.3B*0.3 + b.HR*0.3 - b.CS*0.2 - b.GIDP*0.5) as battingScore
from batting b
join tot_years on tot_years.playerID = b.playerID
where b.AB > 200 and b.yearID = 2005 and tot_years.playerID = b.playerID
group by b.playerID
order by b.playerID; # WHY DOES THIS CHANGE MY RESULTS?

select *
from BestBatters;

# SECOND QUERY: BATTING SCORE FOR ALL YEARS TILL 2015
select bb.playerID, b.yearID, (b.RBI*0.4 + b.2B*0.3 + b.3B*0.3 + b.HR*0.3 - b.CS*0.2 - b.GIDP*0.5) as YearlyBatScore
from batting b
join BestBatters bb on bb.playerID = b.playerID
join years_in_league on years_in_league.playerID = b.playerID
#join master m on m.playerID = bb.playerID
where convert(years_in_league.deb, unsigned) > 2000
order by b.yearID;

# STARTING PITCHERS:
# Leaving analysis strictly to pitching to avoid weighting for pitchers that were forced to bat

# REQUIREMENTS TO BE CONSIDERED:
# Games Started > 15
# OR
# Games Played > 30 (Might reconsider for starting, playing, and relieving)
# Career Lasted Till At Least 2010

# STARTING PITCHERS STATISTICS:
# Wins/Losses - most important stat (gives an inclination to where the game was when he was relieved)
# ERA - this is should couple with W/L but, be less important (don't want to penalize twice if the result was a win)
# Shutouts - a big, rare category - slight increase
# Strikeouts - positive statistic, weighted heavily vs. innings pitched
# Grounded into double play - positive statistic - got out of a bind and forced a batter into a bad play

# FINAL WEIGHTS:
# Wins/Losses: .6
# ERA: -.25
# Shutouts: .3
# Strikeouts: .05
# SCORE = .6*(W/L) -.25*ERA + .3*SHO + .05*SO 

# STARTING PITCHER QUERY
drop table if exists BestSPitchers;
create temporary table BestSPitchers
select sp.playerID, ((sp.W/sp.L)*0.6 - sp.ERA*0.25 + sp.SHO*0.3 + sp.SO*0.05) as SPitchingScore
from pitching sp
join master m on m.playerID = sp.playerID
where sp.yearID = 2000 and (sp.GS > 15 or sp.G > 30)
order by SPitchingScore DESC; 

# SECOND QUERY: STARTING PITCHER SCORE FOR ALL YEARS TILL 2015
select spb.playerID, sp.yearID, ((sp.W/sp.L)*0.6 - sp.ERA*0.25 + sp.SHO*0.3 + sp.SO*0.05) as YearlySPitchingScore
from pitching sp
join BestSPitchers spb on spb.playerID = sp.playerID
#join master m on m.playerID = bb.playerID
where sp.yearID > 1999
order by sp.yearID;

# RELIEF PITCHERS:
# Leaving analysis strictly to pitching to avoid weighting for pitchers that were forced to bat

# REQUIREMENTS TO BE CONSIDERED:
# Saves > 15
# Career Lasted Till At Least 2005 (adjusted from 2010)

# RELIEF PITCHERS STATISTICS:
# Saves - means the pitcher won the game with his effort
# Wins - means the pitcher took over a losing effort and won
# Losses - means the pitcher failed to save or win game

# FINAL WEIGHTS:
# Saves = .3
# Wins = .5
# Losses = -.4

# SCORE = .3*SV + .5*W -.4*L
# FIRST QUERY: SCORE FOR YEAR 2000
drop table if exists BestRPitchers;
create temporary table BestRPitchers
select rp.playerID, (rp.SV*0.3 + rp.W*0.5 - rp.L*0.4) as RPitchingScore
from pitching rp
join master m on m.playerID = rp.playerID
# WEIRD RESULT ONLY 3 RELIEF PITCHERS LASTED AT LEAST 10 YEARS (2010) RELAXING TO 2005 
where rp.yearID = 2000 and rp.SV > 15 #and cast(m.finalGame as signed) >= 2005
order by RPitchingScore DESC; # WHY DOES THIS CHANGE MY RESULTS?

# SECOND QUERY: RELIEF PITCHER SCORE FOR ALL YEARS TILL 2015
select rpb.playerID, sp.yearID, ((sp.W/sp.L)*0.6 - sp.ERA*0.25 + sp.SHO*0.3 + sp.SO*0.05) as YearlyRPitchingScore
from pitching sp
join BestRPitchers rpb on rpb.playerID = sp.playerID
#join master m on m.playerID = bb.playerID
where sp.yearID > 1999
order by sp.yearID;
