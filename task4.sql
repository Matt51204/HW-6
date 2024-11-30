-- 1 List the names of customers who spent more than 450.00 on a single bill 
-- on occasions when ‘Charles’ was their Headwaiter.

SELECT DISTINCT C.customer_name 
FROM restCustomer C
WHERE C.customer_id IN (
    SELECT B.customer_id 
    FROM restBill B
    JOIN restWaiters W ON B.waiter_no = W.waiter_no
    JOIN restHeadWaiters HW ON W.headwaiter_no = HW.headwaiter_no
    WHERE B.bill_total > 450.00 AND HW.headwaiter_name = 'Charles'
);

-- 2 A customer called Nerida has complained that a waiter was rude to her 
-- when she dined at the restaurant on the 11th January 2016. 
-- What is the name and surname of the Headwaiter who will have to deal with the matter?

SELECT HW.headwaiter_name, HW.headwaiter_surname 
FROM restHeadWaiters HW
WHERE HW.headwaiter_no = (
    SELECT W.headwaiter_no 
    FROM restWaiters W
    JOIN restBill B ON W.waiter_no = B.waiter_no
    JOIN restCustomer C ON B.customer_id = C.customer_id
    WHERE C.customer_name = 'Nerida' AND B.bill_date = '2016-01-11'
);

-- 3 What are the names of customers with the smallest bill?

SELECT DISTINCT C.customer_name 
FROM restCustomer C
WHERE C.customer_id IN (
    SELECT B.customer_id 
    FROM restBill B
    WHERE B.bill_total = (SELECT MIN(bill_total) FROM restBill)
);

-- 4 List the names of any waiters who have not taken any bills.

SELECT W.waiter_name 
FROM restWaiters W
WHERE NOT EXISTS (
    SELECT 1 
    FROM restBill B 
    WHERE B.waiter_no = W.waiter_no
);

-- 5 Which customers had the largest single bill? 
-- List the customer name, the name and surname of headwaiters, and the room name where they were served on that occasion.

SELECT C.customer_name, HW.headwaiter_name, HW.headwaiter_surname, R.room_name 
FROM restBill B
JOIN restCustomer C ON B.customer_id = C.customer_id
JOIN restWaiters W ON B.waiter_no = W.waiter_no
JOIN restHeadWaiters HW ON W.headwaiter_no = HW.headwaiter_no
JOIN restRooms R ON B.room_id = R.room_id
WHERE B.bill_total = (SELECT MAX(bill_total) FROM restBill);
