import bcrypt
import jwt
import os

from fastapi import APIRouter, HTTPException, status, Depends

from ..dependencies import prisma
from ..middleware.auth_middleware import auth_middleware
from ..schema.user_login import UserLogin
from ..schema.user_create import UserCreate

router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
    responses={404: {"description": "Not found"}},
)



def verify_password(plain_password, hashed_password):
    return bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))


# auth_scheme = HTTPBearer()

@router.get('/me')
async def me(user=Depends(auth_middleware)):
    """
    Me endpoint for user authentication.
    """
    return user

@router.post('/login')
async def login(user: UserLogin):
    """
    Login endpoint for user authentication.
    """
    is_exist_user = await prisma.user.find_unique(where={"email": user.email});

    if not is_exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")

    if not verify_password(user.password, is_exist_user.password):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect password")
    # create a token
    print(is_exist_user.id ,os.getenv("JWT_SECRET"))
    token = jwt.encode({"id": str(is_exist_user.id)}, os.getenv("JWT_SECRET"), algorithm="HS256")

    return {"token": token, "user": is_exist_user}


@router.post('/register', status_code=status.HTTP_201_CREATED)
async def register(user: UserCreate):
    """
    Register endpoint for creating a new user.
    """
    is_exist_user = await prisma.user.find_unique(where={"email": user.email})
    if is_exist_user:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Email already exists")

    hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    user_db = await prisma.user.create(
        data={
            "name": user.name,
            "email": user.email,
            "password": hashed_password,
        },
    )


    return user_db
