/*

Cleaning Data in SQL Queries

*/

Select *
from nashvillehousingdatafordatacleaning;

-- Standardize Date Format

Update nashvillehousingdatafordatacleaning
set saledate = str_to_date(saledate, '%M %e, %Y');

Select SaleDate, convert(saledate, date)
from nashvillehousingdatafordatacleaning;

update nashvillehousingdatafordatacleaning
set saledate = convert(saledate, date);

-- Populate Property Address data

Select *
from nashvillehousingdatafordatacleaning
where PropertyAddress = ''
order by ParcelID;

Select *
from nashvillehousingdatafordatacleaning a
join nashvillehousingdatafordatacleaning b
	on a.ParcelID = b.ParcelID
    and a.uniqueid <> b.uniqueid 
where a.propertyaddress = '';

Select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress
from nashvillehousingdatafordatacleaning a
join nashvillehousingdatafordatacleaning b
	on a.ParcelID = b.ParcelID
    and a.UniqueID <> b.UniqueID
where a.PropertyAddress = '';

UPDATE nashvillehousingdatafordatacleaning a
JOIN nashvillehousingdatafordatacleaning b
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = b.PropertyAddress
WHERE a.PropertyAddress = ''
  OR a.PropertyAddress IS NULL; 
  
SELECT * FROM nashvillehousingdatafordatacleaning
WHERE PropertyAddress = '' OR PropertyAddress IS NULL;

-- Breaking out Address into Individual Columns (Address, City, State)

Select propertyaddress
from nashvillehousingdatafordatacleaning;

SELECT 
    SUBSTRING(propertyaddress, 1, LOCATE(',', propertyaddress) - 1) AS address,
    SUBSTRING(propertyaddress, LOCATE(',', propertyaddress) + 1) AS city
FROM nashvillehousingdatafordatacleaning;

alter table nashvillehousingdatafordatacleaning
add propertysplitaddress nvarchar(255);

update nashvillehousingdatafordatacleaning
set propertysplitaddress = SUBSTRING(propertyaddress, 1, LOCATE(',', propertyaddress) - 1);

alter table nashvillehousingdatafordatacleaning
add propertysplitcity nvarchar(255);

update nashvillehousingdatafordatacleaning
set propertysplitcity = SUBSTRING(propertyaddress, LOCATE(',', propertyaddress) + 1);

select *
from nashvillehousingdatafordatacleaning;

select OwnerAddress
from nashvillehousingdatafordatacleaning;

SELECT 
    SUBSTRING(OwnerAddress, 1, LOCATE(',', OwnerAddress) - 1) AS Address,
    SUBSTRING(OwnerAddress, LOCATE(',', OwnerAddress) + 2, 
              LOCATE(',', OwnerAddress, LOCATE(',', OwnerAddress) + 1) - LOCATE(',', OwnerAddress) - 2) AS City,
    SUBSTRING(OwnerAddress, LOCATE(',', OwnerAddress, LOCATE(',', OwnerAddress) + 1) + 2) AS State
FROM nashvillehousingdatafordatacleaning;

alter table nashvillehousingdatafordatacleaning
add ownersplitaddress varchar(255);

update nashvillehousingdatafordatacleaning
set ownersplitaddress = SUBSTRING(OwnerAddress, 1, LOCATE(',', OwnerAddress) - 1);

alter table nashvillehousingdatafordatacleaning
add ownersplitcity varchar(255);

update nashvillehousingdatafordatacleaning
set ownersplitcity = SUBSTRING(OwnerAddress, LOCATE(',', OwnerAddress) + 2, 
              LOCATE(',', OwnerAddress, LOCATE(',', OwnerAddress) + 1) - LOCATE(',', OwnerAddress) - 2);

alter table nashvillehousingdatafordatacleaning
add ownersplitstate varchar(255);

update nashvillehousingdatafordatacleaning
set ownersplitstate = SUBSTRING(OwnerAddress, LOCATE(',', OwnerAddress, LOCATE(',', OwnerAddress) + 1) + 2);

Select *
from nashvillehousingdatafordatacleaning;

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select distinct(soldasvacant), count(soldasvacant)
from nashvillehousingdatafordatacleaning
group by SoldAsVacant
order by 2;

Select soldasvacant,
case when soldasvacant = 'Y' then 'Yes'
	when soldasvacant = 'N' then 'No'
    else soldasvacant 
    end
from nashvillehousingdatafordatacleaning;

Update nashvillehousingdatafordatacleaning
Set soldasvacant = Case when soldasvacant = 'Y' then 'Yes'
	when soldasvacant = 'N' then 'No'
    else soldasvacant
    end;
    
-- Remove Duplicates

DELETE FROM nashvillehousingdatafordatacleaning
WHERE UniqueID IN (
    SELECT UniqueID FROM (
        SELECT UniqueID,
               ROW_NUMBER() OVER (
                   PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
                   ORDER BY UniqueID
               ) AS row_num
        FROM nashvillehousingdatafordatacleaning
    ) AS subquery
    WHERE row_num > 1
);

select *
from nashvillehousingdatafordatacleaning;

-- Delete Unused Columns

Alter Table nashvillehousingdatafordatacleaning
drop column OwnerAddress;

Alter Table nashvillehousingdatafordatacleaning
drop column TaxDistrict;

Alter Table nashvillehousingdatafordatacleaning
drop column PropertyAddress;

Alter Table nashvillehousingdatafordatacleaning
drop column SaleDate;


