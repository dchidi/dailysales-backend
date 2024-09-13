from fastapi import APIRouter
from app.utils.previous_year_day import calculate_dates

router = APIRouter()

@router.get("/test")
async def test():
    return calculate_dates("2024-09-14")
