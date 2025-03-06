from fastapi import APIRouter, HTTPException, status, Depends, UploadFile, File, Form,Query
import uuid

from ..middleware.auth_middleware import auth_middleware
from ..utils.cloudinary_utils import upload_image, upload_audio, download_file
from ..dependencies import prisma
from ..schema.fav_song import FavoriteSong

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


@router.get('/me')
async def get_current_user_songs(auth_user=Depends(auth_middleware)):
    """
    Get all songs.
    """
    try:

        user_songs = await prisma.songs.find_many(where={"userId": auth_user.id})

        return user_songs

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))


@router.get('/favorite')
async def get_favorite_songs(auth_details=Depends(auth_middleware)):
    """
    Get all favorite songs of user.
    """
    try:
        _favorite_songs = await prisma.favorite.find_many(where={"userId": auth_details.id},include={"song":True})

        return {"favorite_songs": _favorite_songs}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))


@router.put('/favorite/{songId}')
async def favorite_song(songId: str,
                        auth_details=Depends(auth_middleware)
                        ):
    """
    Favorite a song.
    """
    try:

        # check if song already favorite
        _fav_song = await prisma.favorite.find_first(where={"userId": auth_details.id, "songId": songId})
        print("fav_song", _fav_song)
        # if song is already favorite, then remove it from favorite
        if _fav_song is not None:
            print("removing song from favorite")
            removed = await prisma.favorite.delete(
                where={
                    "id": _fav_song.id,
                    "userId": auth_details.id,
                })

            print(removed)

            if removed is None:
                raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Song not found in favorite")

            await prisma.songs.update(
                where={"id": songId},
                data={
                    "favoriteCount": {
                        "decrement": 1
                    }
                }
            )

            return {"message": False}
        else:
            # if song is not favorite, then add it to favorite

            added = await prisma.favorite.create(
                {
                    "userId": auth_details.id,
                    "songId": songId,
                }
            )

            print(added)

            # increment favorite count
            await prisma.songs.update(
                where={"id": songId},
                data={
                    "favoriteCount": {
                        "increment": 1
                    }
                }
            )

            return {"message": True}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))


@router.get('/top-favorite')
async def get_top_favorite_songs():
    """
    Get top favorite songs.
    """
    try:
        _top_favorite_songs = await prisma.songs.find_many(order={"favoriteCount": "desc"}, take=5)

        return {"top_songs": _top_favorite_songs}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))


@router.get('/user/{user_id}')
async def get_user_songs(user_id: str):
    """
    Get all songs.
    """
    try:

        user_songs = await prisma.songs.find_many(where={"userId": user_id})

        print(user_songs)

        return user_songs

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))

@router.get('/search')
async def search_songs(query: str = Query(..., min_length=1)):
    """
    Search songs.
    """
    try:
        songs = await prisma.songs.find_many(
            where={
                'OR': [
                    {'song_name': {'contains': query, 'mode': 'insensitive'}},
                    {'artist': {'contains': query, 'mode': 'insensitive'}},

                ]

            }
        )
        if not songs:
            return []
        return songs
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post('/upload')
async def create_song(song: UploadFile = File(...),
                      artist: str = Form(...),
                      song_name: str = Form(...),
                      hex_color: str = Form(...),
                      auth_user=Depends(auth_middleware)):
    print(auth_user.id)


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


@router.post('/', status_code=status.HTTP_201_CREATED)
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
        print(thumbnail.filename)
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
                "user": {
                    "connect": {"id": auth_user.id}
                }
            }
        )

        return {"song": _song}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))


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
        songUrl = download_file(song_id)
        return {"download_url": songUrl}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))
