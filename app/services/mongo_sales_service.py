from fastapi import HTTPException
from pymongo.errors import ServerSelectionTimeoutError
from typing import List
from app.schemas.mongodb.SalesMongoSchema import SalesSchema
from app.db.mongodb import get_mongo_db

class MongoSalesService:
    @classmethod
    async def insert_sales(cls, items: List[SalesSchema]) -> dict:
        db = await get_mongo_db()  # Retrieve the database client
        collection = db.Sales
        
        try:
            # Insert items into the collection
            result = await collection.insert_many([item.dict() for item in items])
            # Return success message with the count of inserted documents
            return {"msg": "Sales inserted successfully.", "count": len(result.inserted_ids)}
        
        except ServerSelectionTimeoutError as e:
            # Handle MongoDB server connection errors
            raise HTTPException(status_code=500, detail=f"Failed to connect to MongoDB: {e}")
        except Exception as e:
            # Handle other exceptions
            raise HTTPException(status_code=500, detail=f"An error occurred: {e}")
