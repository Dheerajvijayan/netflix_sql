# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix_title;
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
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
select		typesof,count(typesof) as total
from		netflix_title
group by	typesof;

```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
 select typesof,rating,level
 from
		(select		typesof,rating,count(rating) as level,
		Rank() over(partition by typesof order by count(rating) desc) as rank_ratings
		from		netflix_title
		group by	typesof,rating)
as 		rate
where	rank_ratings <=1;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
select		title,release_year
from		netflix_title
where		release_year = "2020"
and			typesof = "movie";
```

**Objective:** Retrieve all movies released in a specific year.

### 5. Identify the Longest Movie

```sql
select		title,duration,typesof
from		netflix_title
where		typesof = "movie"
and			duration = (select max(duration))
order by	duration desc;
```

**Objective:** Find the movie with the longest duration.

### 7. Find All Movies/TV Shows by Director 'Alex Woo'

```sql
select		typesof,title,director
from		netflix_title
where		director like '%Alex Woo%';
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
select		title,typesof,duration
from		netflix_title
where		cast(substring_index(duration,'  ',1)as unsigned )>5
and			typesof = "TV Show";
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
select		unnest(string_to_array(listed_in,',')) as gunre,
			count(show_id)		
from		netflix_title
group by	1
order by	2 desc;
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id)::numeric /
        (SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
 select		title,listed_in
 from		netflix_title
 where		listed_in like "%documentaries%";
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
select		*
from		netflix_title
where		director = "null" or trim(director) ="";
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'kamal hassan' Appeared in the Last 30 Years

```sql
select		title,casts,release_year
from		netflix_title
where		casts like '%kamal hassan%';
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.


## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.

Thank you for your support, and I look forward to connecting with you!
