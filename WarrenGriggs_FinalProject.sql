-- CSCI 2020-001: Database Fundamentals
-- Phoenix Warren, Isaiah Griggs
-- Final Project


-- Tables
CREATE TABLE Categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name TEXT NOT NULL
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL, last_name TEXT NOT NULL, email TEXT UNIQUE, address_id TEXT NOT NULL, phone TEXT,
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE addresses (
    address_id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(8)))),
    street TEXT, city TEXT, zip_code TEXT
);

CREATE TABLE customerAccounts (
    account_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL, password TEXT NOT NULL, creation_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL, last_name TEXT NOT NULL, email TEXT UNIQUE NOT NULL, phone TEXT, hire_date DATE NOT NULL,
    salary REAL NOT NULL, role_id INTEGER NOT NULL,
    FOREIGN KEY (role_id) REFERENCES employeeRoles(role_id)
);

CREATE TABLE employeeRoles (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_name TEXT NOT NULL, description TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT NOT NULL, category_id INTEGER NOT NULL, price REAL NOT NULL, size TEXT, stock_qty INTEGER NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE suppliers (
    supplier_id INTEGER PRIMARY KEY  AUTOINCREMENT,
    supplier_name TEXT NOT NULL, contact_email TEXT UNIQUE
);

CREATE TABLE supplier_products (
    fabric_id INTEGER NULL, supplier_id INTEGER NOT NULL, product_id INTEGER NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id), FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL, order_date TEXT NOT NULL, total_amount TEXT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orderItems (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL, product_id INTEGER NOT NULL, quantity INTEGER NOT NULL, price_each REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id), FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    payment_method TEXT NOT NULL, amount REAL NOT NULL, payment_status TEXT NOT NULL, order_id INTEGER not null,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE shipments (
    shipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL, address_id INTEGER NOT NULL, ship_date DATE NOT NULL, delivery_date DATE NOT NULL, carrier TEXT NOT NULL, tracking_num INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


-- Sample Data
INSERT INTO Categories (category_name) VALUES
                ('Shirts'),
                ('Hoodies'),
                ('Sweaters');

--INSERT INTO customers (first_name, last_name, email, address, phone) VALUES
--('John', 'Doe', 'doejohn@hotmail.com', '456 E Drum Ave', '987-346-2264'),
--('Mary', 'Perez', 'm.perez@gmail.com', '1748 Greenroad Dr', '987-572-2351'),
--('Armani', 'Davis', 'davisi.98@yahoo.net', '6967 Blair St', '432-754-0912'),
--('Sara', 'Cruz', 'cruzmail@comcast.net', '87 Sunroad St', '210-341-9805'),
--('Roger', 'Wright', 'roger.wright@gmail.com', '5480 NW Yonder Rd', '729-596-8276');

INSERT INTO customers (first_name, last_name, email, address_id, phone) VALUES
('John', 'Doe', 'doejohn@hotmail.com', 'ID_FOR_456_DRUM_AVE', '987-346-2264'),
('Mary', 'Perez', 'm.perez@gmail.com', 'ID_FOR_1748_GREENROAD', '987-572-2351'),
('Armani', 'Davis', 'davisi.98@yahoo.net', 'ID_FOR_6967_BLAIR', '432-754-0912'),
('Sara', 'Cruz', 'cruzmail@comcast.net', 'ID_FOR_87_SUNROAD', '210-341-9805'),
('Roger', 'Wright', 'roger.wright@gmail.com', 'ID_FOR_5480_NW_YONDER', '729-596-8276');

INSERT INTO addresses (street, city, zip_code) VALUES
('456 E Drum Ave', NULL, NULL),
('1748 Greenroad Dr', NULL, NULL),
('6967 Blair St', NULL, NULL),
('87 Sunroad St', NULL, NULL),
('5480 NW Yonder Rd', NULL, NULL);

INSERT INTO customerAccounts (customer_id, password, creation_date) VALUES
('1', '########', '2024-04-19'),
('2', '#############', '2024-09-02'),
('3', '#########', '2024-10-20'),
('4', '########', '2024-11-11'),
('5', '#################', '2024-12-16');

INSERT INTO employees (first_name, last_name, email, phone, role_id, hire_date, salary) VALUES
('Alex', 'Rivera', 'alex.rivera@shop.com', ' 615-332-4563', '1', '2023-01-03', 55000),
('Jamie',   'Lopez', 'jamie.lopez@shop.com', '423-881-0042', '2', '2023-04-02', 33000),
('Taylor',  'Kim', 'taylor.kim@shop.com', '865-775-2201', '3', '2023-06-15', 36000),
('Jordan',  'Price', 'jordan.price@shop.com', '931-420-7712', '3', '2024-01-16', 28000),
('Morgan',  'Hayes', 'morgan.hayes@shop.com', '615-990-3374', '2', '2024-02-20', 31000);

INSERT INTO employeeRoles (role_name, description) VALUES
('Manager', 'Oversees operations and staff'),
('Associate', 'Handles customer sales and support'),
('Stocker', 'Manages inventory and shipping');

INSERT INTO suppliers (supplier_name, contact_email) VALUES
('FabricCo', 'alice@fabricco.com'),
('TextileWorld', 'bob@textileworld.com'),
('GlobalFabrics', 'carol@globalfabrics.com');

INSERT INTO supplier_products (fabric_id, supplier_id, product_id) VALUES
-- FabricCo supplies tshirts and hoodies
(1, 1, 1),
(2, 1, 2),
(1, 1, 3),
(2, 1, 4),

-- TextileWorld supplies tshirts, hoodies, and sweaters
(1, 2, 1),
(2, 2, 2),
(3, 2, 3),
(5, 2, 5),

-- GlobalFabrics supplies sweaters and hoodies
(3, 3, 4),
(5, 3, 5),
(4, 3, 6),

-- Generic entries without specific fabric
(NULL, 1, 5),
(NULL, 2, 6);

INSERT INTO products (product_name, category_id, price, size, stock_qty) VALUES
                    ('basic tshirt', '1', '9.99', 'M', '50'),
                    ('graphic tshirt', '1', '14.99', 'L', '36'),
                    ('regular hoodie', '2', '25.99', 'M', '45'),
                    ('zipup hoodie', '2', '19.99', 'S', '25'),
                    ('knitted sweater', '3', '30.99', 'L', '30'),
                    ('cropped sweater', '3', '23.99', 'M', '20');

INSERT INTO shipments (order_id, address_id, ship_date, delivery_date, carrier, tracking_num) VALUES
(1, 'ADDR1', '2024-04-20', '2024-04-25', 'UPS', '1Z12345E0271271688'),
(2, 'ADDR2', '2024-01-17', '2024-01-23', 'FedEx', '783452091234'),
(3, 'ADDR3', '2024-01-18', 'NULL', 'USPS','9400110828825021214493'),
(4, 'ADDR4', '2024-01-19', '2024-01-24', 'UPS','1Z8459999999991111'),
(5, 'ADDR5', '2024-01-20', 'NULL', 'FedEx', '921849320128390');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
                    ('1', '2024-04-19', '54.35'),
                    ('2', '2024-09-02', '39.91'),
                    ('3', '2024-10-21', '16.34'),
                    ('4', '2024-11-11', '29.78'),
                    ('5', '2024-12-18', '52.31');

INSERT INTO payments (order_id, amount, payment_method, payment_status) VALUES
(1, '54.35', 'Credit', 'Completed'),
(2, '39.91', 'Credit', 'Completed'),
(3, '16.34', 'Apple Pay', 'Pending'),
(4, '29.78', 'Debit', 'Completed'),
(5, '52.31', 'PayPal', 'Completed');

INSERT INTO orderItems (order_id, product_id, quantity, price_each) VALUES
    -- john
    (1,3,1, 25.99),
    (1,6,1,23.99),
    (1,1,1, 9.99),
    -- mary
    (2,4,1, 19.99),
    (2,2,1, 14.99),
    -- armani
    (3, 1, 1, 9.99),
    (3,2, 1, 14.99),
    -- sara
    (4, 1,2,9.99),
    (4,2,1, 14.99),
    -- roger
    (5, 5, 1, 30.99),
    (5, 3, 1, 25.99);


-- queries

    -- shows who placed each order
SELECT o.order_id, c.first_name, o.order_date, o.total_amount FROM orders o INNER JOIN customers c on c.customer_id = o.customer_id;


    -- lists products & their category
SELECT p.product_name, c.category_name FROM products p LEFT JOIN Categories C on C.category_id = p.category_id;


    -- shows products above the average price
SELECT product_name, price FROM products WHERE price > (SELECT AVG(price) FROM products);


    -- counts how many products are in each category
SELECT category_id, COUNT(*) AS product_count FROM products GROUP BY category_id;


    -- shows how much was spent in each order
SELECT order_id, SUM(quantity * price_each) AS calcuted_total FROM orderItems GROUP BY order_id;


    -- top 3 expensive items
SELECT product_name, price FROM products ORDER BY price DESC LIMIT 3;


    -- which priced items have decent stock
SELECT * FROM products WHERE price BETWEEN 20 AND 50 AND stock_qty > 20;


    -- customers' names in all caps
SELECT UPPER(first_name) AS NAME_UPPERCASE FROM customers;


    -- top spender
SELECT c.first_name, c.last_name, SUM (oi.quantity * oi.price_each) AS total_spent FROM customers c JOIN orders o on c.customer_id = o.customer_id
                    JOIN orderItems oI on o.order_id = oI.order_id GROUP BY c.customer_id ORDER BY total_spent DESC;


    -- shows either shirts or hoodies
SELECT product_name, price FROM products WHERE category_id IN (1,2); --(shirts & hoodies)


    -- oldest to newest hire
SELECT first_name, last_name, role_id, hire_date FROM employees ORDER BY hire_date;


    -- above average salary
SELECT first_name, last_name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);


    -- employees in each position
SELECT role_id, COUNT(*) AS num_employees FROM employees GROUP BY role_id ORDER BY num_employees DESC;


    -- shows address table
SELECT * FROM addresses;
