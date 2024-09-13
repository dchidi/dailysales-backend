from pydantic import BaseModel
from typing import Literal, Optional
from datetime import date

class NBSchema(BaseModel):
    CreatedDate: Optional[date]=None
    Country: Optional[Literal['AU-FIT','AU-UTS']]
    PolicyReceivedMethodId: Optional[Literal['Phone', 'Web', 'Other']]
    Sales: Optional[int]

    class Config:
        from_attributes = True
