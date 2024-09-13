USE [UTS-AU-NEW]
GO

SELECT Country,PolicyReceivedMethodId,
COUNT(PolicyNumber) AS Sales
FROM
  (  SELECT PO.ProductCode,PO.ProductName, TT.TransactionTypeName,TT.Id as TransactionTypeId,PA.TotalPremiumAmount, 0 AS [IsPetIdProduct], PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,
	P.PolicyNumber,P.PetName, CL.FirstName as ClientName, P.IsFreeProduct, CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId], 'UTS1' as [System], PS.PolicyStatusName,
	'AU - UTS' AS [Country]
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id) t

	WHERE (t.CreatedDate = '2024-09-10')
	AND 
	t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	AND t.PolicyStatusName = 'Active'
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')

GROUP BY PolicyReceivedMethodId, Country
ORDER BY PolicyReceivedMethodId, Country


SELECT *
FROM
  (  SELECT P.PolicyNumber,PA.StartDate,CONVERT(DATE,PA.CreatedDate) AS CreatedDate,TT.Id as TransactionTypeId,P.ActualEndDate,PO.ProductName, PS.PolicyStatusName,PO.ProductCode,P.IsFreeProduct,
  P.ExecutiveId, U2.UserName as [Quote User],CASE WHEN U.FirstName IN ('FIT','Web') THEN 'Web' ELSE 'Phone' END AS [PolicyReceivedMethodId],P.CreatedBy,CL.FirstName as ClientName,P.PetName,PC.CreatedDate as [CancellationDate],
 'AU - UTS' AS [Country]
    FROM [PolicyActivity] PA
	LEFT JOIN Policy P ON P.Id = PA.PolicyId
	LEFT JOIN [Master].[PolicyStatus] PS ON PS.Id = P.PolicyStatusId
    INNER JOIN [Master].[TransactionType] TT ON TT.Id=PA.TransactionTypeId
    INNER JOIN [dbo].[Product] PO ON PO.Id=PA.ProductId
	LEFT JOIN Client CL ON CL.Id = P.ClientId
	LEFT JOIN [dbo].[User] U ON P.ExecutiveId=U.Id
	LEFT JOIN Quote Q ON Q.Id = PA.QuoteId
	LEFT JOIN [dbo].[User] U2 ON Q.ExecutiveId = U2.Id
	LEFT JOIN PolicyCancellation PC ON PC.PolicyId = P.Id) t

	WHERE (t.CreatedDate >= '2024-07-16' AND t.CreatedDate <= '2024-08-13')
	AND 
	t.TransactionTypeId = 1
	AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
	AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
	AND t.PolicyNumber NOT LIKE ('%TEST%')
	--AND t.PolicyStatusName = 'Active'
	AND ISNULL(t.IsFreeProduct,0) = 0
	AND t.ProductCode NOT LIKE ('%CM%')
