CREATE SCHEMA MKMOTORS_DEV.DW;

USE MKMOTORS_DEV.DW;

----  CREATE MKMOTORS_DW TABLES -------
CREATE TABLE DM_CUSTOMERS
(   CUST_KEY		number(9) NOT NULL,
    CUST_ID    		number(9) NOT NULL,
    CUST_NAME		varchar(50),
    CUST_ADDRESS	varchar(50),
    CUST_CITY     	varchar(15),
    CUST_STATE    	varchar(15),
    CUST_ZIP_CODE 	number(6),
    CUST_COUNTRY 	varchar(20),
    CUST_PHONE_NMBR	varchar(14),
    CUST_GENDER		varchar(6),
    CUST_AGE_GROUP	varchar(20),
    CUST_INCOME		number(9,2),
    CUST_EMAIL		varchar(40),
    CUST_AGE		number(3));

ALTER TABLE DM_CUSTOMERS ADD PRIMARY KEY (CUST_KEY);


CREATE TABLE DM_DATES
(
    DATE_KEY        number(9) NOT NULL,
    DATE_ID_LEGACY  number(9),
    DATE_VALUE      datetime NOT NULL,
    DAY_OF_MONTH        varchar(2),
    MONTH_NUMBER        varchar(2),
    YEAR_VALUE          varchar(4),
    DAY_OF_WEEK         varchar(1),
    DAY_NAME            varchar(9),
    MONTH_NAME          varchar(9),
    DAY_OF_YEAR         varchar(3),
    WEEK_OF_YEAR        varchar(2),
    MONTH_OF_YEAR       varchar(2),
    QUARTER_OF_YEAR     varchar(1),
    DAY_OVERALL         varchar(5),
    WEEK_OVERALL        varchar(4),
    MONTH_OVERALL       varchar(3),
    YEAR_OVERALL        varchar(2),
    HOLIDAY_INDICATOR   varchar(1),
    WORKDAY_INDICATOR   varchar(1),
    WEEKDAY_INDICATOR   varchar(1),
    WEEKEND_INDICATOR   varchar(1),
    SEASON              varchar(6),
    LAST_DAY_IN_MONTH   varchar(1),
    LAST_DAY_IN_QUARTER varchar(1),
    LAST_DAY_IN_YEAR    varchar(1));

ALTER TABLE DM_DATES ADD PRIMARY KEY (DATE_KEY);

CREATE TABLE DM_DEALERSHIP 
(      DEALERSHIP_KEY	    number(9) NOT NULL,
       DEALERSHIP_ID        number(9) NOT NULL,
       DEALERSHIP_MGR_ID    number(9),
       DEALERSHIP_DESC      varchar(50),
       DEALERSHIP_LOCATION  varchar(50),
       DEALERSHIP_STATE     varchar(15),
       DEALERSHIP_REGION    varchar(7),
       DEALERSHIP_COUNTRY   varchar(20));

ALTER TABLE DM_DEALERSHIP ADD PRIMARY KEY (DEALERSHIP_KEY);

CREATE TABLE DM_EMPLOYEES 
(      EMPLOYEE_KEY	    number(9) NOT NULL,
       EMPLOYEE_ID          number(9) NOT NULL,
       EMPLOYEE_NAME        varchar(50),
       EMPLOYEE_ADDRESS     varchar(50),
       EMPLOYEE_CITY        varchar(15),
       EMPLOYEE_STATE       varchar(15),
       EMPLOYEE_ZIP_CODE    number(6),
       EMPLOYEE_MOBILE      varchar(14),
       EMPLOYEE_FIXED_LINE  varchar(14),
       EMPLOYEE_EMAIL       varchar(40),
       EMPLOYEE_GENDER      varchar(6),
       EMPLOYEE_AGE	    number(3),	
       AGE_GROUP            varchar(20),
       POSITION_TYPE        varchar(50),
       DEALERSHIP_ID        number(9),
       DEALERSHIP_MANAGER   varchar(50),
       EMPLOYEE_SALARY	    number(9,2),
       EMPLOYEE_REGION	    varchar(10),
       HIRED_DATE_KEY	    number(9),
       INSERT_DK	    number(9),
       UPDATE_DK	    number(9));

ALTER TABLE DM_EMPLOYEES ADD PRIMARY KEY (EMPLOYEE_KEY);

CREATE TABLE DM_PAYMENT_METHOD 
(	PAYMENT_KEY 	number(9) NOT NULL,
	PAYMENT_ID 	number(9) NOT NULL,
	PAYMENT_TYPE	varchar(20),
	MODIFIED_DATEKEY number(9),
	ISCURRENT	boolean);

ALTER TABLE DM_PAYMENT_METHOD ADD PRIMARY KEY (PAYMENT_KEY);

CREATE TABLE DM_PRODUCTS 
(      PRODUCT_KEY          number(9) NOT NULL IDENTITY,
       PRODUCT_ID           number(9) NOT NULL,
       GROUP_ID             number(9),
       PRODUCT_DESC         varchar(50),
       GROUP_DESC           varchar(50),
       DIVISION_DESC        varchar(50),
       PRODUCT_COST	    number(9,2),
       UPDATED_DATEKEY      number(9) not null, 
       CURRENT_FLAG         boolean not null);

ALTER TABLE DM_PRODUCTS ADD PRIMARY KEY (PRODUCT_KEY);

CREATE TABLE DM_PROMOTIONS 
(      PROMO_KEY	    number(9) NOT NULL,
       PROMO_ID             number(9) NOT NULL,
       PROMO_DESC           varchar(50),
       PROMO_TYPE           varchar(20),
       START_DK             number(9),
       EXPIRY_DK            number(9),
       PROMO_COST           number(9),
       DISCOUNT		    number(9,2));

ALTER TABLE DM_PROMOTIONS ADD PRIMARY KEY (PROMO_KEY);

CREATE TABLE FT_SALES
(   CUST_KEY		number(9) NOT NULL,
    PRODUCT_KEY		number(9) NOT NULL,
    DEALERSHIP_KEY	number(9) NOT NULL,
    PAYMENT_KEY		number(9) NOT NULL,
    PROMO_KEY		number(9) NOT NULL,
    DATE_KEY		number(9) NOT NULL,
    UNITS_SOLD		number(9),
    REVENUE		number(15,2),
    COST		number(15,2),
    DISCOUNT		number(15,2),
    HOLDBACK		number(15,2),
    REBATE		number(15,2));

ALTER TABLE FT_SALES
       ADD PRIMARY KEY (CUST_KEY, PRODUCT_KEY, DEALERSHIP_KEY, PAYMENT_KEY, PROMO_KEY, DATE_KEY);


CREATE TABLE FT_PRODUCT_AGG_DAILY
(   PRODUCT_KEY 	number(9) NOT NULL,
    DEALERSHIP_KEY	number(9) NOT NULL,
    DATE_KEY		number(9) NOT NULL,
    UNITS_SOLD		number(9),
    REVENUE		number(15,2),
    COST		number(15,2),
    DISCOUNT		number(15,2),
    HOLDBACK		number(15,2),
    REBATE		number(15,2));


ALTER TABLE FT_PRODUCT_AGG_DAILY
       ADD PRIMARY KEY (PRODUCT_KEY, DEALERSHIP_KEY, DATE_KEY);

CREATE TABLE FT_PRODUCT_AGG_WEEKLY
(   PRODUCT_KEY 	number(9) NOT NULL,
    DEALERSHIP_KEY	number(9) NOT NULL,
    DATE_KEY		number(9) NOT NULL,
    UNITS_SOLD		number(9),
    REVENUE		number(15,2),
    COST		number(15,2),
    DISCOUNT		number(15,2),
    HOLDBACK		number(15,2),
    REBATE		number(15,2));


ALTER TABLE FT_PRODUCT_AGG_WEEKLY
       ADD PRIMARY KEY (PRODUCT_KEY, DEALERSHIP_KEY, DATE_KEY);

CREATE TABLE FT_PROMOTIONS_AGG_DAILY
(   PROMO_KEY		number(9) NOT NULL,
    DEALERSHIP_KEY	number(9) NOT NULL,
    PRODUCT_KEY         number(9) NOT NULL,
    DATE_KEY		number(9) NOT NULL,
    UNITS_SOLD		number(9),
    REVENUE		number(15,2),
    REVENUE_PER_UNIT	number(15,2),
    COST		number(15,2),
    COST_PER_UNIT	number(15,2));

ALTER TABLE FT_PROMOTIONS_AGG_DAILY
       ADD PRIMARY KEY (PROMO_KEY, DEALERSHIP_KEY, PRODUCT_KEY, DATE_KEY);


create or replace table dm_products_scd (
product_key number(10,0) identity, product_id number(8,0) not null,
group_id number(5,0) not null, product varchar(50) not null,
prodcost number(12,2) not null, description varchar(500),
start_time timestamp_ntz not null, end_time timestamp_ntz not null,
current_flag boolean not null );
ALTER TABLE DM_PRODUCTS_SCD ADD PRIMARY KEY (PRODUCT_KEY);
