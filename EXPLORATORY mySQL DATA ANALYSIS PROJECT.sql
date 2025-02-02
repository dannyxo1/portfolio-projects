-- Exploratory Data Analysis


SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC ;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(date), MAX(date)
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 2 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT SUBSTRING(date, 1, 7) AS 'MONTH', SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(date, 1, 7) IS NOT NULL
GROUP BY SUBSTRING(date, 1, 7)
ORDER BY 1 ASC;

SELECT *
FROM layoffs_staging2;

WITH Rolling_total AS
(SELECT SUBSTRING(date, 1, 7) AS MONTH, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(date, 1, 7) IS NOT NULL
GROUP BY SUBSTRING(date, 1, 7)
ORDER BY 1 ASC
)
SELECT MONTH, total_off, SUM(total_off) OVER(ORDER BY MONTH) AS Rolling_total
FROM Rolling_total
;

SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
ORDER BY company ASC;


WITH Company_Year (Company, Years, Total_laid_off) AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
), Company_Year_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY Years ORDER BY Total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE Years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;


























