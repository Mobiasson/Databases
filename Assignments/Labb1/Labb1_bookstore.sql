IF OBJECT_ID('dbo.tbl_authors', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_authors (
        id INT IDENTITY(1,1) PRIMARY KEY,
        firstname VARCHAR(50) NOT NULL,
        lastname VARCHAR(100) NOT NULL,
        dateofbirth DATE NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.tbl_authors)
BEGIN
    INSERT INTO dbo.tbl_authors (firstname, lastname, dateofbirth) VALUES
        ('Friedrich', 'Nietzsche', '1844-10-15'),
        ('Fjodor', 'Dostoevsky', '1821-11-11'),
        ('Arthur', 'Schopenhauer', '1788-02-22'),
        ('Emil', 'Cioran', '1911-04-08'),
        ('Fernando', 'Pessoa', '1888-06-13'),
        ('Albert','Camus','1913-11-07'),
('Jean-Paul','Sartre','1905-06-21'),
('Søren','Kierkegaard','1813-05-05');
END;

IF OBJECT_ID('dbo.tbl_books', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_books (
        isbn VARCHAR(13) PRIMARY KEY NOT NULL,
        title VARCHAR(500) NOT NULL,
        language VARCHAR(15) NOT NULL,
        price DECIMAL(10,2) NOT NULL,
        publishDate DATE NOT NULL,
        authorId INT NOT NULL,
        CONSTRAINT FK_books_author FOREIGN KEY (authorId) REFERENCES dbo.tbl_authors(id)
    );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.tbl_books)
BEGIN
    INSERT INTO dbo.tbl_books (isbn, title, language, price, publishDate, authorId) VALUES
        ('9780140441185', 'Thus Spoke Zarathustra', 'English', 14.99, '2005-01-01', 1),
        ('9780140442038', 'Beyond Good and Evil', 'English', 13.99, '1990-01-01', 1),
        ('9780140449136', 'Crime and Punishment', 'English', 19.99, '1993-01-01', 2),
        ('9780140449242', 'The Brothers Karamazov', 'English', 18.99, '1990-01-01', 2),
        ('9780486434103', 'The World as Will and Representation','English', 22.99, '1969-01-01', 3),
        ('9780226100421', 'The Trouble with Being Born','English', 12.99, '1973-01-01', 4),
        ('9781611454141', 'A Short History of Decay', 'English', 14.99, '1949-01-01', 4),
        ('9780811216876', 'The Book of Disquiet', 'English', 24.99, '2002-01-01', 5);
END;

IF OBJECT_ID('dbo.tbl_stores', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_stores (
        id INT IDENTITY(1,1) PRIMARY KEY,
        storeName VARCHAR(50) NOT NULL,
        address VARCHAR(100) NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.tbl_stores)
BEGIN
    INSERT INTO dbo.tbl_stores (storeName, address) VALUES
        ('Bokhuset', 'Drottninggatan 12, Stockholm'),
        ('Läsrummet', 'Södra Förstadsgatan 44, Malmö'),
        ('Kunskapsboden','Avenyn 7, Göteborg');
END;

IF OBJECT_ID('dbo.tbl_bookBalance', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.tbl_bookBalance (
        storeId INT NOT NULL,
        isbn VARCHAR(13) NOT NULL,
        amountInStock INT NOT NULL,
        CONSTRAINT PK_bookBalance PRIMARY KEY (storeId, isbn),
        CONSTRAINT FK_bookBalance_Store FOREIGN KEY (storeId) REFERENCES dbo.tbl_stores(id),
        CONSTRAINT FK_bookBalance_Book  FOREIGN KEY (isbn)     REFERENCES dbo.tbl_books(isbn)
    );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.tbl_bookBalance)
BEGIN
    INSERT INTO dbo.tbl_bookBalance (storeId, isbn, amountInStock) VALUES
        (1, '9780140441185', 12),
        (1, '9780140442038', 8),
        (1, '9780140449136', 5),
        (1, '9780811216876', 7),
        (2, '9780140449242', 10),
        (2, '9780486434103', 6),
        (2, '9780226100421', 4),
        (3, '9781611454141', 9),
        (3, '9780486434103', 3),
        (3, '9780140441185', 11);
END;