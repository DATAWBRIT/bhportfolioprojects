/*

Queries used for Tableau Project

*/

-- 1.

Select sum(new_cases) as total_cases, sum(cast(new_deaths as decimal)) as total_deaths, sum(cast(new_deaths as decimal))/sum(new_cases)*100 as deathpercentage
from coviddeaths
-- where loctionlike '%states%'
where continent is not null
-- Group by date
Order by 1,2;

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includeds "International" Location

-- 2.

-- We take these out as they are not included in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, sum(cast(new_deaths as decimal)) as totaldeathcount 
from coviddeaths
-- Where location like '%states%'
Where continent is not null
and location not in ('World', 'European Union', 'International')
Group by location
order by totaldeathcount desc;

-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
-- Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc;

-- 4.


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
-- Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc;
