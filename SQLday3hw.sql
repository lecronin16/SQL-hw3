SELECT * FROM address;

-- List all customers who live in Texas (use JOINs)
-- 5
SELECT customer_id, first_name, last_name, address.district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';





-- Get all payments above $6.99 with the Customer's Full NAME
-- 3698 of them:

SELECT first_name, last_name, payment.amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount DESC;





-- Show all customers names who have made payments over $175 (use subqueries)
-- 139 of them:

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);





-- List all customers that live in Nepal (use the city table)
-- 0

SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
WHERE city = 'Nepal';

SELECT * FROM city





-- Which staff member had the most transactions?
-- staff_id 1 - Mike Hillyer had most transactions

-- staff id to sum(rental_id)?
SELECT first_name, last_name, SUM(rental.rental_id), staff.staff_id
FROM staff
INNER JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id
ORDER BY SUM(rental_id) DESC;





-- How many movies of each rating are there?
-- film id, rating, inventory id (count?)
SELECT rating, COUNT(inventory_id)
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
GROUP BY rating
ORDER BY COUNT(inventory_id) DESC;






-- Show all customers who have made a single payment above $6.99 (use subqueries)
SELECT * FROM payment

-- shows last name of clients and count of times 
--they've spent above 6.99 in an individual transaction:

SELECT last_name, COUNT(customer_id)
FROM (
    SELECT first_name, last_name, payment.amount, customer.customer_id
    FROM customer
    INNER JOIN payment
    ON customer.customer_id = payment.customer_id
) AS customers_payments
WHERE amount > 6.99
GROUP BY customers_payments.last_name
ORDER BY COUNT(customer_id) DESC;

-- SELECT first_name, last_name
-- FROM customer
-- WHERE customer_id IN (
--     SELECT customer_id, COUNT(payment)
--     FROM payment
--     GROUP BY customer_id
-- );

-- SELECT * 
-- FROM customer
-- WHERE customer_id IN (
--     SELECT customer_id
--     FROM payment
--     GROUP BY customer_id
--     HAVING SUM(amount) > 175
--     ORDER BY SUM(amount) DESC
--     LIMIT 10
-- );



-- How many free rentals did our stores give away? 
-- None of the payment amounts were 0, but 30 are less than

-- rental id to payment id if payment <= 0? 
SELECT amount, COUNT(rental.rental_id)
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
WHERE amount <= 0
GROUP BY payment.amount;

SELECT COUNT(rental.rental_id)
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
WHERE amount <= 0;