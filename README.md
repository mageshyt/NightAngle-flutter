# Night Angle

## Table of Contents

- [Overview](#overview)
- [Database Design](#database-design)
- [Features](#features)
- [Installation](#installation)
- [Screenshots](#screenshots)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [License](#license)
- [Resources](#resources)
- [Acknowledgments](#Acknowledgments)

## Overview

Night Angle is a music app where users can share their own music and listen to music uploaded by others. Users can favorite tracks, search for music by name or artist, and discover new music. The app follows the MVVM architecture and includes features such as image and music caching, and background play similar to premium features in Spotify.

## Database Design

The Night Angle app uses a PostgreSQL database with Prisma as the ORM. The schema is designed to efficiently handle user data, songs, playlists, and favorites. Here's an overview of the schema:

![Database Schema](/assets/nighangle.png)

Benefits of the Design

\_ **Efficiency**: Indexes on frequently searched fields (like email, song_name, userId) improve query performance

- **Flexibility**: The design supports complex queries and relationships, allowing for features like playlists and favorites.
- **Security**: Storing user passwords securely (assuming proper hashing) and using unique constraints on sensitive fields like email.

## Features

![Flow Chart](/assets/night-angle-flow.png)
The Night Angle app includes the following features:

- User authentication: Users can sign up and log in to the app
- Upload music: Users can upload their own music
- background play: Users can play music in the background
- Search: Users can search for music by name or artist
- Favorites: Users can favorite tracks
- Add to playlist: Upcoming feature
- Discover: Upcoming feature
- AI music generation: Upcoming feature

## Installation

_Prerequisites_

- FastAPI: Ensure you have Python installed. You can install FastAPI using pip:
- Flutter: Follow the official Flutter installation guide to set up Flutter on your machine.

```bash
pip install fastapi
```

- PostgreSQL: Set up a PostgreSQL database. You can use services like Heroku or install PostgreSQL locally.
- Prisma: Install Prisma CLI:

```bash
npm install -g prisma
```

_Steps_

1. the repository:

```bash
git clone https://github.com/mageshyt/night-angle.git
cd night-angle
```

2. up the Backend:

- Navigate to the backend directory:

```bash
cd backend
```

- Run docker-compose to start the PostgreSQL database:

```bash
docker-compose up -d
```

- Run the Prisma migration to create the database schema:

```bash
prisma migrate dev
```

- Start the FastAPI server:

```bash
uvicorn app.main:app --reload
```

3. up the Frontend:

- Navigate to the frontend directory:

```bash
cd frontend
```

- Install the dependencies:

```bash
flutter pub get
```

- Start the Flutter app:

```bash

flutter run
```

## Screenshots

<table>
  <tr>
    <td><img src="/assets/login.png" alt="Login" style="width: 100%;"></td>
    <td><img src="/assets/register.png" alt="Register" style="width: 100%;"></td>
  </tr>
  <tr>
    <td><img src="/assets/home.png" alt="Home" style="width: 100%;"></td>
    <td><img src="/assets/home-2.png" alt="Home 2" style="width: 100%;"></td>
  </tr>
  <tr>
    <td><img src="/assets/music-player.png" alt="Music Player" style="width: 100%;"></td>
    <td><img src="/assets/upload.png" alt="Upload" style="width: 100%;"></td>
  </tr>
  <tr>
    <td><img src="/assets/search.png" alt="Search" style="width: 100%;"></td>
  </tr>
</table>

## Technologies Used

- Frontend: Flutter
- Backend: FastAPI
- Database: PostgreSQL
- ORM: Prisma

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request if you have any ideas or suggestions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Resources

- [Prisma Python Docs](https://prisma-client-py.readthedocs.io/en/stable/)
- [FastAPI Docs](https://fastapi.tiangolo.com/)
- [Reactive Forms](https://medium.com/@erns70b/forms-in-flutter-have-never-been-so-easy-3b707c4236cf)
- [Flutter MVMM](https://medium.com/@codemax120/flutter-clean-architecture-mvvm-f8802e3df564)
- [Rivaan Ranawat](https://www.youtube.com/watch?v=CWvlOU2Y3Ik&t=35595s)

**Special Thanks to Rivaan for his inspiration and guidance.**

## Acknowledgments

- [Prisma](https://www.prisma.io/)
- [FastAPI](https://fastapi.tiangolo.com/)
- [Flutter](https://flutter.dev/)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)
