from pydantic import BaseModel

class UserCreate(BaseModel):
    name: str = "Magesh"
    email: str  ="magesh@gmail.com"
    password: str = "Password@123"