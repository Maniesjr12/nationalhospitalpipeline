
CREATE TABLE EDW.dim_patient(
    patient_id varchar(50) primary key,
    first_name text,
    last_name text,
    dob date,
    gender text,
    ethnicity text,
    "address" text,
    contact_no text,
    loaded_date date,
);

CREATE TABLE STG.dim_patient(
    patient_id varchar(50) primary key,
    first_name text,
    last_name text,
    dob date,
    gender text,
    ethnicity text,
    "address" text,
    contact_no text,
    loaded_date date,
);

CREATE TABLE EDW.dim_participants(
    participants_id varchar(50) primary key,
    trial_id VARCHAR(50),
    patient_id VARCHAR(50),
    enrollment_date date,
    status text,
    loaded_date date
);

CREATE TABLE STG.dim_participants(
    participants_id varchar(50) primary key,
    trial_id VARCHAR(50),
    patient_id VARCHAR(50),
    enrollment_date date,
    status text,
    loaded_date date
);

CREATE TABLE EDW.dim_date(
    datekey date PRIMARY KEY,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    week INTEGER,
    dayOfweek INTEGER
);

CREATE TABLE EDW.fact_med_record(
    record_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    admission_date date,
    discharge_date date,
    daignosis text,
    treatment_desc text,
    med_presc text,
    loaded_date date
);

CREATE TABLE STG.fact_med_record(
    record_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    admission_date date,
    discharge_date date,
    daignosis text,
    treatment_desc text,
    med_presc text,
    loaded_date date
);


CREATE TABLE EDW.fact_labs(
    result_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    lab_type VARCHAR(20),
    lab_date date,
    "result" text,
    image_url text,
    ref_range text,
    loaded_date date
)


CREATE TABLE STG.fact_labs(
    result_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    lab_type VARCHAR(20),
    lab_date date,
    "result" text,
    image_url text,
    ref_range text,
    loaded_date date
)


CREATE TABLE EDW.fact_trails(
    trial_id VARCHAR(50) PRIMARY KEY,
    trial_name text,
    princ_invest text,
    start_date date,
    decription text,
    loaded_date date
)


CREATE TABLE STG.fact_trails(
    trial_id VARCHAR(50) PRIMARY KEY,
    trial_name text,
    princ_invest text,
    start_date date,
    decription text,
    loaded_date date
)



DECLARE @startDate DATE  = '2020-01-01';
DECLARE @endDate DATE  = '2029-12-31';



with DateSeries AS (
    SELECT @startDate as datekey
    UNION ALL
    SELECT DATEADD(DAY, 1, datekey)
    FROM DateSeries
    WHERE datekey < @endDate
)

INSERT into EDW.dim_date 
SELECT datekey,
    YEAR(datekey) as YEAR,
    DATEPART( QUARTER, datekey) as QUARTER,
    MONTH(datekey) as MONTH,
    DATEPART(weekday, datekey) as DayOfWeek
FROM DateSeries

OPTION(MAXRECURSION 0)


