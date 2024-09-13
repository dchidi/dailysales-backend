SELECT CreatedDate,Country,PolicyReceivedMethod,
COUNT(PolicyNumber) AS Sales


FROM ( SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName,PET.Name as PetType ,
		P.IsFreeProduct,P.ExecutiveId, U2.UserName AS [Quote User], U3.UserName AS [Policy User], Q.CreatedBy,C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,CASE WHEN ISNULL(C.FlybuysNumber,'') = '' THEN 'No' ELSE 'Yes' END as IsFlyBuy
		, PT.TotalPremiumAmount as Premium, (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethod, 'NZ' AS Country
		FROM [fit-petcover-nz].[dbo].PolicyTransaction PT
	LEFT JOIN [fit-petcover-nz].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [fit-petcover-nz].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [fit-petcover-nz].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [fit-petcover-nz].[dbo].Client C ON C.Id = P.ClientId
	LEFT JOIN [fit-petcover-nz].[dbo].Product PO ON PO.Id=PT.ProductID
	INNER JOIN [fit-petcover-nz].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [fit-petcover-nz].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [fit-petcover-nz].[dbo].[User] U3 ON U3.Id=P.ExecutiveId 
	LEFT JOIN [fit-petcover-nz].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	
	UNION ALL

	SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName ,PET.Name as PetType ,
	P.IsFreeProduct, P.ExecutiveId, U2.UserName AS [Quote User], U3.UserName AS [Policy User], Q.CreatedBy, C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate, CASE WHEN ISNULL(C.FlybuysNumber,'') = '' THEN 'No' ELSE 'Yes' END as IsFlyBuy,
	PT.TotalPremiumAmount as Premium, (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethod, 'NZ' AS Country
	FROM [FIT_NZ].[dbo].PolicyTransaction PT
	LEFT JOIN [FIT_NZ].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [FIT_NZ].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [FIT_NZ].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [FIT_NZ].[dbo].Product PO ON PO.Id=PT.ProductID
	LEFT JOIN [FIT_NZ].[dbo].Client C ON C.Id = P.ClientId
	INNER JOIN [FIT_NZ].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [FIT_NZ].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [FIT_NZ].[dbo].[User] U3 ON U3.Id=P.ExecutiveId
	LEFT JOIN [FIT_NZ].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	)t

WHERE (t.CreatedDate = '2024-09-10')
AND t.TransactionTypeId = 1
AND ISNULL(t.IsFreeProduct,0) = 0
AND (t.StatusName = 'Active')
AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
AND t.PolicyNumber NOT LIKE ('%TEST%')

GROUP BY CreatedDate, PolicyReceivedMethod, Country
ORDER BY CreatedDate, PolicyReceivedMethod, Country



------------------------------------------------
--------------------------------------------------




SELECT Country,PolicyReceivedMethod,
COUNT(PolicyNumber) AS Sales


FROM ( SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName,PET.Name as PetType ,
		P.IsFreeProduct,P.ExecutiveId, U2.UserName AS [Quote User], U3.UserName AS [Policy User], Q.CreatedBy,C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,CASE WHEN ISNULL(C.FlybuysNumber,'') = '' THEN 'No' ELSE 'Yes' END as IsFlyBuy
		, PT.TotalPremiumAmount as Premium, (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethod, 'NZ' AS Country
		FROM [fit-petcover-nz].[dbo].PolicyTransaction PT
	LEFT JOIN [fit-petcover-nz].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [fit-petcover-nz].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [fit-petcover-nz].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [fit-petcover-nz].[dbo].Client C ON C.Id = P.ClientId
	LEFT JOIN [fit-petcover-nz].[dbo].Product PO ON PO.Id=PT.ProductID
	INNER JOIN [fit-petcover-nz].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [fit-petcover-nz].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [fit-petcover-nz].[dbo].[User] U3 ON U3.Id=P.ExecutiveId 
	LEFT JOIN [fit-petcover-nz].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	
	UNION ALL

	SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName ,PET.Name as PetType ,
	P.IsFreeProduct, P.ExecutiveId, U2.UserName AS [Quote User], U3.UserName AS [Policy User], Q.CreatedBy, C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate, CASE WHEN ISNULL(C.FlybuysNumber,'') = '' THEN 'No' ELSE 'Yes' END as IsFlyBuy,
	PT.TotalPremiumAmount as Premium, (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethod, 'NZ' AS Country
	FROM [FIT_NZ].[dbo].PolicyTransaction PT
	LEFT JOIN [FIT_NZ].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [FIT_NZ].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [FIT_NZ].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [FIT_NZ].[dbo].Product PO ON PO.Id=PT.ProductID
	LEFT JOIN [FIT_NZ].[dbo].Client C ON C.Id = P.ClientId
	INNER JOIN [FIT_NZ].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [FIT_NZ].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [FIT_NZ].[dbo].[User] U3 ON U3.Id=P.ExecutiveId
	LEFT JOIN [FIT_NZ].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	)t

WHERE t.CreatedDate >= '2024-07-01' AND (t.CreatedDate < '2024-08-01')
AND t.TransactionTypeId = 1
AND ISNULL(t.IsFreeProduct,0) = 0
AND (t.StatusName = 'Active')
AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
AND t.PolicyNumber NOT LIKE ('%TEST%')

GROUP BY PolicyReceivedMethod, Country
ORDER BY PolicyReceivedMethod, Country


------------------------------------------------
--------------------------------------------------




SELECT *


FROM ( SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName,PET.Name as PetType ,
		P.IsFreeProduct,P.ExecutiveId, U2.UserName AS [Quote User], U3.UserName AS [Policy User], Q.CreatedBy,C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate,CASE WHEN ISNULL(C.FlybuysNumber,'') = '' THEN 'No' ELSE 'Yes' END as IsFlyBuy
		, PT.TotalPremiumAmount as Premium, (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethod, 'NZ' AS Country
		FROM [fit-petcover-nz].[dbo].PolicyTransaction PT
	LEFT JOIN [fit-petcover-nz].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [fit-petcover-nz].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [fit-petcover-nz].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [fit-petcover-nz].[dbo].Client C ON C.Id = P.ClientId
	LEFT JOIN [fit-petcover-nz].[dbo].Product PO ON PO.Id=PT.ProductID
	INNER JOIN [fit-petcover-nz].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [fit-petcover-nz].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [fit-petcover-nz].[dbo].[User] U3 ON U3.Id=P.ExecutiveId 
	LEFT JOIN [fit-petcover-nz].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	
	UNION ALL

	SELECT P.PolicyNumber,PT.StartDate,CONVERT(DATE,Pt.CreatedDate) AS CreatedDate,PT.TransactionTypeId,P.ActualEndDate,PO.Name, PS.Name as StatusName ,PET.Name as PetType ,
	P.IsFreeProduct, P.ExecutiveId, U2.UserName AS [Quote User], U3.UserName AS [Policy User], Q.CreatedBy, C.Name AS [ClientName], P.PetName, PC.CreatedDate as CancellationDate, CASE WHEN ISNULL(C.FlybuysNumber,'') = '' THEN 'No' ELSE 'Yes' END as IsFlyBuy,
	PT.TotalPremiumAmount as Premium, (CASE WHEN Q.QuoteSaveFrom = 1 THEN 'Phone' WHEN Q.QuoteSaveFrom = 2 THEN 'Web' ELSE 'Other' END) as PolicyReceivedMethod, 'NZ' AS Country
	FROM [FIT_NZ].[dbo].PolicyTransaction PT
	LEFT JOIN [FIT_NZ].[dbo].Policy P ON P.Id=PT.PolicyId
	INNER JOIN [FIT_NZ].[dbo].PolicyStatus PS On PS.Id = P.PolicyStatusId
	LEFT JOIN [FIT_NZ].[dbo].PetType PET ON P.PetTypeId = PET.Id
	LEFT JOIN [FIT_NZ].[dbo].Product PO ON PO.Id=PT.ProductID
	LEFT JOIN [FIT_NZ].[dbo].Client C ON C.Id = P.ClientId
	INNER JOIN [FIT_NZ].[dbo].Quote  Q ON Q.Id=PT.QuoteId
	LEFT JOIN [FIT_NZ].[dbo].[User] U2 ON U2.UserName = Q.CreatedBy 
	LEFT JOIN [FIT_NZ].[dbo].[User] U3 ON U3.Id=P.ExecutiveId
	LEFT JOIN [FIT_NZ].[dbo].[PolicyCancellation] PC ON PC.PolicyId = P.Id
	)t

WHERE t.CreatedDate >= '2024-07-16' AND (t.CreatedDate <= '2024-08-13')
AND t.TransactionTypeId = 1
AND ISNULL(t.IsFreeProduct,0) = 0
--AND (t.StatusName = 'Active')
AND ISNULL(t.ClientName,'') NOT LIKE ('%Test%')
AND ISNULL(t.PetName,'') NOT LIKE ('%test%')
AND t.PolicyNumber NOT LIKE ('%TEST%')

ORDER BY t.CreatedDate