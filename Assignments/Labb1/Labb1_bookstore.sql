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
        ('9780140441185', 'Thus Spoke Zarathustra', 'English', 169.00, '2005-01-01', 1),
        ('9780140442038', 'Beyond Good and Evil', 'English', 159.00, '1990-01-01', 1),
        ('9780140449136', 'Crime and Punishment', 'English', 229.00, '1993-01-01', 2),
        ('9780140449242', 'The Brothers Karamazov', 'English', 219.00, '1990-01-01', 2),
        ('9780486434103', 'The World as Will and Representation','English', 279.00, '1969-01-01', 3),
        ('9780226100421', 'The Trouble with Being Born','English', 149.00, '1973-01-01', 4),
        ('9781611454141', 'A Short History of Decay', 'English', 179.00, '1949-01-01', 4),
        ('9780811216876', 'The Book of Disquiet', 'English', 299.00, '2002-01-01', 5),
        ('9780679720201','The Stranger','English',179.00,'1942-01-01',6),
        ('9780141186542','The Myth of Sisyphus','English',159.00,'1942-01-01',6),
        ('9780140444490','Nausea','English',189.00,'1938-01-01',7),
        ('9780415074578','Being and Nothingness','English',399.00,'1943-01-01',7),
        ('9780140445718','Fear and Trembling','English',159.00,'1843-01-01',8),
        ('9780691020429','The Sickness Unto Death','English',199.00,'1849-01-01',8);
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
        ('Bokgrottan', 'Drottninggatan 12, Stockholm'),
        ('Bra Böcker', 'Södra Förstadsgatan 44, Malmö'),
        ('Filosofi Soffan','Avenyn 7, Göteborg');
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

IF OBJECT_ID('dbo.tbl_customers') IS NULL
BEGIN
CREATE TABLE dbo.tbl_customers (
    customerId INT IDENTITY(1,1) PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    registered DATE DEFAULT GETDATE()
);
END;

IF NOT EXISTS (SELECT 1 FROM dbo.tbl_customers)
BEGIN
INSERT INTO dbo.tbl_customers (firstname, lastname, email, phone) VALUES
    ('Anna','Andersson','pokemonfan92@mail.se','0701234567'),
    ('Erik','Eriksson','robloxmaster@outlook.com','0701234567'),
    ('Bob','Brandmark','minecraftking1337@gmail.com','0729876543'),
    ('Göran','Nilsson','rocknrollman@hotmail.com','0731112233'),
    ('Adrianna','Bumic Berosius','bajsunge12345@icloud.com','0765554433'),
    ('Isabelle','Ört','nuggetqueen@yahoo.se','0709988776'),
    ('Sigge','Blomma','ziggeblom@telia.com','0734455667');
END;

IF OBJECT_ID('dbo.tbl_orders') IS NULL
BEGIN
CREATE TABLE dbo.tbl_orders (
    orderId INT IDENTITY(1,1) PRIMARY KEY,
    customerId INT NOT NULL,
    orderDate DATETIME2 DEFAULT GETDATE(),
    storeId INT NOT NULL,
    totalAmount DECIMAL(12,2) NOT NULL,
    CONSTRAINT FK_orders_customer FOREIGN KEY (customerId) REFERENCES dbo.tbl_customers(customerId),
    CONSTRAINT FK_orders_store FOREIGN KEY (storeId) REFERENCES dbo.tbl_stores(id)
);
END;

IF NOT EXISTS (SELECT 1 FROM dbo.tbl_orders)
BEGIN
INSERT INTO dbo.tbl_orders (customerId, storeId, totalAmount) VALUES
    (1, 1, 388.00),
    (2, 2, 219.00),
    (3, 1, 169.00),
    (4, 3, 448.00),
    (5, 2, 179.00),
    (1, 3, 159.00),
    (6, 1, 657.00),
    (7, 2, 189.00),
    (3, 1, 279.00),
    (2, 3, 328.00);
END;

IF OBJECT_ID('dbo.tbl_orderDetails') IS NULL
BEGIN
CREATE TABLE dbo.tbl_orderDetails (
    orderId INT NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unitPrice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (orderId, isbn),
    CONSTRAINT FK_details_order FOREIGN KEY (orderId) REFERENCES dbo.tbl_orders(orderId),
    CONSTRAINT FK_details_book  FOREIGN KEY (isbn) REFERENCES dbo.tbl_books(isbn)
);
END;

IF NOT EXISTS (SELECT 1 FROM dbo.tbl_orderDetails)
BEGIN
INSERT INTO dbo.tbl_orderDetails (orderId,isbn,quantity,unitPrice) VALUES
    (1, '9780140441185', 1, 169.00),
    (1, '9780140442038', 1, 219.00),
    (2, '9780140449242', 1, 219.00),
    (3, '9780140441185', 1, 169.00),
    (4, '9780486434103', 1, 279.00),
    (4, '9780679720201', 1, 169.00),
    (5, '9780679720201', 1, 179.00),
    (6, '9780140445718', 1, 159.00),
    (7, '9780140449136', 1, 229.00),
    (7, '9780140449242', 1, 219.00),
    (7, '9780140444490', 1, 209.00),
    (8, '9780140444490', 1, 189.00),
    (9, '9780486434103', 1, 279.00),
    (10, '9780140441185', 1, 169.00),
    (10, '9780140445718', 1, 159.00);
END;