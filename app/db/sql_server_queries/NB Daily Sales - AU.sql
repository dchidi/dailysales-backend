SELECT CreatedDate,Country,PolicyReceivedMethodId,
COUNT(PolicyNumber) AS Sales

FROM ( SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName,PET.Name as PetType ,
		P.IsFreeProduct,P.ExecutiveId, U2.UserName AS [Quote User], (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethodId, 
		Q.CreatedBy,C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,'AU' AS Country
		FROM [fit-petcover].[dbo].PolicyTransaction PT
	LEFT JOIN [fit-petcover].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [fit-petcover].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [fit-petcover].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [fit-petcover].[dbo].Client C ON C.Id = P.ClientId
	LEFT JOIN [fit-petcover].[dbo].Product PO ON PO.Id=PT.ProductID
	INNER JOIN [fit-petcover].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [fit-petcover].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [fit-petcover].[dbo].[User] U3 ON U3.Id=P.ExecutiveId 
	LEFT JOIN [fit-petcover].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	
	UNION ALL

	SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName ,PET.Name as PetType ,
	P.IsFreeProduct, P.ExecutiveId, U2.UserName AS [Quote User], (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethodId, 
	Q.CreatedBy, C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,'AU' AS Country
	FROM [FIT_DATA].[dbo].PolicyTransaction PT
	LEFT JOIN [FIT_DATA].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [FIT_DATA].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [FIT_DATA].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [FIT_DATA].[dbo].Product PO ON PO.Id=PT.ProductID
	LEFT JOIN [FIT_DATA].[dbo].Client C ON C.Id = P.ClientId
	INNER JOIN [FIT_DATA].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [FIT_DATA].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [FIT_DATA].[dbo].[User] U3 ON U3.Id=P.ExecutiveId
	LEFT JOIN [FIT_DATA].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	)t

WHERE (t.CreatedDate = '2024-09-10')
AND t.TransactionTypeId = 1
AND ISNULL(t.IsFreeProduct,0) = 0
AND (t.StatusName = 'Active')
AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
AND t.PolicyNumber NOT LIKE ('%TEST%')

GROUP BY CreatedDate, PolicyReceivedMethodId, Country
ORDER BY CreatedDate, PolicyReceivedMethodId, Country


---------------------------------------------------------
---------------------------------------------------------


SELECT Country,PolicyReceivedMethodId,
COUNT(PolicyNumber) AS Sales

FROM ( SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName,PET.Name as PetType ,
		P.IsFreeProduct,P.ExecutiveId, U2.UserName AS [Quote User], (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethodId, 
		Q.CreatedBy,C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,'AU' AS Country
		FROM [fit-petcover].[dbo].PolicyTransaction PT
	LEFT JOIN [fit-petcover].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [fit-petcover].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [fit-petcover].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [fit-petcover].[dbo].Client C ON C.Id = P.ClientId
	LEFT JOIN [fit-petcover].[dbo].Product PO ON PO.Id=PT.ProductID
	INNER JOIN [fit-petcover].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [fit-petcover].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [fit-petcover].[dbo].[User] U3 ON U3.Id=P.ExecutiveId 
	LEFT JOIN [fit-petcover].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	
	UNION ALL

	SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName ,PET.Name as PetType ,
	P.IsFreeProduct, P.ExecutiveId, U2.UserName AS [Quote User], (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethodId, 
	Q.CreatedBy, C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,'AU' AS Country
	FROM [FIT_DATA].[dbo].PolicyTransaction PT
	LEFT JOIN [FIT_DATA].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [FIT_DATA].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [FIT_DATA].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [FIT_DATA].[dbo].Product PO ON PO.Id=PT.ProductID
	LEFT JOIN [FIT_DATA].[dbo].Client C ON C.Id = P.ClientId
	INNER JOIN [FIT_DATA].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [FIT_DATA].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [FIT_DATA].[dbo].[User] U3 ON U3.Id=P.ExecutiveId
	LEFT JOIN [FIT_DATA].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	)t

WHERE t.CreatedDate >= '2024-07-01' AND (t.CreatedDate < '2024-08-01')
AND t.TransactionTypeId = 1
AND ISNULL(t.IsFreeProduct,0) = 0
AND (t.StatusName = 'Active')
AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
AND t.PolicyNumber NOT LIKE ('%TEST%')

GROUP BY PolicyReceivedMethodId, Country
ORDER BY PolicyReceivedMethodId, Country



--============================================================================================================================

SELECT *

FROM ( SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName,PET.Name as PetType ,
		P.IsFreeProduct,P.ExecutiveId, U2.UserName AS [Quote User], (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethodId, 
		Q.CreatedBy,C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,'AU' AS Country, PRO.PromoCode
		FROM [fit-petcover].[dbo].PolicyTransaction PT
	LEFT JOIN [fit-petcover].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [fit-petcover].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [fit-petcover].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [fit-petcover].[dbo].Client C ON C.Id = P.ClientId
	LEFT JOIN [fit-petcover].[dbo].Product PO ON PO.Id=PT.ProductID
	INNER JOIN [fit-petcover].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [fit-petcover].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [fit-petcover].[dbo].[User] U3 ON U3.Id=P.ExecutiveId 
	LEFT JOIN [fit-petcover].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	LEFT JOIN [fit-petcover].[dbo].Promotion PRO ON PRO.Id = Q.PromotionId
	
	UNION ALL

	SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName ,PET.Name as PetType ,
	P.IsFreeProduct, P.ExecutiveId, U2.UserName AS [Quote User], (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethodId, 
	Q.CreatedBy, C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,'AU' AS Country, Q.PromoCode
	FROM [FIT_DATA].[dbo].PolicyTransaction PT
	LEFT JOIN [FIT_DATA].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [FIT_DATA].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [FIT_DATA].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [FIT_DATA].[dbo].Product PO ON PO.Id=PT.ProductID
	LEFT JOIN [FIT_DATA].[dbo].Client C ON C.Id = P.ClientId
	INNER JOIN [FIT_DATA].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [FIT_DATA].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [FIT_DATA].[dbo].[User] U3 ON U3.Id=P.ExecutiveId
	LEFT JOIN [FIT_DATA].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	)t

WHERE t.CreatedDate >= '2024-07-16' AND (t.CreatedDate <= '2024-08-13')
AND t.TransactionTypeId = 1
AND ISNULL(t.IsFreeProduct,0) = 0
--AND (t.StatusName = 'Active')
AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
AND t.PolicyNumber NOT LIKE ('%TEST%')

ORDER BY CreatedDate,PolicyReceivedMethodId, Country