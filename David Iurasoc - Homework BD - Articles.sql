-- Proiectati o baza de date pentru gestionarea unui blog de articole postate online. Baza de date trebuie sa aiba urmatoarele tabele:

-- 1.	Users(id, nume, prenume, email, parola, id_rol)
-- 2.	User_roles(id, descriere)
-- 3.	Articles (id, id_author, title, category, article_body, date )
-- 4.	Cometarii(id, id_article, comment, id_user, date)
-- 5.	Ratings(id, id_article, rating)

-- Diagrama si populare bazei de date cu inregistrari [t teste! 

SHOW DATABASES;

CREATE DATABASE InfoTema1;
USE InfoTema1;


-- 1.	Users(id, nume, prenume, email, parola, id_rol)
-- Tabel: Users ---------------------------------------------------------------------------

DROP TABLE Users;
TRUNCATE TABLE Users;

CREATE TABLE Users(
	id int primary key auto_increment unique not null,
    nume nvarchar(55),
    prenume nvarchar(55),
    email nvarchar(55) unique ,
    parola binary(55),
    id_rol int,
    foreign key(id_rol) references User_roles(id)
);

INSERT INTO Users (id, nume, prenume, email, parola, id_rol)
VALUES 
	(1, 'Charlie', 'Kirk', 'CharlKTPUK@gmail.com', 'idontevenknow0', 2),
    (2, 'David', 'Iurasoc', 'iurasoc30Dof@gmail.com', 'idontevenknow1', 1),
    (3, 'Lili', 'Marosan', 'marosanWr@gmail.com', 'idontevenknow2', 3),
    (4, 'Jordan', 'Peterson', 'JBP@gmail.com', 'idontevenknow3', 2),
    (5, 'Ben', 'Shapiro', 'BenShapiroShow@gmail.com', 'idontevenknow4', 2);
    
INSERT INTO Users (id, nume, prenume, email, parola, id_rol)
VALUES 
	(6, 'Kendrick', 'Nun', 'knun@gmail.com', 'idontevenknow5', 2),
    (7, 'Stephen', 'Curry', 'sc30@gmail.com', 'idontevenknow6', 1),
    (8, 'LeBron', 'James', 'lbj23@gmail.com', 'idontevenknow7', 3);
    
INSERT INTO Users (id, nume, prenume, email, parola, id_rol)
VALUES 
	(9, 'Juhasz', 'Szebasztian', 'jsz@gmail.com', 'idontevenknow5', 2);

SELECT * FROM Users;


-- 2.	User_roles(id, descriere)
-- Tabel: User_roles --------------------------------------------------------------------------------

DROP TABLE User_roles;
TRUNCATE TABLE User_roles;


CREATE TABLE User_roles (
	id int primary key auto_increment unique not null,
    descriere nvarchar(255)
);

INSERT INTO User_roles (id, descriere)
VALUES
	(1, 'Admin'),
    (2, 'Author'),
    (3, 'Reader');

SELECT * FROM User_roles;



-- 3.	Articles (id, id_author, title, category, article_body, date )
-- Tabel: Articles ----------------------------------------------------------------------------------

DROP TABLE Articles;
TRUNCATE TABLE Articles;

CREATE TABLE Articles (
	id int primary key auto_increment unique not null,
    id_author int,
    title nvarchar(255),
    category nvarchar(255),
    article_body nvarchar(255),
    date date,
	foreign key(id_author) references Users(id)
);

INSERT INTO Articles(id, id_author, title, category, article_body, date)
VALUES
	(1, 4, 'On the Psychological and Social Significance of Identity', 'Sociology', '-', '2020-01-21'),
    (2, 4, 'Equity: When the Left Goes Too Far', 'Politics', '-', '2021-9-03'),
    (3, 5, 'Why the legacy media is panicked about Musk"s Twitter takeover', 'Politics', '-', '2021-11-08'),
    (4, 1, 'Should Christians Get Involved With Politics?', 'Politics', '-', '2019-06-12'),
    (5, 5, 'Joe Biden, Dylan Mulvaney and the collapse of the West', 'Politics', '-', '2022-10-29'),
    (6, 4, 'Existentialism in Australia and New Zealand', 'Psychology', '-','2022-02-01');
    
INSERT INTO Articles(id, id_author, title, category, article_body, date)
VALUES
	(7, 6, NULL, NULL, NULL, NULL);

SELECT * FROM Articles;



-- 4.	Cometarii(id, id_article, comment, id_user, date)
-- Tabel: Comentarii -----------------------------------------------------------------------------------------------

DROP TABLE Comments;
TRUNCATE TABLE Comments;

CREATE TABLE Comments (
	id int primary key auto_increment unique not null,
    id_article int,
    comment nvarchar(255),
    id_user int,
    date date,
	foreign key(id_article) references Articles(id),
    foreign key(id_user) references Users(id)
);

INSERT INTO Comments(id, id_article, comment, id_user, date)
VALUES
	(1, 1, 'I agree with you! You are my favotite', 2, '2020-01-24'),
    (2, 1, 'I disagree with you...', 3, '2020-01-25'),
    (3, 5, 'You are totally rigth on this''', 5, '2021-09-10'), -- *
    (4, 3, 'MUSK 4EVER!!!', 4, '2021-11-08');

INSERT INTO Comments(id, id_article, comment, id_user, date)
VALUES
	(5, 1, 'I agree with you! You are my favotite', 4, '2020-01-24'); -- *

SELECT * FROM Comments;



-- 5.	Ratings(id, id_article, rating)
-- Tabel: Ratings ---------------------------------------------------------------------------------------------------

DROP TABLE Ratings;
TRUNCATE TABLE Ratings;

CREATE TABLE Ratings (
	id int primary key unique auto_increment not null,
    id_article int,
    rating float,
    foreign key(id_article) references Articles(id)
);

INSERT INTO Ratings (id, id_article, rating)
VALUES
	(1, 3, 4.9),
    (2, 1, 3.2),
    (3, 3, 4.1),
    (4, 2, 2.1),
    (5, 4, 4.8),
    (6, 6, 4.2),
    (7, 1, 1.3),
    (8, 2, 4.7),
    (9, 5, 4.1),
    (10, 6, 3.8),
    (11, 3, 4.5),
    (12, 5, 5.0),
	(13, 1, 5.0);
    
INSERT INTO Ratings (id, id_article, rating)
VALUES
	(14, 1, NULL);

SELECT * FROM Ratings;

-- -----------------------------------------------------------------------------------------------------------

-- Laborator 5 (Update, Delete, Between, In, Alias, And, Or)
-- Scrieti urmatoarele interogari:
-- 1.	Selectati toti userii a caror numesau rol  contine textul admin
-- 2.	Selectati articolele care au fost publicate intre urmatoarele date date_value1 si date_value2
-- 3.	Afisati o lista cu titlul articolului, autorul si data publicarii (folositi aliasuri pentru evitarea confuziei de nume)
-- 4.	Afisati titlul articolelor din categoriile ‘SF’ si ‘IT’ folosind operatorul IN
-- 5.	Scrieti interogarea care updateaza data unui articol la data curenta(articolul cu id-ul 3)
-- 6.	Stergeti toate rating-urile pentru articolul cu id-ul 3, stergeti topate comentariile pentru articolul cu id-ul 3


-- 1.	Selectati toti userii a caror numesau rol  contine textul admin --- Users(id, nume, prenume, email, parola, id_rol)

SELECT *
FROM Users
WHERE id_rol = '1';



-- 2.	Selectati articolele care au fost publicate intre urmatoarele date date_value1 si date_value2 --- Articles (id, id_author, title, category, article_body, date )

SELECT *
FROM Articles
WHERE date BETWEEN '2021-01-01' AND '2021-12-30';


-- 3.	Afisati o lista cu titlul articolului, autorul si data publicarii (folositi aliasuri pentru evitarea confuziei de nume)

SELECT a.title, u.nume, u.prenume,  a.date
FROM Articles AS a, Users AS u
WHERE a.id_author = u.id;


-- 4.	Afisati titlul articolelor din categoriile ‘SF’ si ‘IT’ folosind operatorul IN

SELECT title, category
FROM Articles
WHERE category IN ('Politics', 'Sociology');



-- 5.	Scrieti interogarea care updateaza data unui articol la data curenta(articolul cu id-ul 3)

UPDATE Articles
SET date = '2021-11-09'
WHERE id = 3;


-- 6.	Stergeti toate rating-urile pentru articolul cu id-ul 3, stergeti topate comentariile pentru articolul cu id-ul 3

DELETE FROM Ratings
WHERE id_article = 3;

DELETE FROM Comments
WHERE id_article = 3;



-- -------------------------------------------------------------------------------------------------------------------

-- Laborator 6 - (JOINS: Inner Join, Left Join, Rigth Join, Full Join)
-- 1.	Scrieti o interogare care sa afiseze numele autorilor si titlurile articolelor publicate
-- 2.	Scrieti o interogare care afiseaza titlu articolului si numele autorului si comentariile la acel articol 
-- 3.	Afisati autorii care nu au publicate inca articole
-- 4.	Afisati articolele care nu au inca ratiguri
-- 5.	Afisati articolele cu comentarii de la propriul autor.


-- 1.	Scrieti o interogare care sa afiseze numele autorilor si titlurile articolelor publicate

SELECT u.nume, u.prenume, a.title
FROM Users as u
RIGHT JOIN Articles as a
ON u.id = a.id_author
ORDER BY u.prenume;


-- 2.	Scrieti o interogare care afiseaza titlu articolului si numele autorului si comentariile la acel articol 

SELECT u.nume, u.prenume, a.title, c.comment
FROM Users as u
RIGHT JOIN Articles as a
ON u.id = a.id_author
RIGHT JOIN Comments as c
ON a.id = c.id
ORDER BY u.prenume;


-- 3.	Afisati autorii care nu au publicate inca articole - Articles (id, id_author, title, category, article_body, date )

SELECT u.nume, u.prenume
FROM Users as u
RIGHT JOIN Articles as a
ON u.id = a.id_author
WHERE a.title IS NULL
ORDER BY u.prenume;

-- 4.	Afisati articolele care nu au inca ratiguri

SELECT a.title
FROM Articles as a
RIGHT JOIN Ratings as r
ON a.id = r.id_article
WHERE r.rating IS NULL
ORDER BY a.title;

-- 5.	Afisati articolele cu comentarii de la propriul autor.

SELECT a.title, c.comment
FROM Articles as a
INNER JOIN Comments as c
ON a.id_author = c.id_user and a.id = c.id_article
ORDER BY a.id_author;






-- ---------------------------------------------------------------------------------------------------------------------------------
-- Laborator 7(sub interogari)

-- 1.	Afisati autorii care au mai multe articole decat media articolelor per autor in ordine descrescatoare
-- 2.	Afisati articolele care au nr. de comentarii cu o valaore cuprinsa intre - si + 25% fata de media comentariilor tuturor articolelor
-- 3.	Afisati articolele care au notare, si media notelor
-- 4.	Afisati userii care au comentarii sau notari dar nu au articole publicate
-- 5.	Afisati userii care nu au nici articole si nici comentarii dar au dat note in ordinea descrescatoare a numarului de note date
-- 6.	Afisati autorii si media generala per note articole.


