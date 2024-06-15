from fastapi import HTTPException, Header
import jwt
import os

from ..dependencies import prisma


async def auth_middleware(x_auth_token=Header()):
    try:
        # get the user token from the headers
        if not x_auth_token:
            raise HTTPException(401, 'No auth token, access denied!')
        # decode the token
        print(">>", os.getenv('JWT_SECRET'))
        verified_token = jwt.decode(x_auth_token, os.getenv('JWT_SECRET'), ['HS256'])

        print(">>",verified_token)
        if not verified_token:
            raise HTTPException(401, 'Token verification failed, authorization denied!')
        # get the id from the token
        uid = verified_token.get('id')
        # get the user from the database
        user = await prisma.user.find_unique(where={'id': uid},)
        if not user:
            raise HTTPException(401, 'User not found, authorization denied!')
        # remove the password from the user
        return user
        # postgres database get the user info
    except jwt.PyJWTError:
        raise HTTPException(401, 'Token is not valid, authorization failed.')
