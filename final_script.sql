SELECT * FROM lahman2016.single;

# The analysis to score players by batter, starting or relieving pitcher will be evaluated from
# the years 2000. If they have achieved a score that is great enough they will be evaluated for
# the next years until 2017 or they retire.

# ********************** TEMPORARY TABLE FOR ENOUGH YEARS IN THE LEAGUE - DOESNT WORK YET*****************************
#drop table if exists enoughYears;
#create temporary table enoughYears
#select m.playerID, substring(m.finalGame,1,4) as endYear
#from master m
#where cast(substring(m.finalGame,1,4) as unsigned) = 2010;

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
select b.playerID, (b.RBI*0.4 + b.2B*0.3 + b.3B*0.3 + b.HR*0.3 - b.CS*0.2 - b.GIDP*0.5) as battingScore
from batting b
join master m on m.playerID = b.playerID
where b.yearID = 2000 and b.AB > 450 #and cast(substring(m.finalGame,1,4) as signed) > 2015
order by battingScore DESC; # WHY DOES THIS CHANGE MY RESULTS?

# SECOND QUERY: BATTING SCORE FOR ALL YEARS TILL 2015
select bb.playerID, b.yearID, (b.RBI*0.4 + b.2B*0.3 + b.3B*0.3 + b.HR*0.3 - b.CS*0.2 - b.GIDP*0.5) as YearlyBatScore
from batting b
join BestBatters bb on bb.playerID = b.playerID
#join master m on m.playerID = bb.playerID
where b.yearID > 1999
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
