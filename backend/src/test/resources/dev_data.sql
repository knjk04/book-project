--Insert into publisher table

INSERT INTO publisher (name) VALUES
	 ('Bloomsbury Publishing'),
	 ('Scholastic Corporation');

--Insert into author table

INSERT INTO author (full_name)
  SELECT 'J.K. Rowling' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM author WHERE full_name='J.K. Rowling');


INSERT INTO author (full_name)
  SELECT 'Neil Gaiman' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM author WHERE full_name='Neil Gaiman');


INSERT INTO author (full_name)
  SELECT 'J.R.R Tolkien' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM author WHERE full_name='J.R.R Tolkien');


INSERT INTO author (full_name)
  SELECT 'Roald Dahl' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM author WHERE full_name='Roald Dahl');


INSERT INTO author (full_name)
  SELECT 'Robert Galbraith' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM author WHERE full_name='Robert Galbraith');


INSERT INTO author (full_name)
  SELECT 'Dan Brown' FROM DUAL
WHERE NOT EXISTS
  (SELECT full_name FROM author WHERE full_name='Dan Brown');


--Insert into predefined_shelf table

INSERT INTO predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'To read',0,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM predefined_shelf WHERE user_id=1 and shelf_name='To read');


 INSERT INTO predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'Reading',1,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM predefined_shelf WHERE user_id=1 and shelf_name='Reading');


 INSERT INTO predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'Read',2,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM predefined_shelf WHERE user_id=1 and shelf_name='Read');

INSERT INTO predefined_shelf (shelf_name,predefined_shelf_name,user_id)
  SELECT 'Did not finish',3,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT shelf_name,predefined_shelf_name,user_id FROM predefined_shelf WHERE user_id=1 and shelf_name='Did not finish');


--Insert into book table


INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,'2021-05-27',NULL,679,811,2,0,5,'Must Read Book. Really Enjoyed it','Harry Potter and the Philosopher''s stone',4,NULL,NULL,1989 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Thomas' and title='Harry Potter and the Philosopher''s stone');

INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Luke',NULL,'2021-05-29','2021-05-27',NULL,300,627,3,15,7,'Must Read Book. Really Enjoyed it','Stardust',2,NULL,NULL,1945 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Luke' and title='Stardust');

INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Christina',NULL,'2021-05-29','2021-05-27',NULL,329,485,3,1,9,'Must Read Book. Really Enjoyed it','Harry Potter and the Chamber of Secrets',3,NULL,NULL,1965 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Christina' and title='Harry Potter and the Chamber of Secrets');

INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Christina',NULL,'2021-05-29','2021-05-27',NULL,806,704,3,12,9,'Must Read Book. Really Enjoyed it','Harry Potter and the Prisoner of Azkaban',6,NULL,NULL,1970 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Christina' and title='Harry Potter and the Prisoner of Azkaban');

INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,'2021-05-27',NULL,455,776,4,0,2,'Must Read Book. Really Enjoyed it','Origin',5,NULL,NULL,1955 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Thomas' and title='Origin');

INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,NULL,NULL,815,765,1,0,1,'Must Read Book. Really Enjoyed it','Harry Potter and the Goblet of Fire',5,NULL,NULL,1963 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Thomas' and title='Harry Potter and the Goblet of Fire');

INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Christina',NULL,NULL,'2021-05-27',NULL,681,988,2,0,6,'Must Read Book. Really Enjoyed it','Harry Potter and the Order of Phoenix',6,NULL,NULL,1925 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Christina' and title='Harry Potter and the Order of Phoenix');

INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Thomas',NULL,NULL,NULL,NULL,726,974,1,0,8,'Must Read Book. Really Enjoyed it','Matilda',2,NULL,NULL,2020 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Thomas' and title='Matilda');


INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'John',NULL,NULL,'2021-05-27',NULL,844,724,2,0,6,'Must Read Book. Really Enjoyed it','Harry Potter and the Half-Blood Prince',2,NULL,NULL,1924 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'John' and title='Harry Potter and the Half-Blood Prince');


INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Sally',NULL,NULL,NULL,NULL,697,741,1,0,8,'Must Read Book. Really Enjoyed it','The Hobbit',2,NULL,NULL,1936 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Sally' and title='The Hobbit');


INSERT INTO book (book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication)
  SELECT 'Luke',NULL,NULL,NULL,NULL,461,793,1,0,4,'Must Read Book. Really Enjoyed it','Harry Potter and the Deathly Hallows',3,NULL,NULL,1934 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_recommended_by,user_created_shelf_id,date_finished_reading,date_started_reading,edition,number_of_pages,pages_read,predefined_shelf_id,rating,series_position,book_review,title,author_id,isbn,book_format,year_of_publication FROM book WHERE book_recommended_by= 'Luke' and title='Harry Potter and the Deathly Hallows');


--Insert into tag table

INSERT INTO tag (name)
  SELECT 'Adventure' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM tag WHERE name='Adventure');


INSERT INTO tag (name)
  SELECT 'Interesting' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM tag WHERE name='Interesting');


INSERT INTO tag (name)
  SELECT 'Tolkien' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM tag WHERE name='Tolkien');


INSERT INTO tag (name)
  SELECT 'Pokemon' FROM DUAL
WHERE NOT EXISTS
  (SELECT name FROM tag WHERE name='Pokemon');



--Insert into book_publisher table


INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 1,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=1 and publisher_id=1);


INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 3,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=3 and publisher_id=1);


 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 5,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=5 and publisher_id=1);


 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 7,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=7 and publisher_id=1);


 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 10,1 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=10 and publisher_id=1);


 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 2,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=2 and publisher_id=2);


 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 4,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=4 and publisher_id=2);


 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 6,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=6 and publisher_id=2);

 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 8,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=8 and publisher_id=2);

INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 9,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=9 and publisher_id=2);


 INSERT INTO book_publisher (book_id,publisher_id)
  SELECT 11,2 FROM DUAL
WHERE NOT EXISTS
  (SELECT book_id,publisher_id FROM book_publisher WHERE book_id=11 and publisher_id=2);