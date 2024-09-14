from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from bson import ObjectId

class SalesSchema(BaseModel):
    created_at: datetime
    country: str
    receivedMethod: str
    sales_count: float
    product: str

class SalesResponseSchema(BaseModel):
    id: str
    created_at: datetime
    country: str
    receivedMethod: str
    sales_count: float
    product: Optional[str] = None

    class Config:
        # Ensure the `id` field is read as a string (not ObjectId)
         json_encoders = {
            ObjectId: lambda obj: str(obj)  # Convert ObjectId to string
        }