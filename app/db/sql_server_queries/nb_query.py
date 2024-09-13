nb_fit_query = """
        SELECT 
    CONVERT(DATE, PT.CreatedDate) AS CreatedDate,
    'AU-FIT' AS Country,
    CASE 
        WHEN Q.QuoteSaveFrom = 1 THEN 'Phone'
        WHEN Q.QuoteSaveFrom = 2 THEN 'Web'
        ELSE 'Other'
    END AS PolicyReceivedMethodId,
    COUNT(P.PolicyNumber) AS Sales
FROM [fit-petcover].[dbo].PolicyTransaction PT
INNER JOIN [fit-petcover].[dbo].Policy P ON P.Id = PT.PolicyId
INNER JOIN [fit-petcover].[dbo].Quote Q ON Q.Id = PT.QuoteId
WHERE 
    CONVERT(DATE, PT.CreatedDate) >= :start_date
    AND CONVERT(DATE, PT.CreatedDate) < :end_date
    AND PT.TransactionTypeId = 1
    AND ISNULL(P.IsFreeProduct, 0) = 0
    AND P.PolicyStatusId = (SELECT Id FROM [fit-petcover].[dbo].PolicyStatus WHERE Name = 'Active')
    AND ISNULL(P.PetName, '') NOT LIKE '%test%'
    AND P.PolicyNumber NOT LIKE '%TEST%'
GROUP BY 
    CONVERT(DATE, PT.CreatedDate),
    CASE 
        WHEN Q.QuoteSaveFrom = 1 THEN 'Phone'
        WHEN Q.QuoteSaveFrom = 2 THEN 'Web'
        ELSE 'Other'
    END
        """
nb_uts_query = """
    SELECT
        CreatedDate,
        PolicyReceivedMethodId,
        Country,
        COUNT(PolicyNumber) AS Sales
    FROM (
        SELECT
            PO.ProductCode,
            PO.ProductName,
            TT.TransactionTypeName,
            TT.Id AS TransactionTypeId,
            PA.TotalPremiumAmount,
            0 AS [IsPetIdProduct],
            PA.StartDate,
            CONVERT(DATE, PA.CreatedDate) AS CreatedDate,
            P.PolicyNumber,
            P.PetName,
            CL.FirstName AS ClientName,
            P.IsFreeProduct,
            CASE
                WHEN U.FirstName IN ('FIT', 'Web') THEN 'Web'
                ELSE 'Phone'
            END AS PolicyReceivedMethodId,
            'UTS1' AS [System],
            PS.PolicyStatusName,
            'AU-UTS' AS Country
        FROM [PolicyActivity] PA
        LEFT JOIN Policy P ON P.Id = PA.PolicyId
        LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
        INNER JOIN [Master].[TransactionType] TT ON TT.Id = PA.TransactionTypeId
        INNER JOIN [dbo].[Product] PO ON PO.Id = PA.ProductId
        LEFT JOIN Client CL ON CL.Id = P.ClientId
        LEFT JOIN [dbo].[User] U ON P.ExecutiveId = U.Id
        WHERE
            CONVERT(DATE, PA.CreatedDate) >= :start_date
            AND CONVERT(DATE, PA.CreatedDate) < :end_date
            AND PA.TransactionTypeId = 1
            AND ISNULL(CL.FirstName, '') NOT LIKE '%Test%'
            AND ISNULL(P.PetName, '') NOT LIKE '%test%'
            AND P.PolicyNumber NOT LIKE '%TEST%'
            AND PS.PolicyStatusName = 'Active'
            AND ISNULL(P.IsFreeProduct, 0) = 0
            AND PO.ProductCode NOT LIKE '%CM%'
    ) AS FilteredData
    GROUP BY
        PolicyReceivedMethodId,
        Country, CreatedDate
"""
