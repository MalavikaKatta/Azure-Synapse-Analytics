 SELECT
     TOP 100 *
 FROM
     OPENROWSET(
         BULK 'https://datalakeqgnukps.dfs.core.windows.net/files/sales/csv/**',
         FORMAT = 'CSV',
         PARSER_VERSION='2.0',
         HEADER_ROW = TRUE
     ) AS [result]