SELECT d.CalendarYear, d.FiscalQuarter, st.SalesTerritoryRegion AS SalesTerritory,SUM(f.OrderQuantity) AS TotalQuantitySold 
FROM FactResellerSales f
INNER JOIN DimDate d ON f.OrderDateKey = d.DateKey
JOIN DimEmployee e ON f.EmployeeKey = e.EmployeeKey
JOIN DimSalesTerritory st ON e.SalesTerritoryKey = st.SalesTerritoryKey
GROUP BY d.CalendarYear, d.FiscalQuarter, st.SalesTerritoryRegion
ORDER BY d.CalendarYear, d.FiscalQuarter, st.SalesTerritoryRegion