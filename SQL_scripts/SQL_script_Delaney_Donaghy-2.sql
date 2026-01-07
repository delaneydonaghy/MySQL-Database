/**
Question 1 Write an SQL statement to retrieve all the data from Product table.
**/
SELECT * FROM Product;

/**
Question 2 Write an SQL statement to list LastName, FirstName, and Phone for all customers 
who live in Dallas and have a LastName that begins with the letter T.
**/

SELECT LastName, FirstName, Phone
From customer
WHERE City = "Dallas"
	AND LastName LIKE 'T%';

/**
Question 3 Write an SQL statement to show both the sum and the average of Subtotal 
for INVOICE as SumOfSubTotal and AverageOfSubTotal, respectively.
**/

SELECT SUM(SubTotal) AS SumOfSubTotal, AVG(SubTotal) AS AverageofSubTotal
FROM invoice;



/**
Question 4 	
From the Line_Item table, find all the sales with the sum of Total over $60. 
For each sale, display the invoicenumber, sum of Total for that invoice, 
and the quantity of products sold. Sort the results by the sum of Total in descending order.
**/

SELECT InvoiceNumber, SUM(Total) AS TotalSum, SUM(Quantity) AS TotalQuantity
FROM line_item
GROUP BY InvoiceNumber
HAVING SUM(Total) > 60
ORDER BY TotalSum DESC;

/**
Question 5 List the InvoiceNumber for sales that include the product Heather Sweeney 
Seminar Live in Dallas on 25-OCT-17 video. Use a subquery.
**/

SELECT InvoiceNumber
FROM line_item
WHERE ProductNumber IN (
	SELECT ProductNumber
    FROM Product
    WHERE ProductDescription = "Heather Sweeney Seminar Live in Dallas on 25-OCT-17 video"
    );

/**
Question 6 Answer Question #5 but use JOIN ON syntax. 
**/

SELECT L.InvoiceNumber
From Line_Item L
JOIN product P on L.ProductNumber - P.ProductNumber
WHERE P.ProductDescription = "Heather Sweeney Seminar Live in Dallas on 25-OCT-17 video";

/**
Question 7 Write an SQL statement to list the FirstName, LastName, 
and Phone of customers (list each name only once) who have attended the 
Kitchen on a Big D Budget seminar.
**/

SELECT DISTINCT C.FirstName, C.LastName, C.Phone
FROM Customer C
JOIN seminar_customer SC ON C.CustomerID = SC.CustomerID
JOIN seminar S ON SC.SeminarID = S.SeminarID
WHERE S.SeminarTitle = "Kitchen on a Big D Budget";

/**
Question 8 Write an SQL statement to list the FirstName, LastName, Phone, ProductNumber 
for customers who have purchased a video product (list each combination of name and product only once). 
 Sort the results by LastName in descending order. (HINT: Video products have a ProductNumber that 
 starts with VK.)
**/

SELECT DISTINCT C.FirstName, C.LastName, C.Phone, L.ProductNumber
FROM Customer C
JOIN Invoice I ON C.CustomerID = I.CustomerID
JOIN Line_Item L ON I.InvoiceNumber = L.InvoiceNumber
WHERE L.ProductNumber LIKE 'VK%'
ORDER BY C.LastName DESC;

/**
Question 9 Show every customer in the database including the customer id, first name,
 last name, and the invoice number of purchase(s) they have made. For a customer who 
 does not make any purchases, the value for invoice number should be NULL. (Hint: use outer join)
**/

SELECT C.CustomerID, C.FirstName, C.LastName, I.InvoiceNumber
FROM Customer C
LEFT OUTER JOIN Invoice I ON C.CustomerID = I.CustomerID;


/**
Question Extra credit Write an SQL statement to show all customers and the products that 
they have purchased. The output from this statement should include any products that have not
 been purchased by any customer. The SQL statement output should list CustomerID, LastName, 
 CustomerIDFirstName, InvoiceNumber, ProductNumber, ProductType, and ProductDescription.
**/

SELECT C.CustomerID, C.LastName, C.FirstName, I.InvoiceNumber, L.ProductName, P.ProductType, P.ProductDescription
FROM Customer C
LEFT JOIN Invoice I ON C.CustomerID = I.CustomerID
LEFT JOIN Line_Item L ON I.InvoiceNUmber = L.InvoiceNumber
LEFT JOIN Product P ON L.ProductNumber = P.ProductNumber;

