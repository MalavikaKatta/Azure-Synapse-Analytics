 SELECT o.SalesOrderID, c.EmailAddress, p.ProductName, o.Quantity
 FROM SalesOrder AS o
 JOIN Customer AS c ON o.CustomerId = c.CustomerId
 JOIN Product AS p ON o.ProductId = p.ProductId