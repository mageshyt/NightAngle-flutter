from pydantic import BaseModel


class UserLogin(BaseModel):
    email: str = "magesh@gmail.com"
    password: str = "Password@123"