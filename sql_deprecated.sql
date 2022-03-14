-- Create database container for the tables

CREATE DATABASE HR;

--
-- Table structure for table countries
--

CREATE TABLE IF NOT EXISTS HR.countries (
  COUNTRY_ID varchar(2) NOT NULL,
  COUNTRY_NAME varchar(40) DEFAULT NULL,
  REGION_ID INT(4) UNSIGNED DEFAULT NULL, --changed to the same data type on regions table
  PRIMARY KEY (COUNTRY_ID),
  FOREIGN KEY COUNTR_REG_FK (REGION_ID) REFERENCES regions(REGION_ID) --added foreign key
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `countries`
--

INSERT INTO HR.`countries` (`COUNTRY_ID`, `COUNTRY_NAME`, `REGION_ID`) VALUES
('AR', 'Argentina', '2'),
('AU', 'Australia', '3'),
('BE', 'Belgium', '1'),
('BR', 'Brazil', '2'),
('CA', 'Canada', '2'),
('CH', 'Switzerland', '1'),
('CN', 'China', '3'),
('DE', 'Germany', '1'),
('DK', 'Denmark', '1'),
('EG', 'Egypt', '4'),
('FR', 'France', '1'),
('HK', 'HongKong', '3'),
('IL', 'Israel', '4'),
('IN', 'India', '3'),
('IT', 'Italy', '1'),
('JP', 'Japan', '3'),
('KW', 'Kuwait', '4'),
('MX', 'Mexico', '2'),
('NG', 'Nigeria', '4'),
('NL', 'Netherlands', '1'),
('SG', 'Singapore', '3'),
('UK', 'United Kingdom', '1'),
('US', 'United States of America', '2'),
('ZM', 'Zambia', '4'),
('ZW', 'Zimbabwe', '4');

-- --------------------------------------------------------


--
-- Table structure for table departments
--


CREATE TABLE IF NOT EXISTS HR.departments (
  DEPARTMENT_ID INT(4) UNSIGNED NOT NULL, --changed data type to INT UNSIGNED to avoid negative values
  DEPARTMENT_NAME varchar(30) NOT NULL,
  MANAGER_ID INT(6) UNSIGNED DEFAULT NULL, --changed data type to INT UNSIGNED to avoid negative values
  LOCATION_ID INT(4) UNSIGNED DEFAULT NULL, --changed data type to INT UNSIGNED to avoid negative values
  PRIMARY KEY (DEPARTMENT_ID),
  FOREIGN KEY DEPT_MGR_FK (MANAGER_ID) REFERENCES employees (EMPLOYEE_ID), --added foreign key
  FOREIGN KEY DEPT_LOCATION_FK (LOCATION_ID) REFERENCES locations (LOCATION_ID) --added foreign key
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Dumping data for table `departments`
--

INSERT INTO HR.`departments` (`DEPARTMENT_ID`, `DEPARTMENT_NAME`, `MANAGER_ID`, `LOCATION_ID`) VALUES
('10', 'Administration', '827390', '1700'),
('20', 'Marketing', '880259', '1800'),
('30', 'Purchasing', '135522', '1700'),
('40', 'Human Resources', '803414', '2400'),
('50', 'Shipping', '637478', '1500'),
('60', 'IT', '207456', '1400'),
('70', 'Public Relations', '728256', '2700'),
('80', 'Sales', '802013', '2500'),
('90', 'Executive', '506864', '1700'),
('100', 'Finance', '367184', '1700'),
('110', 'Accounting', '361045', '1700'),
('120', 'Treasury', '243263', '1700'),
('130', 'Corporate Tax', '661726', '1700'),
('140', 'Control And Credit', '120103', '1700'),
('150', 'Shareholder Services', '0', '1700'),
('160', 'Benefits', '521681', '1700'),
('170', 'Manufacturing', '0', '1700'),
('180', 'Construction', '0', '1700'),
('190', 'Contracting', '0', '1700'),
('200', 'Operations', '0', '1700'),
('210', 'IT Support', '228856', '1700'),
('220', 'NOC', '0', '1700'),
('230', 'IT Helpdesk', '984012', '1700'),
('240', 'Government Sales', '916763', '1700'),
('250', 'Retail Sales', '996603', '1700'),
('260', 'Recruiting', '321082', '1700'),
('270', 'Payroll', '885444', '1700');

-- --------------------------------------------------------


--
-- Table structure for table employees
--

CREATE TABLE IF NOT EXISTS HR.employees (
  EMPLOYEE_ID INT(6) UNSIGNED NOT NULL, --changed data type to INT UNSIGNED to avoid negative values
  FIRST_NAME varchar(20) NOT NULL, --changed to NOT NULL since majority of the individuals possess at least one given name; majority of the countries also requires first name on their legal systems
  LAST_NAME varchar(25) NOT NULL,
  EMAIL varchar(40) NOT NULL,
  PHONE_NUMBER varchar(20) DEFAULT NULL,
  HIRE_DATE date NOT NULL,
  JOB_ID varchar(10) NOT NULL,
  SALARY decimal(8,2) DEFAULT NULL,
  COMMISSION_PCT decimal(2,2) DEFAULT NULL,
  MANAGER_ID INT(6) UNSIGNED DEFAULT NULL,
  DEPARTMENT_ID INT(4) UNSIGNED NOT NULL, --changed to the same data type on departments table
  PRIMARY KEY (EMPLOYEE_ID),
  UNIQUE KEY EMP_EMAIL_UK (EMAIL),
  FOREIGN KEY EMP_DEPARTMENT_FK (DEPARTMENT_ID) REFERENCES departments(DEPARTMENT_ID), --add foreign key
  FOREIGN KEY EMP_JOB_FK (JOB_ID) REFERENCES jobs (JOB_ID), --add foreign key
  FOREIGN KEY EMP_MANAGER_FK (MANAGER_ID) REFERENCES employees (EMPLOYEE_ID), --self-referencing foreign key
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


--
-- Dumping data for table `job_history`
--
--the csv file contains 10,000 employee records

LOAD DATA INFILE
'emp_records_csv.csv'
INTO TABLE HR.employees
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

--
-- Table structure for table job_history
--

CREATE TABLE IF NOT EXISTS HR.job_history (
  EMPLOYEE_ID INT(6) UNSIGNED NOT NULL, --changed to the same datatype on employees table
  START_DATE date NOT NULL,
  END_DATE date NOT NULL,
  JOB_ID varchar(10) NOT NULL,
  DEPARTMENT_ID INT(4) UNSIGNED NOT NULL, --changed to the same datatype on departments table
  PRIMARY KEY (EMPLOYEE_ID,START_DATE),
  FOREIGN KEY JHIST_DEPARTMENT_FK (DEPARTMENT_ID) REFERENCES departments (DEPARTMENT_ID), --add foreign key
  FOREIGN KEY JHIST_EMPLOYEE_FK (EMPLOYEE_ID) REFERENCES employees(EMPLOYEE_ID), --add foreign key
  FOREIGN KEY JHIST_JOB_FK (JOB_ID) REFERENCES jobs(JOB_ID) --add foreign key
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `job_history`
--

INSERT INTO HR.`job_history` (`EMPLOYEE_ID`, `START_DATE`, `END_DATE`, `JOB_ID`, `DEPARTMENT_ID`) VALUES 
('117689 ', '1993-01-13', '1998-07-24', 'IT_PROG', '60'), 
('350889', '1989-09-21', '1993-10-27', 'AC_ACCOUNT', '110'), 
('508295', '1993-10-28', '1997-03-15', 'AC_MGR', '110'), 
('414559', '1996-02-17', '1999-12-19', 'MK_REP', '20'), 
('718783', '1998-03-24', '1999-12-31', 'ST_CLERK', '50'), 
('822207', '1999-01-01', '1999-12-31', 'ST_CLERK', '50'), 
('893031', '1987-09-17', '1993-06-17', 'AD_ASST', '90'), 
('996300', '1998-03-24', '1998-12-31', 'SA_REP', '80'), 
('752312', '1999-01-01', '1999-12-31', 'SA_MAN', '80'), ('223080', '1994-07-01', '1998-12-31', 'AC_ACCOUNT', '90'), 
('0', '0000-00-00', '0000-00-00', '', '0');



--
-- Table structure for table jobs
--

CREATE TABLE IF NOT EXISTS HR.jobs (
  JOB_ID varchar(10) NOT NULL,
  JOB_TITLE varchar(35) NOT NULL,
  MIN_SALARY decimal(10,2) UNSIGNED DEFAULT NULL, --added UNSIGNED and 2 decimal places
  MAX_SALARY decimal(10,2) UNSIGNED DEFAULT NULL, --added UNSIGNED and 2 decimal places
  PRIMARY KEY (JOB_ID)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO HR.`jobs` (`JOB_ID`, `JOB_TITLE`, `MIN_SALARY`, `MAX_SALARY`) VALUES
('AD_PRES', 'President', '200000', '400000'),
('AD_VP', 'Administration Vice President', '150000', '300000'),
('AD_ASST', 'Administration Assistant', '3000', '6000'),
('FI_MGR', 'Finance Manager', '82000', '160000'),
('FI_ACCOUNT', 'Accountant', '42000', '90000'),
('AC_MGR', 'Accounting Manager', '82000', '160000'),
('AC_ACCOUNT', 'Public Accountant', '4200', '9000'),
('SA_MAN', 'Sales Manager', '100000', '200000'),
('SA_REP', 'Sales Representative', '6000', '12000'),
('PU_MAN', 'Purchasing Manager', '80000', '150000'),
('PU_CLERK', 'Purchasing Clerk', '2500', '5500'),
('ST_MAN', 'Stock Manager', '55000', '85000'),
('ST_CLERK', 'Stock Clerk', '2000', '5000'),
('SH_CLERK', 'Shipping Clerk', '2500', '5500'),
('IT_PROG', 'Programmer', '40000', '100000'),
('MK_MAN', 'Marketing Manager', '90000', '150000'),
('MK_REP', 'Marketing Representative', '4000', '9000'),
('HR_REP', 'Human Resources Representative', '4000', '9000'),
('PR_REP', 'Public Relations Representative', '4500', '10500');

--
-- Table structure for table locations
--

CREATE TABLE IF NOT EXISTS HR.locations (
  LOCATION_ID INT(4) UNSIGNED NOT NULL, --changed data type to INT UNSIGNED to avoid negative values
  STREET_ADDRESS varchar(40) DEFAULT NULL,
  POSTAL_CODE varchar(12) DEFAULT NULL,
  CITY varchar(30) NOT NULL,
  STATE_PROVINCE varchar(25) DEFAULT NULL,
  COUNTRY_ID varchar(2) NOT NULL, --changed to NOT NULL
  PRIMARY KEY (LOCATION_ID),
  FOREIGN KEY LOC_COUNTRY_FK (COUNTRY_ID) REFERENCES countries(COUNTRY_ID), --add foreign key
  KEY `LOC_CITY_IX` (`CITY`),
  KEY `LOC_STATE_PROVINCE_IX` (`STATE_PROVINCE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO HR.`locations` (`LOCATION_ID`, `STREET_ADDRESS`, `POSTAL_CODE`, `CITY`, `STATE_PROVINCE`, `COUNTRY_ID`) VALUES
('1000', '1297 Via Cola di Rie', '989', 'Roma', '', 'IT'),
('1100', '93091 Calle della Testa', '10934', 'Venice', '', 'IT'),
('1200', '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
('1300', '9450 Kamiya-cho', '6823', 'Hiroshima', '', 'JP'),
('1400', '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
('1500', '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
('1600', '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
('1700', '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
('1800', '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
('1900', '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
('2000', '40-5-12 Laogianggen', '190518', 'Beijing', '', 'CN'),
('2100', '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
('2200', '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
('2300', '198 Clementi North', '540198', 'Singapore', '', 'SG'),
('2400', '8204 Arthur St', '', 'London', '', 'UK'),
('2500', '"Magdalen Centre', ' The Oxford ', 'OX9 9ZB', 'Oxford', 'Ox'),
('2600', '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK'),
('2700', 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE'),
('2800', 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
('2900', '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH'),
('3000', 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
('3100', 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
('3200', 'Mariano Escobedo 9991', '11932', 'Mexico City', '"Distrito Federal', '"');

-- --------------------------------------------------------

--
-- Table structure for table regions
--

CREATE TABLE IF NOT EXISTS HR.regions (
  REGION_ID INT (4) UNSIGNED NOT NULL, --changed data type to INT UNSIGNED to avoid negative values
  REGION_NAME varchar(25) DEFAULT NULL,
  PRIMARY KEY (REGION_ID),
  UNIQUE KEY rg_name_key (REGION_NAME)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `regions`
--

INSERT INTO HR.`regions` (`REGION_ID`, `REGION_NAME`) VALUES
('1', 'Europe\r'),
('2', 'Americas\r'),
('3', 'Asia\r'),
('4', 'Middle East and Africa\r');