from fastapi import APIRouter
from typing import List
from app.schemas.mongodb.SalesMongoSchema import SalesResponseSchema
from app.db.mongodb import get_mongo_db
from app.utils.previous_year_day import calculate_dates


router = APIRouter()


@router.get("/report_sales")
async def get_item() -> List[SalesResponseSchema]:
    db = await get_mongo_db()
    collection = db.Sales
    items = await collection.find().to_list(length=100)
    return [SalesResponseSchema(**item) for item in items]

# async def update_item(item_id: str, item: ItemCreateSchema) -> ItemResponseSchema:
#     await collection.update_one({"_id": ObjectId(item_id)}, {"$set": item.dict()})
#     updated_item = await collection.find_one({"_id": ObjectId(item_id)})
#     return ItemResponseSchema(**updated_item)

# async def delete_item(item_id: str) -> dict:
#     result = await collection.delete_one({"_id": ObjectId(item_id)})
#     if result.deleted_count:
#         return {"status": "success"}
#     raise HTTPException(status_code=404, detail="Item not found")

# async def get_all_items() -> List[ItemResponseSchema]:
    # items = await collection.find().to_list(length=100)
    # return [ItemResponseSchema(**item) for item in items]
