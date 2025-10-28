-- Data Cleaning

/* Remove duplicates, Standardize the data, Looking at null or balnk values, remove any column
*/

create table layoffs_staging
like layoffs;

INSERT layoffs_staging
SELECT*
from layoffs;

select*, row_number() over(partition by company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;



with cte_1 as ( select*, row_number() over(partition by company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging )
select*
from cte_1
where prtnn >1;

select*
from layoffs_staging
where company = 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging2
select*, row_number() over(partition by company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select*
from layoffs_staging2;

delete
from layoffs_staging2
where row_num >1;

select*
from layoffs_staging2
where row_num >1;

/* Standardizing the data */

select distinct company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select*
from layoffs_staging2;

select distinct industry
from layoffs_staging2
order by industry;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

update layoffs_staging2
set country = trim('United States')
where country like trim('United States.');

select distinct country
from layoffs_staging2
order by country;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY `date` DATE;

select*
from layoffs_staging2
where industry is null or industry = "";

update layoffs_staging2
set industry = null
where industry = "";

SELECT t1.industry, t2.industry
from layoffs_staging2 as t1
JOIN layoffs_staging2  as t2
ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

select*
from layoffs_staging2
where industry is null or industry = "";

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

select*
from layoffs_staging2
where company like "Air%";

select*
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

select*
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null



