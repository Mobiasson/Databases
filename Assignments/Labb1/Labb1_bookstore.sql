CREATE TABLE tbl_authors (
id int primary key IDENTITY(1,1),
firstname VARCHAR(15) NOT NULL,
lastname VARCHAR(MAX) NOT NULL,
dateofbirth DATE NOT NULL
);

CREATE TABLE tbl_books (
    isbn VARCHAR(13) PRIMARY KEY NOT NULL,
    title VARCHAR(500) NOT NULL,
    language VARCHAR(15) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    publishDate DATE NOT NULL,
    authorId INT NOT NULL,
    CONSTRAINT FK_books_author 
        FOREIGN KEY (authorId) 
        REFERENCES tbl_authors(id)
);

CREATE TABLE tbl_stores (
id int primary key IDENTITY(1,1),
storeName VARCHAR(15) NOT NULL,
address VARCHAR(100) NOT NULL
);

CREATE TABLE tbl_bookBalance (
isbn VARCHAR(13) PRIMARY KEY NOT NULL,
storeId INT NOT NULL,
bookID INT NOT NULL
CONSTRAINT FK_store FOREIGN KEY (storeId) REFERENCES tbl_stores(id),
CONSTRAINT FK_isbn FOREIGN KEY (isbn) REFERENCES tbl_books(isbn)
);


