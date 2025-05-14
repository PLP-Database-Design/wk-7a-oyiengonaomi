--Question 1: Achieving 1NF (First Normal Form)
 --To transform the ProductDetail table into 1NF, we need to separate the multiple products
--in the 'Products' column into individual rows for each order.
--Since we are only asked for the conceptual transformation and not to execute
--against an existing table, the following demonstrates the logical outcome:

-- Original ProductDetail Table (Conceptual)
-- OrderID | CustomerName | Products
-- --------|--------------|-----------------
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone

-- Transformed Table in 1NF (Conceptual)
-- OrderID | CustomerName | Product
-- --------|--------------|----------
-- 101     | John Doe     | Laptop
-- 101     | John Doe     | Mouse
-- 102     | Jane Smith   | Tablet
-- 102     | Jane Smith   | Keyboard
-- 102     | Jane Smith   | Mouse
-- 103     | Emily Clark  | Phone

-- Note: In a real SQL environment, you would typically need to process the
-- original table using string manipulation functions (like splitting the 'Products'
-- column) and then insert the resulting rows into a new table with the 1NF structure.
-- The exact SQL syntax for this would depend on the specific database system
-- and the complexity of the string splitting required.

-- Question 2: Achieving 2NF (Second Normal Form)
-- To transform the OrderDetails table into 2NF, we need to remove the partial dependency
-- of CustomerName on OrderID. We will create two tables: Orders and OrderItems.

-- Original OrderDetails Table (Conceptual)
-- OrderID | CustomerName | Product  | Quantity
-- --------|--------------|----------|----------
-- 101     | John Doe     | Laptop   | 2
-- 101     | John Doe     | Mouse    | 1
-- 102     | Jane Smith   | Tablet   | 3
-- 102     | Jane Smith   | Keyboard | 1
-- 102     | Jane Smith   | Mouse    | 2
-- 103     | Emily Clark  | Phone    | 1

-- Table: Orders (in 2NF)
-- OrderID | CustomerName
-- --------|--------------
-- 101     | John Doe
-- 102     | Jane Smith
-- 103     | Emily Clark

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Table: OrderItems (in 2NF)
-- OrderID | Product  | Quantity
-- --------|----------|----------
-- 101     | Laptop   | 2
-- 101     | Mouse    | 1
-- 102     | Tablet   | 3
-- 102     | Keyboard | 1
-- 102     | Mouse    | 2
-- 103     | Phone    | 1

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    PRIMARY KEY (OrderID, Product) -- Composite primary key
);

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Explanation:
-- We have separated the OrderDetails table into two tables:
-- 1. Orders: This table contains information about each order, with OrderID as the primary key. CustomerName now fully depends on OrderID.
-- 2. OrderItems: This table contains details about the products in each order. The primary key is a composite of OrderID and Product, ensuring that each row uniquely identifies a product within an order. Quantity depends on both OrderID and Product.
-- A foreign key constraint links OrderID in OrderItems to OrderID in Orders, maintaining the relationship between the tables.
