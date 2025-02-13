-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://datalakeqgnukps.dfs.core.windows.net/files/sales/yearlysales/DFEA04BC-7F3A-466F-8CFA-35A756EFB0BD_36_0-1.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]
