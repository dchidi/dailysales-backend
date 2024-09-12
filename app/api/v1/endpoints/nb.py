from app.schemas.nb_schema import NBSchema
from app.db.sqlserver import get_sqlserver_db
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from sqlalchemy import text
from typing import List
from datetime import date

router = APIRouter()

@router.get("/nb", response_model=List[NBSchema])
def get_nb(
    db: Session = Depends(get_sqlserver_db),
    created_date: date = Query(..., description="Date for filtering results")
):
    try:
        # Define the raw SQL query with a placeholder for the date
        query = """
        SELECT 
            CONVERT(DATE, PT.CreatedDate) AS CreatedDate,
            'AU' AS Country,
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
            CONVERT(DATE, PT.CreatedDate) = :created_date
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
        query = """
        
        """
        
        # Execute the raw SQL query with the provided date
        result = db.execute(text(query), {"created_date": created_date})
        
        # Convert the result into a list of dictionaries
        rows = result.mappings().all()
        
        # Return the results mapped to the SalesSchema
        return [NBSchema(**row) for row in rows]
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
