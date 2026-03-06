-- ============================================================
-- FunFit - Zumba Management System
-- Database Setup Script
-- Run this in MySQL before starting the application
-- ============================================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS funfit_db;
USE funfit_db;

-- Step 2: Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS participant;
DROP TABLE IF EXISTS batch;

-- Step 3: Create the batch table
CREATE TABLE batch (
    bid   INT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(256) NOT NULL,
    slot  VARCHAR(256) NOT NULL,
    time  VARCHAR(256) NOT NULL
);

-- Step 4: Create the participant table with foreign key to batch
CREATE TABLE participant (
    pid   INT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(256) NOT NULL,
    phone VARCHAR(256),
    email VARCHAR(256),
    bid   INT,
    CONSTRAINT FK_ParticipantBatch FOREIGN KEY (bid) REFERENCES batch(bid)
);

-- ============================================================
-- Step 5: Sample Data (optional, for testing)
-- ============================================================

-- Insert sample batches
INSERT INTO batch (name, slot, time) VALUES
    ('Zumba Beginners A',    'Morning', '06:00 AM - 07:00 AM'),
    ('Zumba Intermediate B', 'Morning', '07:30 AM - 08:30 AM'),
    ('Zumba Advanced C',     'Evening', '06:00 PM - 07:00 PM'),
    ('Zumba All Levels D',   'Evening', '07:30 PM - 08:30 PM');

-- Insert sample participants
INSERT INTO participant (name, phone, email, bid) VALUES
    ('Alice Johnson',  '+91 98765 43210', 'alice@example.com',  1),
    ('Bob Smith',      '+91 87654 32109', 'bob@example.com',    1),
    ('Carol Williams', '+91 76543 21098', 'carol@example.com',  2),
    ('David Brown',    '+91 65432 10987', 'david@example.com',  3),
    ('Eva Green',      '+91 54321 09876', 'eva@example.com',    4);

-- ============================================================
-- Verification Queries
-- ============================================================
SELECT 'Batches:' AS '';
SELECT * FROM batch;

SELECT 'Participants:' AS '';
SELECT p.pid, p.name, p.phone, p.email, b.name AS batch_name, b.slot, b.time
FROM participant p
JOIN batch b ON p.bid = b.bid
ORDER BY b.bid, p.pid;
