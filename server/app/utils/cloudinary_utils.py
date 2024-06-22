import cloudinary
import cloudinary.uploader
import cloudinary.api
from cloudinary import CloudinaryImage
import os

cloudinary.config(
    cloud_name="dbmfl80ia",
    api_key=os.getenv("CLOUDINARY_API_KEY"),
    api_secret=os.getenv("CLOUDINARY_API_SECRET"),  # Click 'View Credentials' below to copy your API secret
    secure=True
)

IMAGE_DIMENSIONS = {
    "thumbnail": {
        "width": 300,
        "height": 300
    }
}


def upload_image(file, file_id):
    upload_response = cloudinary.uploader.upload(file, resource_type="image", folder=f"thumbnail/{file_id}")

    return upload_response

def upload_audio(file, file_id):
    upload_response = cloudinary.uploader.upload(file, resource_type="auto", folder=f"audio/{file_id}")

    return upload_response


def download_file(file):
    url= cloudinary.utils.private_download_url("audio/2fabd0ed-ad82-4512-a0a0-ced76560ee41/vzj4gjvn9smscioekwey.mp3",format="MP3")
    print(url)
    """
    cloudinary.utils.private_download_url('sample', 'jpg') 
                                                                                              
    """

    return "Teasting"