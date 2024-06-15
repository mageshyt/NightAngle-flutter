from typing import Annotated

from fastapi import Header, HTTPException
from prisma import Prisma




prisma = Prisma()  # Create a new instance of Prisma