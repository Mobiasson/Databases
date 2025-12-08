IF OBJECT_ID('authors', 'U') IS NULL
BEGIN
    CREATE TABLE authors (
        id INT IDENTITY(1,1) PRIMARY KEY,
        firstname VARCHAR(50) NOT NULL,
        lastname VARCHAR(100) NOT NULL,
        dateofbirth DATE NOT NULL,
        deathdate DATE NOT NULL
    );
END;

IF NOT EXISTS(SELECT 1 FROM authors)
BEGIN
    INSERT INTO authors(firstname, lastname, dateofbirth, deathdate)VALUES
    ('Friedrich', 'Nietzsche', '1844-10-15', '1900-08-25'),
    ('Fjodor', 'Dostoevsky', '1821-11-11', '1881-02-09'),
    ('Arthur', 'Schopenhauer', '1788-02-22', '1860-09-21'),
    ('Emil', 'Cioran', '1911-04-08', '1995-06-20'),
    ('Fernando', 'Pessoa', '1888-06-13', '1935-11-30'),
    ('Albert', 'Camus', '1913-11-07', '1960-01-04'),
    ('Jean-Paul', 'Sartre', '1905-06-21', '1980-04-15'),
    ('Søren', 'Kierkegaard', '1813-05-05', '1855-11-11');
END;

IF OBJECT_ID('books', 'U') IS NULL
BEGIN
    CREATE TABLE books (
        isbn VARCHAR(13) PRIMARY KEY NOT NULL,
        title VARCHAR(500) NOT NULL,
        language VARCHAR(15) NOT NULL,
        price DECIMAL(10,2) NOT NULL,
        publishDate DATE NOT NULL,
        authorId INT NOT NULL,
        CONSTRAINT FK_books_author FOREIGN KEY (authorId) REFERENCES authors(id)
    );
END;

IF NOT EXISTS(SELECT 1 FROM books)BEGIN
INSERT INTO books(isbn, title, language, price, publishDate, authorId)VALUES
('9780140441185', 'Thus Spoke Zarathustra', 'English', 169.00, '2005-11-29', 1),
('9780140442038', 'Beyond Good and Evil', 'English', 159.00, '2003-04-29', 1),
('9780140449136', 'Crime and Punishment', 'English', 229.00, '2003-02-27', 2),
('9780140449242', 'The Brothers Karamazov', 'English', 219.00, '2003-02-27', 2),
('9780486434103', 'The World as Will and Representation', 'English', 279.00, '2005-06-10', 3),
('9780226100421', 'The Trouble with Being Born', 'French', 149.00, '1998-10-01', 4),
('9781611454141', 'A Short History of Decay', 'French', 179.00, '2012-11-15', 4),
('9780811216876', 'The Book of Disquiet', 'Portuguese', 299.00, '2017-05-02', 5),
('9780679720201', 'The Stranger', 'French', 179.00,'1989-03-13', 6),
('9780141186542', 'The Myth of Sisyphus', 'French', 159.00, '2005-11-03', 6),
('9780140444490', 'Nausea', 'French', 189.00, '2000-11-30',7),
('9780415074578', 'Being and Nothingness', 'French',399.00,'2003-08-07', 7),
('9780140445718', 'Fear and Trembling', 'Danish', 159.00, '2003-09-25', 8),
('9780691020429', 'The Sickness Unto Death', 'Danish', 199.00, '1983-08-01', 8);
END;



IF OBJECT_ID('stores', 'U') IS NULL
BEGIN
    CREATE TABLE stores (
        id INT IDENTITY(1,1) PRIMARY KEY,
        storeName VARCHAR(50) NOT NULL,
        address VARCHAR(100) NOT NULL,
        postalCode INT NOT NULL,
        city VARCHAR(50)
    );
END;

IF NOT EXISTS (SELECT 1 FROM stores)
BEGIN
    INSERT INTO stores (storeName, address, postalCode, city) VALUES
        ('Bokgrottan', 'Drottninggatan 12', 10475, 'Stockholm'),
        ('Bra Böcker', 'Södra Förstadsgatan 44', 41145, 'Göteborg'),
        ('Filosofi Soffan','Avenyn 7', 41241, 'Göteborg');
END;

IF OBJECT_ID('bookBalance', 'U') IS NULL
BEGIN
    CREATE TABLE bookBalance (
        storeId INT NOT NULL,
        isbn VARCHAR(13) NOT NULL,
        amountInStock INT NOT NULL,
        CONSTRAINT PK_bookBalance PRIMARY KEY (storeId, isbn),
        CONSTRAINT FK_bookBalance_Store FOREIGN KEY (storeId) REFERENCES stores(id),
        CONSTRAINT FK_bookBalance_Book  FOREIGN KEY (isbn)     REFERENCES books(isbn)
    );
END;

IF NOT EXISTS (SELECT 1 FROM bookBalance)
BEGIN
INSERT INTO bookBalance (storeId, isbn, amountInStock) VALUES
(1, '9780679720201', 15),
(2, '9780141186542', 8), 
(3, '9780679720201', 12),
(1, '9780140444490', 20),
(2, '9780415074578', 5), 
(3, '9780140444490', 18),
(1, '9780140445718', 14),
(3, '9780691020429', 9), 
(2, '9780811216876', 25);   
END;

IF OBJECT_ID('customers') IS NULL
BEGIN
CREATE TABLE customers (
    customerId INT IDENTITY(1,1) PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    registered DATE DEFAULT GETDATE()
);
END;

IF NOT EXISTS (SELECT 1 FROM customers)
BEGIN
INSERT INTO customers (firstname, lastname, email, phone) VALUES
    ('Anna','Andersson','pokemonfan92@mail.se','0701234567'),
    ('Erik','Eriksson','robloxmaster@outlook.com','0701234567'),
    ('Bob','Brandmark','minecraftking1337@gmail.com','0729876543'),
    ('Göran','Nilsson','rocknrollman@hotmail.com','0731112233'),
    ('Adrianna','Bumic Berosius','bajsunge12345@icloud.com','0765554433'),
    ('Isabelle','Ört','nuggetqueen@yahoo.se','0709988776'),
    ('Sigge','Blomma','ziggeblom@telia.com','0734455667');
END;

IF OBJECT_ID('orders') IS NULL
BEGIN
CREATE TABLE orders (
    orderId INT IDENTITY(1,1) PRIMARY KEY,
    customerId INT NOT NULL,
    orderDate DATETIME2 DEFAULT GETDATE(),
    storeId INT NOT NULL,
    CONSTRAINT FK_orders_customer FOREIGN KEY (customerId) REFERENCES customers(customerId),
    CONSTRAINT FK_orders_store FOREIGN KEY (storeId) REFERENCES stores(id)
);
END;

IF NOT EXISTS (SELECT 1 FROM orders)
BEGIN
INSERT INTO orders (customerId, storeId) VALUES
    (1, 1),
    (2, 2),
    (3, 1),
    (4, 3),
    (5, 2),
    (1, 3),
    (6, 1),
    (7, 2),
    (3, 1),
    (2, 3);
END;

IF OBJECT_ID('orderDetails', 'U') IS NULL
BEGIN
    CREATE TABLE orderDetails (
        orderId INT NOT NULL,
        isbn VARCHAR(13) NOT NULL,
        quantity INT NOT NULL CHECK (quantity > 0),
        bookPrice DECIMAL(10, 2) NOT NULL,
        PRIMARY KEY (orderId, isbn),
        CONSTRAINT FK_details_order FOREIGN KEY (orderId) REFERENCES orders(orderId),
        CONSTRAINT FK_details_book FOREIGN KEY (isbn) REFERENCES books(isbn)
    );
END;

IF NOT EXISTS (SELECT 1 FROM orderDetails)
BEGIN
    INSERT INTO orderDetails (orderId, isbn, quantity, bookPrice) VALUES
    (1, '9780140441185', 49, 169.00),
    (1, '9780140442038', 22, 219.00),
    (2, '9780140449242', 26, 219.00),
    (3, '9780140441185', 31, 169.00),
    (4, '9780486434103', 59, 279.00),
    (4, '9780679720201', 3, 169.00),
    (5, '9780679720201', 9, 179.00),
    (6, '9780140445718', 43, 159.00),
    (7, '9780140449136', 32, 229.00),
    (7, '9780140449242', 51, 219.00),
    (7, '9780140444490', 23, 209.00),
    (8, '9780140444490', 11, 189.00),
    (9, '9780486434103', 14, 279.00),
    (10, '9780140441185', 7, 169.00),
    (10, '9780140445718', 9, 159.00);
END;

--View
GO
CREATE VIEW view_authorsPerTitle AS
SELECT
    a.firstname + ' ' + a.lastname AS [Name],
    DATEDIFF(YEAR, a.dateofbirth, a.deathdate)
      - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, a.dateofbirth, a.deathdate), a.dateofbirth) > a.deathdate
             THEN 1 ELSE 0 END AS [Age],
    COUNT(b.isbn) AS [Titles],
    ISNULL(SUM(bb.amountInStock * b.price), 0) AS [Stock Value(SEK)]
FROM dbo.authors a
JOIN dbo.books b
      ON a.id = b.authorId
LEFT JOIN dbo.bookBalance bb
      ON b.isbn = bb.isbn
GROUP BY a.firstname, a.lastname, a.dateofbirth, a.deathdate;
GO

SELECT * FROM view_authorsPerTitle
ORDER BY [Titles] DESC;

-- Only to drop tables for testing
--DROP VIEW IF EXISTS view_authorsPerTitle;
--DROP TABLE IF EXISTS orderDetails;
--DROP TABLE IF EXISTS bookBalance;
--DROP TABLE IF EXISTS orders;
--DROP TABLE IF EXISTS customers;
--DROP TABLE IF EXISTS stores;
--DROP TABLE IF EXISTS books;
--DROP TABLE IF EXISTS authors;