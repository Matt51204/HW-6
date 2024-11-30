-- 1 List the names of the waiters who have served the customer Tanya Singh.

SELECT DISTINCT waiter_name, waiter_surname 
FROM restWaiters W
JOIN restBill B ON W.waiter_no = B.waiter_no
JOIN restCustomer C ON B.customer_id = C.customer_id
WHERE C.customer_name = 'Tanya' AND C.customer_surname = 'Singh';

-- 2 On which dates in February 2016 did the Headwaiter 'Charles' manage the 'Green' room? 
-- The output date should be in the format they are stored.

SELECT room_date 
FROM restRooms R
JOIN restHeadWaiters HW ON R.headwaiter_no = HW.headwaiter_no
WHERE HW.headwaiter_name = 'Charles' AND R.room_name = 'Green'
  AND room_date BETWEEN '2016-02-01' AND '2016-02-29';

-- 3 List the names and surnames of the waiters with the same headwaiter as the waiter Zoe Ball.

SELECT DISTINCT waiter_name, waiter_surname 
FROM restWaiters
WHERE headwaiter_no = (
    SELECT headwaiter_no 
    FROM restWaiters 
    WHERE waiter_name = 'Zoe' AND waiter_surname = 'Ball'
);

-- 4 List the customer name, the amount they spent and the waiter’s name for all bills. 
-- Order the list by the amount spent, highest bill first.

SELECT C.customer_name, B.bill_total, W.waiter_name 
FROM restBill B
JOIN restCustomer C ON B.customer_id = C.customer_id
JOIN restWaiters W ON B.waiter_no = W.waiter_no
ORDER BY B.bill_total DESC;

-- 5 List the names and surnames of the waiters who serve tables that worked in the same team that served bills 00014 and 00017.

SELECT DISTINCT waiter_name, waiter_surname 
FROM restWaiters
WHERE headwaiter_no IN (
    SELECT headwaiter_no 
    FROM restBill B
    JOIN restWaiters W ON B.waiter_no = W.waiter_no
    WHERE B.bill_no IN ('00014', '00017')
);

-- 6 List the names and surnames of the waiters in the team (including the headwaiter) 
-- that served Blue room on 160312.

SELECT DISTINCT W.waiter_name, W.waiter_surname 
FROM restWaiters W
WHERE W.waiter_no IN (
    SELECT B.waiter_no 
    FROM restBill B
    WHERE B.room_name = 'Blue' AND B.bill_date = '160312'
)
OR W.headwaiter_no = (
    SELECT R.headwaiter_no 
    FROM restRooms R
    WHERE R.room_name = 'Blue' AND R.room_date = '160312'
);