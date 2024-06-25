/*
  Warnings:

  - Added the required column `updatedAt` to the `Songs` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Songs" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateTable
CREATE TABLE "Playlist" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Playlist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PlaylistToSongs" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE INDEX "userId" ON "Playlist"("userId");

-- CreateIndex
CREATE INDEX "name" ON "Playlist"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_PlaylistToSongs_AB_unique" ON "_PlaylistToSongs"("A", "B");

-- CreateIndex
CREATE INDEX "_PlaylistToSongs_B_index" ON "_PlaylistToSongs"("B");

-- CreateIndex
CREATE INDEX "song_name" ON "Songs"("song_name");

-- CreateIndex
CREATE INDEX "email" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Playlist" ADD CONSTRAINT "Playlist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PlaylistToSongs" ADD CONSTRAINT "_PlaylistToSongs_A_fkey" FOREIGN KEY ("A") REFERENCES "Playlist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PlaylistToSongs" ADD CONSTRAINT "_PlaylistToSongs_B_fkey" FOREIGN KEY ("B") REFERENCES "Songs"("id") ON DELETE CASCADE ON UPDATE CASCADE;
