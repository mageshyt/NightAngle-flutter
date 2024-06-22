import cloudinary
import cloudinary.uploader
import cloudinary.api
from cloudinary import CloudinaryImage
import os

cloudinary.config(
    cloud_name = "dbmfl80ia",
    api_key = os.getenv("CLOUDINARY_API_KEY"),
    api_secret = os.getenv("CLOUDINARY_API_SECRET"), # Click 'View Credentials' below to copy your API secret
    secure=True
)

IMAGE_DIMENSIONS = {
    "thumbnail": {
        "width": 300,
        "height": 300
    }
}
def upload_image(file):
    transformedImage= CloudinaryImage(file).image(transformation=[
        {"width": IMAGE_DIMENSIONS["thumbnail"]["width"], "height": IMAGE_DIMENSIONS["thumbnail"]["height"], "crop": "fill"}
    ])

    upload_response = cloudinary.uploader.upload(file)

    return upload_response

