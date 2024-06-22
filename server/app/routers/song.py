from fastapi import APIRouter, HTTPException, status, Depends, UploadFile, File, Form
import uuid

from ..middleware.auth_middleware import auth_middleware
from ..utils.cloudinary_utils import upload_image,upload_audio,download_file
from ..dependencies import prisma


router = APIRouter(
    prefix="/song",
    tags=["Song"],
    responses={
        404: {"description": "Not found"},
        401: {"description": "Unauthorized"},
        201: {"description": "Created"},
    }
)


@router.get('/')
async def get_songs():
    """
    Get all songs.
    """
    try:
        _songs = await prisma.songs.find_many()
        return {"songs": _songs}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))


@router.get('/{song_id}')
async def get_song(song_id: str):
    """
    Get a song by id.
    """
    try:
        _song = await prisma.songs.find_unique(where={"id": song_id})
        if _song is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Song not found")

        return {"song": _song}

    except Exception as e:
        print(e)
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))


@router.post('/')
async def create_song(song: UploadFile = File(...),
                      thumbnail: UploadFile = File(...),
                      artist: str = Form(...),
                      song_name: str = Form(...),
                      hex_color: str = Form(...),
                      auth_user=Depends(auth_middleware)):
    """
    Create a song.
    """
    try:
        # upload image
        songId = str(uuid.uuid4())
        thumbnail_url = upload_image(thumbnail.file, songId)
        song_url = upload_audio(song.file, songId)
        # create a song
        _song = await prisma.songs.create(
               {
               "id": songId,
                "song_name": song_name,
                "artist": artist,
                "hex_color": hex_color,
                "thumbnail_url": thumbnail_url["url"],
                "song_url": song_url["url"],
                   "userId":auth_user.id
            }
        )

        return { "song": _song}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_201_CREATED, detail=str(e))


@router.delete('/{song_id}')
async def delete_song(song_id: str, auth_user=Depends(auth_middleware)):
    """
    Delete a song.
    """
    try:
        _song = await prisma.songs.find_unique(where={"id": song_id})
        if _song is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="")

        if _song.userId != auth_user.id:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Unauthorized")

        await prisma.songs.delete(where={"id": song_id})

        return {"message": "Song deleted successfully"}

    except Exception as e:

        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))


@router.get('/download/{song_id}')
async def download_song(song_id: str):
    """
    Download a song.
    """
    try:
        _song = await prisma.songs.find_unique(where={"id": song_id})
        if _song is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Song not found")
        songUrl= download_file(song_id)
        return {"download_url":songUrl}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))
