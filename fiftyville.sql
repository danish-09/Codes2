--For name of thief:

-- sql query using which we get a list of names of people whose license plate was captured by the security for time interval 10:15 to 10:25(gives us 8 names)

select name 
  from people 
  where license_plate in (select license_plate from bakery_security_logs where year=2021 and month=7 and day=28 and hour=10 and minute>=15 and minute<=25)

-- sql query using which we get a list of names of people who boarded the first flight on 29 july from fiftyville regional airpot (gives us 8 names)

select name
  from people 
  where passport_number in(select passport_number from passengers where flight_id=(select id from flights where origin_airport_id=8
  and month=7 and day=29 and year=2021 order by hour limit 1));

-- using above two queries we only take into consideration the names of people which were common in between both these queries ,that leaves us with 4 names

-- sql query to display names of people who performed the atm transaction on 28 july at Leggett Street

select name
  from people 
  where id in (select person_id from bank_accounts where account_number in (select account_number from atm_transactions where year=2021
  and month=7 and day=28 and atm_location="Leggett Street" and transaction_type="withdraw"));

-- using above 3 queries we narrow our names down to 2 after selecting the common names among these 3 outputs

-- sql query which displays names of people who made call on 28 july whose duration was less than 1 minute

select name
  from people
  where phone_number in (select caller from phone_calls where year=2021 and month=7 and day=28 and duration<60)

-- using above 4 queries we narrow our names down to 1 by selecting the common name among these 4 outputs

--For the city which thief escaped to:

-- sql query to find destination airport's id

select destination_airport_id 
  from flights 
  where origin_airport_id=8 and year=2021 and month=7 and day=29 and id=(select id from flights where origin_airport_id=8
  and year=2021 and month=7 and day=29 order by hour limit 1);

-- sql query to find the city which the thief escaped to (we got id from the previos query)

select city
  from airports 
  where id=(select destination_airport_id from flights where origin_airport_id=8 and year=2021 and month=7 and day=29 and
  id=(select id from flights where origin_airport_id=8 and year=2021 and month=7 and day=29 order by hour limit 1));

--For the accomplice who helped the thief to escape:

-- sql query to display name of accomplice who helped the thief to escape (we know now who the caller was)

select name
  from people 
  where phone_number=(select receiver from phone_calls where year=2021 and month=7 and day=28 and duration<60 and caller=(select phone_number
  from people where name="Bruce"));
