import bcrypt
from fastapi import APIRouter, HTTPException, status

from ..dependencies import prisma
from ..schema.user_login import UserLogin
from ..schema.user_create import UserCreate

router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
    responses={404: {"description": "Not found"}},
)


def verify_password(plain_password, hashed_password):
    return bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))


@router.get("/", tags=["Auth"])
async def read_root():
    """
    Root endpoint for authentication.
    """
    return {"message": "Hello World"}


@router.post('/login')
async def login(user: UserLogin):
    """
    Login endpoint for user authentication.
    """
    is_exist_user = await prisma.user.find_unique(where={"email": user.email})
    if not is_exist_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")

    if not verify_password(user.password, is_exist_user.password):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect password")

    # Here you would generate and return a token for the user
    return {"message": "Login successful"}


@router.post('/register', response_model=UserCreate)
async def register(user: UserCreate):
    """
    Register endpoint for creating a new user.
    """
    is_exist_user = await prisma.user.find_unique(where={"email": user.email})
    if is_exist_user:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Email already exists")

    hashed_password = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())

    new_user = await prisma.user.create(
        data={
            "name": user.name,
            "email": user.email,
            "password": hashed_password,
        },
    )

    return new_user
