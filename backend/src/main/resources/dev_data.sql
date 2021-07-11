--Insert into author table

INSERT INTO bookproject.author (full_name)
  SELECT 'J.K. Rowling' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM bookproject.author WHERE full_name='J.K. Rowling');


INSERT INTO bookproject.author (full_name)
  SELECT 'Neil Gaiman' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM bookproject.author WHERE full_name='Neil Gaiman');


INSERT INTO bookproject.author (full_name)
  SELECT 'J.R.R Tolkien' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM bookproject.author WHERE full_name='J.R.R Tolkien');


INSERT INTO bookproject.author (full_name)
  SELECT 'Roald Dahl' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM bookproject.author WHERE full_name='Roald Dahl');


INSERT INTO bookproject.author (full_name)
  SELECT 'Robert Galbraith' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM bookproject.author WHERE full_name='Robert Galbraith');


INSERT INTO bookproject.author (full_name)
  SELECT 'Dan Brown' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM bookproject.author WHERE full_name='Dan Brown');


--Insert into tag table

INSERT INTO bookproject.tag (name)
  SELECT 'Adventure' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM bookproject.tag WHERE name='Adventure');


INSERT INTO bookproject.tag (name)
  SELECT 'Interesting' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM bookproject.tag WHERE name='Interesting');


INSERT INTO bookproject.tag (name)
  SELECT 'Tolkien' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM bookproject.tag WHERE name='Tolkien');


INSERT INTO bookproject.tag (name)
  SELECT 'Pokemon' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM bookproject.tag WHERE name='Pokemon');



--Insert into book_publisher table


INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 1,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=1 and publisher_id=1);


INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 3,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=3 and publisher_id=1);


 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 5,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=5 and publisher_id=1);


 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 7,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=7 and publisher_id=1);


 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 10,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=10 and publisher_id=1);


 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 2,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=2 and publisher_id=2);


 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 4,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=4 and publisher_id=2);


 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 6,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=6 and publisher_id=2);

 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 8,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=8 and publisher_id=2);

INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 9,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=9 and publisher_id=2);


 INSERT INTO bookproject.book_publisher (book_id,publisher_id)
  SELECT 11,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM bookproject.book_publisher WHERE book_id=11 and publisher_id=2);


--Insert into predefined_shelf table

INSERT INTO bookproject.predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'To read',0,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM bookproject.predefined_shelf WHERE user_id=1 and shelf_name='To read');


 INSERT INTO bookproject.predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'Reading',1,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM bookproject.predefined_shelf WHERE user_id=1 and shelf_name='Reading');


 INSERT INTO bookproject.predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'Read',2,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM bookproject.predefined_shelf WHERE user_id=1 and shelf_name='Read');

INSERT INTO bookproject.predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'Did not finish',3,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM bookproject.predefined_shelf WHERE user_id=1 and shelf_name='Did not finish');



--Insert into book table


INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,'2021-05-27',NULL,NULL,679,811,2,0,5,'Must Read Book. Really Enjoyed it','Harry Potter and the Philosopher''s stone',4,NULL,NULL,1989 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Thomas' and title='Harry Potter and the Philosopher''s stone');

INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Luke',NULL,'2021-05-29','2021-05-27',NULL,NULL,300,627,3,15,7,'Must Read Book. Really Enjoyed it','Stardust',2,NULL,NULL,1945 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Luke' and title='Stardust');

INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Christina',NULL,'2021-05-29','2021-05-27',NULL,NULL,329,485,3,1,9,'Must Read Book. Really Enjoyed it','Harry Potter and the Chamber of Secrets',3,NULL,NULL,1965 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Christina' and title='Harry Potter and the Chamber of Secrets');

INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Christina',NULL,'2021-05-29','2021-05-27',NULL,NULL,806,704,3,12,9,'Must Read Book. Really Enjoyed it','Harry Potter and the Prisoner of Azkaban',6,NULL,NULL,1970 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Christina' and title='Harry Potter and the Prisoner of Azkaban');

INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,'2021-05-27',NULL,NULL,455,776,4,0,2,'Must Read Book. Really Enjoyed it','Origin',5,NULL,NULL,1955 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Thomas' and title='Origin');

INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,NULL,NULL,NULL,815,765,1,0,1,'Must Read Book. Really Enjoyed it','Harry Potter and the Goblet of Fire',5,NULL,NULL,1963 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Thomas' and title='Harry Potter and the Goblet of Fire');

INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Christina',NULL,NULL,'2021-05-27',NULL,NULL,681,988,2,0,6,'Must Read Book. Really Enjoyed it','Harry Potter and the Order of Phoenix',6,NULL,NULL,1925 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Christina' and title='Harry Potter and the Order of Phoenix');

INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,NULL,NULL,NULL,726,974,1,0,8,'Must Read Book. Really Enjoyed it','Matilda',2,NULL,NULL,2020 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Thomas' and title='Matilda');


INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'John',NULL,NULL,'2021-05-27',NULL,NULL,844,724,2,0,6,'Must Read Book. Really Enjoyed it','Harry Potter and the Half-Blood Prince',2,NULL,NULL,1924 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'John' and title='Harry Potter and the Half-Blood Prince');


INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Sally',NULL,NULL,NULL,NULL,NULL,697,741,1,0,8,'Must Read Book. Really Enjoyed it','The Hobbit',2,NULL,NULL,1936 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Sally' and title='The Hobbit');


INSERT INTO bookproject.book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Luke',NULL,NULL,NULL,NULL,NULL,461,793,1,0,4,'Must Read Book. Really Enjoyed it','Harry Potter and the Deathly Hallows',3,NULL,NULL,1934 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,book_genre,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM bookproject.book WHERE book_recommended_by= 'Luke' and title='Harry Potter and the Deathly Hallows');