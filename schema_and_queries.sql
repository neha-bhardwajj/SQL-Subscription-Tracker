-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    join_date DATE
);

-- 2. Services Table
CREATE TABLE Services (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(50),
    category VARCHAR(30), -- OTT, Gym, Utility, SaaS
    monthly_cost DECIMAL(10, 2)
);

-- 3. Subscriptions Table (Junction Table with Keys)
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    service_id INT,
    start_date DATE,
    end_date DATE, -- NULL means currently Active
    status VARCHAR(20), -- 'Active', 'Cancelled'
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

INSERT INTO Users VALUES 
(1, 'Rahul', '2025-01-10'),
(2, 'Priya', '2025-02-15'),
(3, 'Amit', '2025-03-01');

INSERT INTO Services VALUES 
(101, 'Netflix', 'OTT', 649.00),
(102, 'Spotify', 'Music', 119.00),
(103, 'Cult.fit', 'Gym', 1500.00),
(104, 'ChatGPT Plus', 'SaaS', 1999.00);

INSERT INTO Subscriptions VALUES 
(1, 1, 101, '2025-01-10', NULL, 'Active'),
(2, 1, 103, '2025-01-15', '2025-04-15', 'Cancelled'),
(3, 2, 101, '2025-02-15', NULL, 'Active'),
(4, 2, 102, '2025-02-15', NULL, 'Active'),
(5, 2, 104, '2025-03-01', NULL, 'Active'),
(6, 3, 102, '2025-03-01', '2025-05-01', 'Cancelled');

SELECT 
    u.user_name,
    COUNT(s.service_id) AS total_active_subscriptions,
    SUM(serv.monthly_cost) AS total_monthly_spend
FROM Users u
JOIN Subscriptions s ON u.user_id = s.user_id
JOIN Services serv ON s.service_id = serv.service_id
WHERE s.status = 'Active'
GROUP BY u.user_name;

SELECT 
    serv.service_name,
    COUNT(CASE WHEN s.status = 'Cancelled' THEN 1 END) AS cancellations,
    COUNT(s.subscription_id) AS total_subscriptions,
    ROUND((COUNT(CASE WHEN s.status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(s.subscription_id)), 2) AS churn_rate_pct
FROM Services serv
JOIN Subscriptions s ON serv.service_id = s.service_id
GROUP BY serv.service_name;

SELECT 
    u.user_name,
    SUM(serv.monthly_cost) AS total_spend,
    DENSE_RANK() OVER (ORDER BY SUM(serv.monthly_cost) DESC) AS spend_rank
FROM Users u
JOIN Subscriptions s ON u.user_id = s.user_id
JOIN Services serv ON s.service_id = serv.service_id
WHERE s.status = 'Active'
GROUP BY u.user_name;
