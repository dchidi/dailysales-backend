from fastapi import APIRouter, Depends, HTTPException

router = APIRouter()

@router.get("/test")
def get_test():
    try:
        return "test route"
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
