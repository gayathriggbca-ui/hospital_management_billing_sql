-- 1. DATABASE SETUP
-- Run this once before the script (skip if the database already exists):
-- create database hospitals;

use hospitals;
show tables;

-- 2. APPOINTMENTS ANALYSIS
describe appointments;
select * from appointments;
select count(*) from appointments;
select sum(appointment_id is null)as appointment_id_null,sum(patient_id is null)as patient_id_null,sum(doctor_id is null)as doctor_id_null,
sum(appointment_date is null)as date_null,sum(appointment_time is null)as time_null,sum(reason_for_visit is null)as reason_null,
sum(status is null)as status_null from appointments;

select appointment_id,patient_id,doctor_id,appointment_date,appointment_time,reason_for_visit,status,count(*) as total_records from appointments
group by appointment_id,patient_id,doctor_id,appointment_date,appointment_time,reason_for_visit,status having count(*)>1;

select appointment_id,count(*)as total_appointment_id from appointments group by appointment_id having count(*)>1;
select patient_id,count(*)as total_patient_id from appointments group by patient_id having count(*)>1 order by total_patient_id desc;

select count(distinct doctor_id) from appointments;
SELECT appointment_time FROM appointments WHERE appointment_time NOT REGEXP '^[0-9]{1,2}:[0-9]{2}:[0-9]{2}$';
SELECT appointment_date FROM appointments WHERE appointment_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';
alter table appointments modify appointment_date DATE, modify appointment_time TIME;

select count(appointment_date)from appointments;
select count(distinct appointment_date)from appointments;
select max(appointment_date)as latest_date,min(appointment_date)as earliest_date from appointments;
select * from appointments where appointment_date<'2023-01-01' or appointment_date>'2023-12-31';

select distinct status from appointments order by status;
select distinct reason_for_visit from appointments order by reason_for_visit;
select distinct appointment_time from appointments order by appointment_time;

select * from appointments where appointment_time<'08:00:00' or appointment_time>'17:45:00';

select * from appointments where appointment_id is null or appointment_id not regexp '^A[0-9]{3}$';
select * from appointments where patient_id is null or patient_id not regexp '^P[0-9]{3}$';
select * from appointments where doctor_id is null or doctor_id not regexp '^D[0-9]{3}$';

select  appointment_date,count(*) as total_date from appointments group by appointment_date order by total_date desc;
select * from appointments where appointment_date='2023-08-09';

select reason_for_visit,count(*)as total_reason from appointments group by reason_for_visit;
select  status,count(*)as total_status from appointments group by status;
select * from appointments where status <> trim(status) or reason_for_visit <> trim(reason_for_visit)
   or status = '' or reason_for_visit = '';

   -- 3. BILLING ANALYSIS

 select * from billing;
 select count(*)from billing;
describe billing;
select sum(bill_id is null)as bill_null,sum(patient_id is null)as patient_null,sum(treatment_id is null)as treat_null,sum(bill_date is null)
as bill_date_null,sum(amount is null)as amount_null,sum(payment_method is null)as payment_null,sum(payment_status is null)as status_null
from billing;
select bill_id,patient_id,treatment_id,bill_date,amount,payment_method,payment_status,count(*)as total_row from billing group by
 bill_id,patient_id,treatment_id,bill_date,amount,payment_method,payment_status having count(*)>1;
 select * from billing where bill_id not regexp '^B[0-9]{3}$';
 select count(distinct bill_id)from billing;
 select count(distinct patient_id)from billing;
 SELECT patient_id,count(*)as total_patient_id from billing group by patient_id having count(*)>1 order by total_patient_id desc;
 SELECT patient_id, treatment_id, bill_date, amount, COUNT(*) AS total FROM billing GROUP BY patient_id, treatment_id, bill_date,
 amount HAVING COUNT(*) > 1;
  select * from billing where patient_id not regexp '^P[0-9]{3}$';
  select count(distinct treatment_id)from billing;
select * from billing where treatment_id not regexp '^T[0-9]{3}$';
alter table billing modify bill_date date,modify amount decimal(10,2);
select count(distinct bill_date)from billing;
select bill_date,count(*)as total_bill from billing group by bill_date having count(*)>1 order by total_bill desc;
select bill_id,patient_id,bill_date,amount from billing where bill_date in(select bill_date from billing group by bill_date having count(*)>1) 
order by bill_date desc;
SELECT treatment_id, amount FROM billing WHERE amount < 0 ;
select distinct payment_method from billing;
select payment_method,count(*)as total_payment from billing group by payment_method having count(*)>1;
select distinct payment_status from billing;
select payment_status,count(*)as total_status from billing group by payment_status having count(*)>1;
select * from billing where payment_method<>trim(payment_method);
select * from billing where payment_status<>trim(payment_status);

-- 4. DOCTORS ANALYSIS

select * from doctors;
describe doctors;
select count(*)from doctors;
alter table doctors modify phone_number varchar(20);
SELECT SUM(doctor_id IS NULL) AS doctor_id_null, SUM(first_name IS NULL) AS first_name_null, SUM(last_name IS NULL) AS last_name_null, 
SUM(specialization IS NULL) AS specialization_null, SUM(phone_number IS NULL) AS phone_number_null, SUM(years_experience IS NULL) AS
years_experience_null, SUM(hospital_branch IS NULL) AS hospital_branch_null, SUM(email IS NULL) AS email_null FROM doctors;
 SELECT doctor_id, first_name, last_name, specialization, phone_number, years_experience, hospital_branch, email, COUNT(*) AS total_count FROM doctors 
 GROUP BY doctor_id, first_name, last_name, specialization, phone_number, years_experience, hospital_branch, email HAVING COUNT(*) > 1;
 SELECT doctor_id,COUNT(*) AS total_count FROM doctors GROUP BY doctor_id HAVING COUNT(*)>1;
 SELECT * FROM doctors WHERE doctor_id NOT REGEXP '^D[0-9]{3}$';
  SELECT * FROM doctors WHERE first_name<>TRIM(first_name) OR last_name<>TRIM(last_name);

 SELECT * FROM doctors WHERE phone_number NOT REGEXP '^[0-9]{10}$';
 SELECT * FROM doctors WHERE years_experience<0;
 SELECT * FROM doctors WHERE years_experience>60;
 SELECT * FROM doctors WHERE email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,}$';
 SELECT specialization,COUNT(*) AS total_count FROM doctors GROUP BY specialization ORDER BY total_count DESC;
 select doctor_id,first_name,last_name,specialization,phone_number from doctors group by doctor_id,first_name,last_name,specialization,phone_number
 having count(*)>1;
 SELECT hospital_branch,COUNT(*) AS total_count FROM doctors GROUP BY hospital_branch ORDER BY total_count DESC;
 select doctor_id,first_name,last_name,specialization,phone_number,hospital_branch from doctors group by doctor_id,first_name,last_name,
 specialization,phone_number,hospital_branch having count(*)>1;
 SELECT phone_number,COUNT(*) AS total_count FROM doctors GROUP BY phone_number HAVING COUNT(*)>1;
 SELECT email,COUNT(*) AS total_count FROM doctors GROUP BY email HAVING COUNT(*)>1;
 SELECT * FROM doctors WHERE first_name REGEXP '[0-9]' OR last_name REGEXP '[0-9]';
 SELECT years_experience,COUNT(*) AS total_experience FROM doctors GROUP BY years_experience ORDER BY total_experience desc;
 SELECT * FROM doctors WHERE specialization<>TRIM(specialization) OR hospital_branch<>TRIM(hospital_branch);
SELECT * FROM doctors WHERE first_name = '' OR last_name = '' OR specialization = '' OR hospital_branch = '' OR email = ''; 
   SELECT * FROM doctors WHERE TRIM(first_name) = '' OR TRIM(last_name) = '' OR TRIM(specialization) = '' OR TRIM(hospital_branch) = '' OR
   TRIM(email) = '';

-- 5. PATIENTS ANALYSIS

select * from patients;
select count(*)from patients;
describe patients;
alter table patients modify date_of_birth date,modify contact_number varchar(20);
alter table patients modify registration_date date;
select sum(patient_id is null)as patient_null,sum(first_name is null)as first_null,sum(last_name is null)as last_null,sum(gender is null)
as gender_null,sum(date_of_birth is null)as date_null,sum(contact_number is null)as contact_null,sum(address is null)as address_null,
sum(registration_date is null)as registration_null,sum(insurance_provider is null)as insprovider_null,sum(insurance_number is null)
as insno_null,sum(email is null)as email_null from patients;
select patient_id,first_name,last_name,gender,date_of_birth,contact_number,address,registration_date,insurance_provider,insurance_number,
email from patients group by patient_id,first_name,last_name,gender,date_of_birth,contact_number,address,registration_date,insurance_provider,
insurance_number,email having count(*)>1;
select count(distinct patient_id)from patients;
select * from patients where patient_id  not regexp '^P[0-9]{3}$';
select first_name from patients where first_name<>trim(first_name);
select count(distinct first_name) from patients;
select count(distinct last_name) from patients;
select last_name from patients where last_name<>trim(last_name);
select patient_id,first_name,last_name,gender,contact_number,address from patients group by patient_id,first_name,last_name,gender,contact_number,
address having count(*)>1;
select distinct gender from patients;
select patient_id,first_name,last_name,gender from patients group by patient_id,first_name,last_name,gender having count(*)>1
order by gender;
select * from patients where email not regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,}$';
select distinct email,count(*)as total_email from patients group by email order by total_email desc;
select patient_id,first_name,last_name,date_of_birth,contact_number,email from patients where email 
in(select email from patients group by email having count(*)>1)
order by patient_id,email;
select date_of_birth,count(*)as total_date_birth from patients group by date_of_birth having count(*)>1 order by date_of_birth desc;
select * from patients where date_of_birth='1993-04-13';
select count(distinct contact_number) from patients; 
select * from patients where contact_number not regexp '^[0-9]{10}$';
select count(distinct address)from patients;
select address,count(*)as total_address from patients group by address having count(*)>1;
select patient_id,first_name,last_name,date_of_birth,contact_number,address from patients where address in(select address from patients group by address
having count(*)>1) order by address;
select * from patients where address='789 Pine Rd';
select * from patients where address='321 Maple Dr';
select * from patients where address='123 Elm St';
select * from patients where address='456 Oak Ave';
select count(distinct registration_date)from patients;
select count(distinct insurance_number)from patients;
select * from patients where insurance_number not regexp '^INS[0-9]{6}$';
 select * from patients where date_of_birth>curdate();
 select * from patients where registration_date<date_of_birth;
 
 -- 6. TREATMENTS ANALYSIS
 
 select * from treatments;
 describe treatments;
 alter table treatments modify treatment_date date;
 select count(*) from treatments;
 select sum(treatment_id is null)as treatment_null,sum(appointment_id is null)as appoint_null,sum(treatment_type is null)as treatment_type_null,
sum(description is null)as descrip_null,sum(cost is null)as cost_null,sum(treatment_date is null)as treatdate_null from treatments;
select treatment_id,appointment_id,treatment_type,description,cost,treatment_date from treatments group by treatment_id,appointment_id,
treatment_type,description,cost,treatment_date having count(*)>1;

 select count(distinct treatment_id)from treatments;
 select * from treatments where treatment_id not regexp '^T[0-9]{3}$';
 select count(distinct appointment_id) from treatments;
select * from treatments where appointment_id not regexp '^A[0-9]{3}$';
select distinct treatment_type from treatments;
select treatment_type,count(*)as total_type from treatments group by treatment_type order by total_type desc;
select * from treatments where treatment_type<>trim(treatment_type);
select treatment_id,appointment_id,treatment_type,treatment_date from treatments group by treatment_id,appointment_id,treatment_type,treatment_date
having count(*)>1;
select * from treatments where description<>trim(description);
select count(distinct description) from treatments;
select description,count(*)as total_des from treatments group by description having count(*)>1;
select treatment_id,treatment_type,description,cost from treatments group by treatment_id,treatment_type,description,cost having count(*)>1;
select count(distinct cost)from treatments;
SELECT treatment_id, cost FROM treatments WHERE cost < 0;
select count(distinct treatment_date)from treatments;
select treatment_type,treatment_date from treatments group by treatment_type,treatment_date having count(*)>1;
SELECT min(treatment_date) AS earliest_date,MAX(treatment_date)AS latest_date FROM treatments;
select * from treatments where treatment_date <'2023-01-01' or treatment_date>'2023-12-31';
SELECT * FROM treatments WHERE TRIM(treatment_id) = '' OR TRIM(appointment_id) = '' OR TRIM(treatment_type) = '' OR TRIM(description) = '';


 -- 7. CROSS-TABLE ANALYSIS
 select a.* from appointments a left join patients p on a.patient_id=p.patient_id where p.patient_id is null;
 select a.* from appointments a left join doctors d on a.doctor_id=d.doctor_id where d.doctor_id is null;
 select t.* from treatments t left join appointments a on t.appointment_id=a.appointment_id where a.appointment_id is null;
 select b.* from billing b left join treatments t on b.treatment_id=t.treatment_id where t.treatment_id is null;
 select b.* from billing b left join patients p on b.patient_id=p.patient_id where p.patient_id is null;
 select b.bill_id,b.amount,t.cost from billing b left join treatments t on b.treatment_id=t.treatment_id  where t.treatment_id IS NOT NULL
  AND b.amount <> t.cost;
 select t.treatment_id,t.treatment_date,a.appointment_date from treatments t left join appointments a on t.appointment_id=a.appointment_id
 where treatment_date<appointment_date;
 
 select a.appointment_id,a.patient_id,a.appointment_date,p.registration_date,a.status from appointments a left join patients p on 
 a.patient_id=p.patient_id where a.appointment_date<p.registration_date;
 
 select a.status,count(b.bill_id)as total_bill,sum(b.amount)as billed,sum(b.payment_status='Paid')as marked_as_paid from appointments a left join 
 treatments t on a.appointment_id=t.appointment_id left join billing b on t.treatment_id=b.treatment_id group by a.status;
 SELECT patient_id, appointment_date, appointment_time, COUNT(*) AS total
FROM appointments GROUP BY patient_id, appointment_date, appointment_time HAVING COUNT(*) > 1;
  select * from appointments where patient_id='P036';

  SELECT doctor_id, appointment_date, appointment_time, COUNT(*) AS doctor_bookings FROM appointments GROUP BY doctor_id, appointment_date, 
  appointment_time HAVING COUNT(*) > 1;

 select d.specialization,t.treatment_type,count(*)as n from appointments a join doctors d on a.doctor_id=d.doctor_id join treatments t on
 a.appointment_id=t.appointment_id group by d.specialization,t.treatment_type order by d.specialization,n desc;