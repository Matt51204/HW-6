-- 1 Which waiters have taken 2 or more bills on a single date? 
-- List the waiter names and surnames, the dates, and the number of bills they have taken.

SELECT W.waiter_name, W.waiter_surname, B.bill_date, COUNT(B.bill_no) AS bill_count
FROM restWaiters W
JOIN restBill B ON W.waiter_no = B.waiter_no
GROUP BY W.waiter_no, B.bill_date
HAVING COUNT(B.bill_no) >= 2;

-- 2 List the rooms with tables that can serve more than 6 people and how many of such tables they have.

SELECT R.room_name, COUNT(T.table_no) AS table_count
FROM restRooms R
JOIN restTables T ON R.room_id = T.room_id
WHERE T.no_of_seats > 6
GROUP BY R.room_name;

-- 3 List the names of the rooms and the total amount of bills in each room.

SELECT R.room_name, COUNT(B.bill_no) AS total_bills
FROM restRooms R
JOIN restBill B ON R.room_id = B.room_id
GROUP BY R.room_name;

-- 4 List the headwaiter’s name and surname and the total bill amount their waiters have taken. 
-- Order the list by total bill amount, largest first.

SELECT HW.headwaiter_name, HW.headwaiter_surname, SUM(B.bill_total) AS total_bill_amount
FROM restHeadWaiters HW
JOIN restWaiters W ON HW.headwaiter_no = W.headwaiter_no
JOIN restBill B ON W.waiter_no = B.waiter_no
GROUP BY HW.headwaiter_no
ORDER BY total_bill_amount DESC;

-- 5 List any customers who have spent more than £400 on average.

SELECT C.customer_name, AVG(B.bill_total) AS avg_spent
FROM restCustomer C
JOIN restBill B ON C.customer_id = B.customer_id
GROUP BY C.customer_id
HAVING AVG(B.bill_total) > 400;

-- 6 Which waiters have taken 3 or more bills on a single date? 
-- List the waiter names, surnames, and the number of bills they have taken.

SELECT W.waiter_name, W.waiter_surname, COUNT(B.bill_no) AS bill_count
FROM restWaiters W
JOIN restBill B ON W.waiter_no = B.waiter_no
GROUP BY W.waiter_no, B.bill_date
HAVING COUNT(B.bill_no) >= 3;
