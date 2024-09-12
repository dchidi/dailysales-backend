from fastapi import APIRouter
from app.api.v1.endpoints import claims, sales, nb

# , users

router = APIRouter()

# Include version 1 endpoints
router.include_router(nb.router, prefix="/daily_sales", tags=["sales"])

router.include_router(claims.router, prefix="/claims", tags=["reports"])
router.include_router(sales.router, prefix="/sales", tags=["sales"])


