from fastapi import FastAPI
import uvicorn

from routers import auth

app = FastAPI()


app.include_router(auth.router)

@app.get("/")
async def root():
    return {"message": "Hello Bigger Applications!"}


if __name__ == "__main__":
    uvicorn.run("main:app", port=5000, log_level="info")