USE [fituk_26022020]
GO

SELECT   Country,PolicyReceivedMethodId,
COUNT(PolicyNumber) AS Sales
FROM
  (  SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, 0 AS [IsPetIdProduct], PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName, CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS1' as [System], PS.PolicyStatusName,
	'BPIS' AS [Country]
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id

    UNION ALL

    SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, ISNULL(P.IsPetIdProduct,0) AS IsPetIdProduct, PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName,CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS2' as [System], PS.PolicyStatusName,
	CASE WHEN ISNULL(P.IsPetIdProduct,0) = 0 THEN 'BPIS' ELSE 'PetId' END AS [Country]
    FROM [UTS_UK2_PROD].[dbo].[PolicyActivity] PA
    INNER JOIN [UTS_UK2_PROD].[Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [UTS_UK2_PROD].[dbo].[Product] PO ON PO.Id=PA.ProductId
    LEFT JOIN [UTS_UK2_PROD].[dbo].[Policy] P ON P.Id=PA.PolicyId
	LEFT JOIN [UTS_UK2_PROD].[Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
	LEFT JOIN [UTS_UK2_PROD].[dbo].Client CL ON CL.Id = P.ClientId
	LEFT JOIN [UTS_UK2_PROD].[dbo].[User] U ON P.ExecutiveId=U.Id) t

	WHERE (t.CreatedDate = '2024-09-10')
	AND t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	AND t.PolicyStatusName = 'Active'
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')

GROUP BY  PolicyReceivedMethodId, Country
ORDER BY PolicyReceivedMethodId, Country

-------------------------------------
-------------------------------------


USE [fituk_26022020]
GO

SELECT Country,PolicyReceivedMethodId,
COUNT(PolicyNumber) AS Sales
FROM
  (  SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, 0 AS [IsPetIdProduct], PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName, CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS1' as [System], PS.PolicyStatusName,
	'BPIS' AS [Country]
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id

    UNION ALL

    SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, ISNULL(P.IsPetIdProduct,0) AS IsPetIdProduct, PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName,CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS2' as [System], PS.PolicyStatusName,
	CASE WHEN ISNULL(P.IsPetIdProduct,0) = 0 THEN 'BPIS' ELSE 'PetId' END AS [Country]
    FROM [UTS_UK2_PROD].[dbo].[PolicyActivity] PA
    INNER JOIN [UTS_UK2_PROD].[Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [UTS_UK2_PROD].[dbo].[Product] PO ON PO.Id=PA.ProductId
    LEFT JOIN [UTS_UK2_PROD].[dbo].[Policy] P ON P.Id=PA.PolicyId
	LEFT JOIN [UTS_UK2_PROD].[Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
	LEFT JOIN [UTS_UK2_PROD].[dbo].Client CL ON CL.Id = P.ClientId
	LEFT JOIN [UTS_UK2_PROD].[dbo].[User] U ON P.ExecutiveId=U.Id) t

	WHERE (t.CreatedDate >= '2024-07-01' AND t.CreatedDate < '2024-08-01')
	AND t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	AND t.PolicyStatusName = 'Active'
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')

GROUP BY PolicyReceivedMethodId, Country
ORDER BY PolicyReceivedMethodId, Country


-----


USE [fituk_26022020]
GO

SELECT * 
FROM
  (  SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, 0 AS [IsPetIdProduct], PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName, CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId],U.FirstName,P.CreatedBy, 'UTS1' as [System], PS.PolicyStatusName,
	PC.CreatedDate AS [CancellationDate],'BPIS' AS [Country]
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id
	LEFT JOIN PolicyCancellation PC ON PC.PolicyId = P.Id

    UNION ALL

    SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, ISNULL(P.IsPetIdProduct,0) AS IsPetIdProduct, PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName,CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId],U.FirstName,P.CreatedBy, 'UTS2' as [System], PS.PolicyStatusName,
	PC.CreatedDate AS [CancellationDate],CASE WHEN ISNULL(P.IsPetIdProduct,0) = 0 THEN 'BPIS' ELSE 'PetId' END AS [Country]
    FROM [UTS_UK2_PROD].[dbo].[PolicyActivity] PA
    INNER JOIN [UTS_UK2_PROD].[Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [UTS_UK2_PROD].[dbo].[Product] PO ON PO.Id=PA.ProductId
    LEFT JOIN [UTS_UK2_PROD].[dbo].[Policy] P ON P.Id=PA.PolicyId
	LEFT JOIN [UTS_UK2_PROD].[Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
	LEFT JOIN [UTS_UK2_PROD].[dbo].Client CL ON CL.Id = P.ClientId
	LEFT JOIN [UTS_UK2_PROD].[dbo].[User] U ON P.ExecutiveId=U.Id
	LEFT JOIN [UTS_UK2_PROD].[dbo].PolicyCancellation PC ON PC.PolicyId = P.Id) t

	WHERE (t.CreatedDate >= '2024-07-16' AND t.CreatedDate <= '2024-08-13')
	AND t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	--AND t.PolicyStatusName = 'Active'
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')

ORDER BY t.CreatedDate,PolicyReceivedMethodId, Country