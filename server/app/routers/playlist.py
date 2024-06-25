import bcrypt
import jwt
import os

from fastapi import APIRouter, HTTPException, status, Depends

from ..dependencies import prisma
from ..middleware.auth_middleware import auth_middleware
from ..schema.playlist import PlaylistCreate, PlaylistUpdate

router = APIRouter(
    prefix="/playlist",
    tags=["Playlist"],
    responses={404: {"description": "Not found"}},
)


@router.get('/')
async def get_playlists():
    """
    Get all playlists.
    """
    playlists = await prisma.playlist.find_many(
        include={"songs": True, "user": True}
    )
    return playlists


@router.get('/{id}')
async def get_playlist(id: str):
    """
    Get a playlist by id.
    """
    playlist = await prisma.playlist.find_unique(where={"id": id}, include={"songs": True})
    return playlist


@router.post('/{id}/add-song')
async def add_song_to_playlist(id: str, song_id: str):
    """
    Add a song to a playlist by id.
    """
    try:
        playlist = await prisma.playlist.update(
            where={"id": id},
            data={"songs": {"connect": {"id": song_id}} },
            include={"songs": True}
        )
        return playlist
    except Exception as e:
        print(e)
        raise HTTPException(status_code=404, detail="Something went wrong")


@router.delete('/{id}/remove-song')
async def remove_song_from_playlist(id: str, song_id: str):
    """
    Remove a song from a playlist by id.
    ve to next tab ve to next tab
    """
    try:
        playlist = await prisma.playlist.update(
            where={"id": id},
            data={"songs": {"disconnect": {"id": song_id}}},
            include={"songs": True}
        )
        return playlist
    except Exception as e:
        print(e)
        raise HTTPException(status_code=404, detail="Something went wrong")


@router.post('/')
async def create_playlist(name: PlaylistCreate, user=Depends(auth_middleware)):
    """
    Create a new playlist.
    """

    try:
        print("name", name)
        playlist = await prisma.playlist.create(
                data= {
                    "name": name.name,
                    "user": {"connect": {"id": user.id}}
                }
        )
        return playlist
    except Exception as e:
        print(e)
        raise HTTPException(status_code=404, detail="Something went wrong")

@router.put('/{id}')
async def update_playlist(id: str, update: PlaylistUpdate):
    """
    Update a playlist by id.
    """
    try:
        # get the playlist by id
        playlist = await prisma.playlist.find_unique(where={"id": id})

        if not playlist:
            raise HTTPException(status_code=404, detail="Playlist not found")

        # update the playlist
        updated_playlist = await prisma.playlist.update(
            where={"id": id},
            data={"name": update.name}
        )

        return updated_playlist
    except Exception as e:
        raise HTTPException(status_code=404, detail="Playlist not found")


@router.delete('/{id}')
async def delete_playlist(id: str):
    """
    Delete a playlist by id.
    """
    try:
        # get the playlist by id
        playlist = await prisma.playlist.find_unique(where={"id": id})

        if not playlist:
            raise HTTPException(status_code=404, detail="Playlist not found")

        # delete the playlist
        await prisma.playlist.delete(where={"id": id})

        return {"message": "Playlist deleted successfully"}
    except Exception as e:
        raise HTTPException(status_code=404, detail="Playlist not found")
