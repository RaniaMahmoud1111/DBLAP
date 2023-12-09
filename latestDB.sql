create database latestLab;
go;
---- Create UserRole table
--CREATE TABLE UserRole (
--    RoleID INT  identity PRIMARY KEY ,
--    RoleName VARCHAR(50) NOT NULL
--);

CREATE TABLE _User (
    UserID INT  identity PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
   -- LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    UPassword  varchar(50) unique NOT NULL,--password is a key word in sql 
    PhoneNumber VARCHAR(20) unique,
   RoleName VARCHAR(50)-- i ignore  userRole table 
);

-- Create _Address table
CREATE TABLE _Address (
    AddressID INT identity  PRIMARY KEY,
    UserID INT,
    Country VARCHAR(50),
    Governorate VARCHAR(50),
    City VARCHAR(50),
    AddressLine VARCHAR(255),
    CONSTRAINT FK_User_Address FOREIGN KEY (UserID) REFERENCES _User(UserID)
);

-- Create Category table with additional attributes
CREATE TABLE Category (
    CategoryID INT identity  PRIMARY KEY,
    CategoryName VARCHAR(50)  NULL,
    Description TEXT
);

-- Create Shop table with additional attributes and constraints
CREATE TABLE Shop (
    ShopID INT identity  PRIMARY KEY,
    UserID INT,
    ShopName VARCHAR(100) NULL,
    Description TEXT,
    CONSTRAINT FK__User_Shop FOREIGN KEY (UserID) REFERENCES _User(UserID)
);

-- Create Product table with additional attributes and constraints
CREATE TABLE Product (
    ProductID INT identity  PRIMARY KEY,
    ProductName VARCHAR(100)  NULL,
    Description TEXT,
    Price DECIMAL  NULL CHECK (Price >= 0), -- Ensure non-negative price
    CategoryID INT,
    ShopID INT,  -- New column to represent the shop to which the product belongs
    StockQuantity INT  NULL CHECK (StockQuantity >= 0),
    CONSTRAINT FK_Category_Product FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    CONSTRAINT FK_Shop_Product FOREIGN KEY (ShopID) REFERENCES Shop(ShopID)
);

-- Create Cart table with additional attributes and constraints
CREATE TABLE Cart (
    CartID INT identity PRIMARY KEY,
    UserID INT,
    CONSTRAINT FK__User_Cart FOREIGN KEY (UserID) REFERENCES _User(UserID)
);

-- Create CartItem table with additional attributes and constraints
CREATE TABLE CartItem (
    CartItemID INT identity  PRIMARY KEY,
    CartID INT,
    ProductID INT,
    Quantity INT  NULL CHECK (Quantity > 0), -- Ensure positive quantity
    CONSTRAINT FK_Cart_CartItem FOREIGN KEY (CartID) REFERENCES Cart(CartID),
    CONSTRAINT FK_Product_CartItem FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Wishlist table with additional attributes and constraints
CREATE TABLE Wishlist (
    WishlistID INT  identity PRIMARY KEY,
    UserID INT,
    ProductID INT,
    CONSTRAINT FK__User_Wishlist FOREIGN KEY (UserID) REFERENCES _User(UserID),
    CONSTRAINT FK_Product_Wishlist FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create _Order table with additional attributes and constraints
CREATE TABLE _Order (
    OrderID INT  identity PRIMARY KEY,
    UserID INT,
    OrderDate DATETIME  default getdate()  NULL,--to make time current time
    TotalAmount DECIMAL   NULL CHECK (TotalAmount >= 0), -- Ensure non-negative total amount
    CONSTRAINT FK__User_Order FOREIGN KEY (UserID) REFERENCES _User(UserID)
);

-- Create OrderItem table with additional attributes and constraints
CREATE TABLE OrderItem (
    OrderItemID INT  identity PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT  NULL CHECK (Quantity > 0), -- Ensure positive quantity
    subPrice DECIMAL  NULL CHECK (subPrice >= 0), -- Ensure non-negative price
    CONSTRAINT FK_Order_OrderItem FOREIGN KEY (OrderID) REFERENCES _Order(OrderID),
    CONSTRAINT FK_Product_OrderItem FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Review table with additional attributes and constraints
CREATE TABLE Review (
    ReviewID INT  identity PRIMARY KEY,
    UserID INT,
    ProductID INT,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5), -- Ensure rating is between 1 and 5
    Comment TEXT,
    ReviewDate DATETIME  default getdate() NOT NULL,
    CONSTRAINT FK__User_Review FOREIGN KEY (UserID) REFERENCES _User(UserID),
    CONSTRAINT FK_Product_Review FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create LaptopDetail table
CREATE TABLE LaptopDetail (
    LaptopID INT identity  PRIMARY KEY,
    ProductID INT UNIQUE,
    Brand VARCHAR(50),
    CPU VARCHAR(100),
    Storage VARCHAR(50),
    RAM VARCHAR(50),
    GPU VARCHAR(50), -- Changed from GraphicsCard to GPU
    ScreenSize DECIMAL,
    LWeight DECIMAL(5, 2),--weight is a key word in  sql 
    HasWebcam BIT, -- Using BIT to represent boolean value
    CONSTRAINT FK_Product_LaptopDetail FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
