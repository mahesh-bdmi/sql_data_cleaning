-- DATA CLEANING --

-- Populate NULLs in Property address

SELECT 
h.ParcelID,
h.PropertyAddress,
hh.PropertyAddress,
ISNULL(h.PropertyAddress,hh.PropertyAddress)
FROM housing h
JOIN housing hh
ON h.ParcelID = hh.ParcelID AND h.UniqueID <> hh.UniqueID
WHERE h.PropertyAddress IS NULL

UPDATE h
SET PropertyAddress = ISNULL(h.PropertyAddress,hh.PropertyAddress)
FROM housing h
JOIN housing hh
ON h.ParcelID = hh.ParcelID AND h.UniqueID <> hh.UniqueID
WHERE h.PropertyAddress IS NULL

--Breaking up the property address into individual columns
SELECT PropertyAddress 
FROM housing

SELECT 
PropertyAddress,
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as street,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+2,LEN(PropertyAddress)) as city
FROM housing

-- Add and update street and city columns

ALTER TABLE housing
ADD street NVARCHAR(255);

ALTER TABLE housing
ADD city NVARCHAR(255);

UPDATE housing
SET street = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1);

UPDATE housing
SET city = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+2,LEN(PropertyAddress));


-- Breaking up the owner address into individual columns
SELECT
OwnerAddress,
PARSENAME(REPLACE(OwnerAddress,',','.'),3) as street,
PARSENAME(REPLACE(OwnerAddress,',','.'),2) as city,
PARSENAME(REPLACE(OwnerAddress,',','.'),1) as state
FROM housing

ALTER TABLE housing
ADD 
OwnerStreetAddress NVARCHAR(255),
OwnerStreetCity NVARCHAR(255),
OwnerStreetState NVARCHAR(255);

UPDATE housing
SET 
OwnerStreetAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3),
OwnerStreetCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2),
OwnerStreetState = PARSENAME(REPLACE(OwnerAddress,',','.'),1);

-- Find and delete Duplicates based on selected columns
WITH rownum_CTE AS (
SELECT *,
	ROW_NUMBER() 
	OVER(PARTITION BY ParcelID,
					PropertyAddress,
					SaleDate,
					SalePrice,
					LegalReference 
					ORDER BY UniqueID) as row_num
FROM housing)

SELECT * FROM rownum_CTE
WHERE row_num > 1;

-- Delete unused columns

SELECT * FROM housing

ALTER TABLE housing
DROP COLUMN PropertyAddress,OwnerAddress,TaxDistrict
