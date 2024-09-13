USE [UTS_DE_PROD]
GO

SELECT Country,PolicyReceivedMethodId,
COUNT(PolicyNumber) AS Sales
FROM
  (  SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, 0 AS [IsPetIdProduct], PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName, CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS1' as [System], PS.PolicyStatusName,
	'DE' AS [Country], P.InsuredName
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id) t

	WHERE (t.CreatedDate = '2024-09-10')
	AND t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	AND t.PolicyStatusName = 'Active'
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')
	AND ISNULL(t.InsuredName,'') NOT LIKE ('%Jaytri Vyas%')

GROUP BY PolicyReceivedMethodId, Country
ORDER BY PolicyReceivedMethodId, Country



--------------------------------------------------------
--------------------------------------------------------


SELECT Country,PolicyReceivedMethodId,
COUNT(PolicyNumber) AS Sales
FROM
  (  SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, 0 AS [IsPetIdProduct], PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName, CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS1' as [System], PS.PolicyStatusName,
	'DE' AS [Country], P.InsuredName
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id) t

	WHERE (t.CreatedDate >= '2024-07-01' AND t.CreatedDate < '2024-08-01')
	AND t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	AND t.PolicyStatusName = 'Active'
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')
	AND ISNULL(t.InsuredName,'') NOT LIKE ('%Jaytri Vyas%')

GROUP BY PolicyReceivedMethodId, Country
ORDER BY PolicyReceivedMethodId, Country


--------------------------------------------------------
--------------------------------------------------------


SELECT *
FROM
  (  SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, 0 AS [IsPetIdProduct], PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName, CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS1' as [System], PS.PolicyStatusName,
	PC.CreatedDate AS CancellationDate,'DE' AS [Country], P.InsuredName
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id
	LEFT JOIN PolicyCancellation PC ON PC.PolicyId = P.Id) t

	WHERE (t.CreatedDate >= '2024-07-16' AND t.CreatedDate <= '2024-08-13')
	AND t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	--AND t.PolicyStatusName = 'Active'
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')
	AND ISNULL(t.InsuredName,'') NOT LIKE ('%Jaytri Vyas%')

ORDER BY PolicyReceivedMethodId, Country