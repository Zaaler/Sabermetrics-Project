use lahman2016;

# describe master;

select m.playerID, convert(m.finalGame, unsigned)
from master m;

drop table if exists numYears;
create table numYears as
select m.playerID, convert(substr(m.debut,1,4), unsigned) as first_game, convert(substr(m.finalGame,1,4), unsigned) as final_game, convert(substr(m.finalGame,1,4), unsigned) - convert(substr(m.debut,1,4), unsigned) as nYears
from master m
where convert(substr(m.debut,1,4), unsigned) > 1999 and convert(substr(m.finalGame,1,4), unsigned) - convert(substr(m.debut,1,4), unsigned) > 10;

drop table if exists enoughYears;
create table enoughYears as
select m.playerID, convert(m.debut,unsigned) as beginYear, convert(m.finalGame,unsigned) as endYear
from master m;


drop table if exists numYears;
create table numYears as
select m.playerID, cast(ey.endYear as signed) - cast(ey.beginYear as signed) as nYears
from master m
join enoughYears ey on ey.playerID = m.playerID;
#where cast(m.debut as signed) > 1999 and cast(m.finalGame as signed) - cast(m.debut as signed) > 9;