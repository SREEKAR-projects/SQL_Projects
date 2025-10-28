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
