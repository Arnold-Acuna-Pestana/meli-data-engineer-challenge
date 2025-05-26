-- Tabla: Customer
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    nombre TEXT,
    apellido TEXT,
    email TEXT,
    sexo TEXT,
    direccion TEXT,
    nacimiento DATE,
    telefono TEXT
);

-- Tabla: Category
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    nombre_categoria TEXT,
    path_item TEXT
);

-- Tabla: Item
CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    titulo TEXT,
    precio INT,
    status TEXT,
    category_id INT,
    seller_id INT,
    FOREIGN KEY (seller_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Tabla: Order
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    item_id INT,
    seller_id INT,
    buyer_id INT,
    cantidad INT,
    precio INT,
    order_date DATE,
    FOREIGN KEY (item_id) REFERENCES Item(item_id),
    FOREIGN KEY (seller_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (buyer_id) REFERENCES Customer(customer_id)
);

-- Tabla: Item_History
CREATE TABLE Item_History (
    item_id INT,
    snapshot_date DATE,
    precio INT,
    status TEXT,
    PRIMARY KEY (item_id, snapshot_date),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);
