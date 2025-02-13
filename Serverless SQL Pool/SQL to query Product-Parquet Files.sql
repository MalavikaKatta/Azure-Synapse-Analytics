-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://datalakeqgnukps.dfs.core.windows.net/files/sales/productsales/DBD275E4-778C-4B99-84ED-B65A557CD8DF_22_0-1.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]
