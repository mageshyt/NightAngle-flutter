from fastapi import FastAPI
import uvicorn
from dotenv import load_dotenv


from .routers import auth, song,playlist

from .dependencies import prisma

app = FastAPI()

load_dotenv()

app.include_router(auth.router)
app.include_router(song.router)
app.include_router(playlist.router)


@app.on_event("startup")
async def startup():
    await prisma.connect()
@app.on_event("shutdown")
async def shutdown():
    await prisma.disconnect()


if __name__ == "__main__":
    uvicorn.run("main:app", port=5000, log_level="info", reload=True)