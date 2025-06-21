create database		netflix;
use					netflix;
drop table 			netflix_title;
create table		netflix_title (
					show_id				VARCHAR(10),
                    typesof				VARCHAR(10),
                    title				VARCHAR(150),
                    director			VARCHAR(250),
                    casts				VARCHAR(1000),
                    country				VARCHAR(150),
                    date_added			VARCHAR(50),
                    release_year		INT,
                    rating				VARCHAR(10),
                    duration			VARCHAR(15)	,
                    listed_in			VARCHAR(100),
                    descriptions		VARCHAR(250)	);
select		*
from		netflix_title;
SELECT COUNT(*) FROM netflix_title;

-- 1. Count the number of Movies vs TV Shows

select		typesof,count(typesof) as total
from		netflix_title
group by	typesof;

-- 2. Find the most common rating for movies and TV shows

		
 select typesof,rating,level
 from
		(select		typesof,rating,count(rating) as level,
		Rank() over(partition by typesof order by count(rating) desc) as rank_ratings
		from		netflix_title
		group by	typesof,rating)
as 		rate
where	rank_ratings <=1;

-- 3. List all movies released in a specific year (e.g., 2020)

select		title,release_year
from		netflix_title
where		release_year = "2020"
and			typesof = "movie";

-- 5. Identify the longest movie

select		title,duration,typesof
from		netflix_title
where		typesof = "movie"
and			duration = (select max(duration))
order by	duration desc;

-- 7. Find all the movies/TV shows by director 'Alex Woo'!

select		typesof,title,director
from		netflix_title
where		director like '%Alex Woo%';

-- 8. List all TV shows with more than 5 seasons

select		title,typesof,duration
from		netflix_title
where		cast(substring_index(duration,'  ',1)as unsigned )>5
and			typesof = "TV Show";

-- 11. List all movies that are documentaries
 
 select		title,listed_in
 from		netflix_title
 where		listed_in like "%documentaries%";
 
-- 12. Find all content without a director
select		*
from		netflix_title
where		director = "null" or trim(director) ="";

-- 13. Find how many movies actor 'kamal hassan' appeared in last 30 years!

select		title,casts,release_year
from		netflix_title
where		casts like '%kamal hassan%'
and
release_year > extract(year from current_date)-30;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select		casts, country
from		netflix_title
where country = "India";












