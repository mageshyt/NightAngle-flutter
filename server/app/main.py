from fastapi import FastAPI
import uvicorn

from .routers import auth
from .dependencies import prisma

app = FastAPI()


app.include_router(auth.router)

@app.get("/")
async def root():
    return {"message": "Hello Bigger Applications!"}

@app.on_event("startup")
async def startup():
    await prisma.connect()
@app.on_event("shutdown")
async def shutdown():
    await prisma.disconnect()


if __name__ == "__main__":
    uvicorn.run("main:app", port=5000, log_level="info", reload=True)