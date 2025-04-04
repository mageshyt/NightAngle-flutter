from fastapi import FastAPI
import uvicorn
from dotenv import load_dotenv
from fastapi.responses import HTMLResponse

from .routers import auth, song, playlist

from .dependencies import prisma

app = FastAPI()

load_dotenv()

app.include_router(auth.router)
app.include_router(song.router)
app.include_router(playlist.router)


@app.get("/", response_class=HTMLResponse)
async def root():
    return """
    <!DOCTYPE html>
    <html>
        <head>
            <title>NightAngle - Music Streaming App</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                    color: #333;
                    max-width: 800px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #f5f5f5;
                }
                header {
                    background-color: #3a0ca3;
                    color: white;
                    padding: 20px;
                    border-radius: 5px;
                    margin-bottom: 20px;
                }
                h1 {
                    margin: 0;
                }
                .card {
                    background-color: white;
                    border-radius: 5px;
                    padding: 20px;
                    margin-bottom: 20px;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                }
                .endpoints {
                    background-color: #f0f0f0;
                    padding: 15px;
                    border-radius: 5px;
                    font-family: monospace;
                }
                footer {
                    text-align: center;
                    margin-top: 30px;
                    color: #666;
                }
            </style>
        </head>
        <body>
            <header>
                <h1>NightAngle Music API</h1>
                <p>A powerful backend for your music streaming application</p>
            </header>
            
            <div class="card">
                <h2>About the Project</h2>
                <p>NightAngle is a modern music streaming platform built with Flutter and FastAPI. 
                This is the API server that powers the mobile application, providing authentication, 
                music streaming, and playlist management capabilities.</p>
            </div>
            
            <div class="card">
                <h2>Available Endpoints</h2>
                <div class="endpoints">
                    <p>• /auth - User authentication and management</p>
                    <p>• /song - Music streaming and song management</p>
                    <p>• /playlist - User playlist operations</p>
                </div>
                <p>For complete API documentation, visit <a href="/docs">/docs</a> or <a href="/redoc">/redoc</a></p>
            </div>
            
            <div class="card">
                <h2>Tech Stack</h2>
                <p>• <strong>Backend:</strong> FastAPI with Python</p>
                <p>• <strong>Database:</strong> Prisma ORM</p>
                <p>• <strong>Frontend:</strong> Flutter</p>
            </div>
            
            <footer>
                <p>NightAngle Music Streaming - &copy; 2024</p>
            </footer>
        </body>
    </html>
    """


@app.on_event("startup")
async def startup():
    await prisma.connect()


@app.on_event("shutdown")
async def shutdown():
    await prisma.disconnect()


if __name__ == "__main__":
    uvicorn.run("main:app", port=5000, log_level="info", reload=True)
