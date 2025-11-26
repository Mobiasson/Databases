CREATE TABLE authors (
id int primary key IDENTITY(1,1),
firstname VARCHAR(15) NOT NULL,
lastname VARCHAR(MAX) NOT NULL,
dateofbirth DATE NOT NULL
)

CREATE TABLE books (
isbn int primary key NOT NULL,
title VARCHAR(MAX) NOT NULL,
language VARCHAR(15) NOT NULL,
price int,
publishdate DATE NOT NULL

)

