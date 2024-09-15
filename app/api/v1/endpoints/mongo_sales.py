from fastapi import APIRouter, Query, HTTPException
from typing import Dict, List
from datetime import date
from app.schemas.mongodb.SalesMongoSchema import SalesResponseSchema
from app.db.mongodb import get_mongo_db
from app.utils.previous_year_day import calculate_dates


router = APIRouter()

async def fetch_sales_data(collection, start_datetime, end_datetime):
    pipeline = [
        {
            "$match": {
                "created_at": {
                    "$gte": start_datetime,
                    "$lt": end_datetime
                }
            }
        },
        {
            "$project": {
                "date": {"$substr": ["$created_at", 0, 10]},  # Extract date part from ISO string
                "sales_count": 1  # Keep the sales_count field
            }
        },
        {
            "$group": {
                "_id": "$date",  # Group by the extracted date
                "total_sales": {"$sum": "$sales_count"}  # Sum the sales_count field
            }
        },
        {
            "$sort": {"_id": 1}  # Sort by date in ascending order
        }
    ]
    
    cursor = collection.aggregate(pipeline)
    return [{item['_id']: item['total_sales']} for item in await cursor.to_list(length=None)]
    

@router.get("/report_sales")
async def get_item(
    start_date: date = Query(..., description="Start date for filtering results"),
    end_date: date = Query(..., description="End date for filtering results. End date is not included in the result set")
) -> Dict[str, List[Dict[str, int]]]:
    db = await get_mongo_db()
    collection = db.Sales

    # Convert start_date and end_date to ISO 8601 strings for MongoDB queries
    start_datetime = start_date.isoformat()
    end_datetime = end_date.isoformat()

    # Get previous year records
    last_year_start = calculate_dates(start_date)
    last_year_end = calculate_dates(end_date)

    try:
        # Fetch aggregated sales data for the current year and previous year
        current_year_sales = await fetch_sales_data(collection, start_datetime, end_datetime)
        prev_year_sales = await fetch_sales_data(collection, last_year_start, last_year_end)

        # Format the response with the year as the key
        current_year_key = start_date.year
        prev_year_key = current_year_key - 1

        return {str(current_year_key): current_year_sales, str(prev_year_key): prev_year_sales}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {e}")

