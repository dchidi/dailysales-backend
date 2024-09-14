from motor.motor_asyncio import AsyncIOMotorClient
from app.core.config import Settings

settings = Settings()
mongo_client = AsyncIOMotorClient(settings.mongo_url)
mongo_db = mongo_client.daily_sales_db


async def get_mongo_db():
    return mongo_db
