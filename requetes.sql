--1
SHOW TABLE STATUS;
--Nombre d'enregistrements : 
--customers 122, employees 23, offices 7, orders 64, payments273 et products 110  

--2
SELECT productName, quantityInStock 
FROM products 
WHERE productName LIKE '%Harley%' 
ORDER BY quantityInStock DESC;

--3
SELECT contactFirstName 
FROM customers 
WHERE contactFirstName LIKE '_a%' 
ORDER BY contactFirstName ASC;

--4
SELECT COUNT(*) 
FROM customers 
WHERE contactFirstName LIKE '_a%';
--Il y en a 33

--5
SELECT productName 'Les articles', buyPrice 'Les prix' 
FROM products 
WHERE buyPrice BETWEEN 50 AND 65;

--6
SELECT SUM(amount) 'Total [07/2004]' 
FROM payments 
WHERE paymentDate >= '2004-07-01';

--7
SELECT * 
FROM orderDetails 
WHERE quantityOrdered >= 50 
GROUP BY orderNumber;

--8
SELECT customers.customerNumber, customers.customerName 
FROM customers
LEFT JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE orders.customerNumber IS NULL
ORDER BY customers.customerName; 

--9
SELECT lastName, firstName, employeeNumber, jobTitle 
FROM employees 
WHERE officeCode IS NULL;
--Il n'y a aucun employé rattaché à aucun bureau

--10
SELECT COUNT(DISTINCT city) 
FROM customers;
--Il y a 95 villes différentes
 
--11
SELECT customers.customerName, customers.customerNumber
FROM payments
LEFT JOIN customers ON payments.customerNumber = customers.customerNumber
GROUP BY payments.customerNumber 
ORDER BY SUM(amount) DESC LIMIT 1;

SELECT customers.customerName, SUM(amount) Total_dépensé
FROM payments
LEFT JOIN customers ON payments.customerNumber = customers.customerNumber
GROUP BY payments.customerNumber 
ORDER BY SUM(amount);

--12
SELECT products.productLine, products.productName, SUM(quantityOrdered) 'Total des quantités commandées', SUM(quantityOrdered*priceEach) 'Somme des ventes' 
FROM orderDetails
INNER JOIN orders ON orderDetails.orderNumber = orders.orderNumber
INNER JOIN products ON orderDetails.productCode = products.productCode
WHERE orders.orderDate >= '2005-01-01'
GROUP BY products.productCode
ORDER BY products.productLine;

--13
SELECT orders.orderNumber, orders.orderDate, orders.status, customers.customerName, products.productName, products.productCode, orderDetails.quantityOrdered
FROM orders
LEFT JOIN customers ON orders.customerNumber = customers.customerNumber
LEFT JOIN orderDetails ON orders.orderNumber = orderDetails.orderNumber
LEFT JOIN products ON orderDetails.productCode = products.productCode;

--14
SELECT customers.customerName, offices.city, offices.country, employees.lastName, employees.firstName, employees.jobTitle, orderdetails.productCode, orderdetails.quantityOrdered, products.productLine, products.buyPrice 
FROM orders
LEFT JOIN customers ON orders.customerNumber = customers.customerNumber
LEFT JOIN orderDetails ON orders.orderNumber = orderDetails.orderNumber
LEFT JOIN products ON orderDetails.productCode = products.productCode
LEFT JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
LEFT JOIN offices ON offices.officeCode = employees.officeCode; 

