select title from movies
join stars on stars.movie_id=movies.id
join people on people.id=stars.person_id
where person_id=(select id from people where name="Bradley Cooper")
intersect
select title from movies
join stars on stars.movie_id=movies.id
join people on people.id=stars.person_id
where person_id=(select id from people where name="Jennifer Lawrence")
