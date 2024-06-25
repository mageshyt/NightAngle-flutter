from pydantic import BaseModel

class PlaylistCreate(BaseModel):
    name: str = "My Playlist"

class PlaylistUpdate(BaseModel):
    name: str = "My Playlist (updated)"