IF OBJECT_ID('dbo.tbl_authors', 'U') IS NULL
BEGIN
    CREATE TABLE tbl_authors (
        id INT IDENTITY(1,1) PRIMARY KEY,
        firstname VARCHAR(15) NOT NULL,
        lastname VARCHAR(MAX) NOT NULL,
        dateofbirth DATE NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM tbl_authors)
BEGIN
    INSERT INTO tbl_authors (firstname, lastname, dateofbirth) VALUES
    ('Friedrich', 'Nietzsche', '18441015'),
    ('Fjodor', 'Dostojevskij', '18211030'),
    ('Arthur', 'Schopenhauer', '17880222'),
    ('Emil', 'Cioran', '19110408'),
    ('Fernando', 'Pessoa', '18880613');
END;

IF OBJECT_ID('dbo.tbl_books', 'U') IS NULL
BEGIN
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
END;

IF NOT EXISTS (SELECT 1 FROM tbl_books)
BEGIN
    INSERT INTO tbl_books (isbn, title, language, price, publishDate, authorId) VALUES
        ('9780140441185', 'Thus Spoke Zarathustra', 'German', 149, '18830101', 1),
        ('9780140442038', 'Beyond Good and Evil', 'German', 139, '18860101', 1),
        ('9780140449136', 'Crime and Punishment', 'Russian', 199, '18660101', 2),
        ('9780140449242', 'The Brothers Karamazov', 'Russian', 188.99, '18800101', 2),
        ('9780486434103', 'The World as Will and Representation', 'German', 229.00, '18180101', 3),
        ('9780226100421', 'The Trouble with Being Born', 'French', 129.00, '19730101', 4),
        ('9781611454141', 'A Short History of Decay', 'French', 149.00, '19490101', 4),
        ('9780811216876', 'The Book of Disquiet', 'Portuguese', 249.00, '19820101', 5);
END;

IF OBJECT_ID('dbo.tbl_stores', 'U') IS NULL
BEGIN
    CREATE TABLE tbl_stores (
        id INT IDENTITY(1,1) PRIMARY KEY,
        storeName VARCHAR(15) NOT NULL,
        address VARCHAR(100) NOT NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM tbl_stores)
BEGIN
    INSERT INTO tbl_stores (storeName, address) VALUES
        ('Bokhuset', 'Drottninggatan 12, Stockholm'),
        ('Läsrummet', 'Södra Förstadsgatan 44, Malmö'),
        ('Kunskapsboden', 'Avenyn 7, Göteborg');
END;


IF OBJECT_ID('dbo.tbl_bookBalance', 'U') IS NULL
BEGIN
    CREATE TABLE tbl_bookBalance (
        isbn VARCHAR(13) NOT NULL,
        storeId INT NOT NULL,
        bookID INT NOT NULL,
        CONSTRAINT PK_bookBalance PRIMARY KEY (isbn),   -- or composite key if needed
        CONSTRAINT FK_store FOREIGN KEY (storeId) REFERENCES tbl_stores(id),
        CONSTRAINT FK_isbn FOREIGN KEY (isbn) REFERENCES tbl_books(isbn)
    );
END;

IF NOT EXISTS (SELECT 1 FROM tbl_bookBalance)
BEGIN
    INSERT INTO tbl_bookBalance (isbn, storeId, bookID) VALUES
        ('9780140441185', 1, 1),
        ('9780140442038', 1, 2),
        ('9780140449136', 1, 3),
        ('9780811216876', 1, 4),
        ('9780140449242', 2, 5),
        ('9780486434103', 2, 6),
        ('9780226100421', 2, 7),
        ('9781611454141', 3, 8),
        ('9780486434103', 3, 9),
        ('9780140441185', 3, 10);
END;

