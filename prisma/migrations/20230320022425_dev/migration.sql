/*
  Warnings:

  - You are about to drop the column `image` on the `ColorSystem` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ColorSystem" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "imageURL" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "authorId" INTEGER NOT NULL,
    CONSTRAINT "ColorSystem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ColorSystem" ("authorId", "createdAt", "description", "id", "name", "updatedAt") SELECT "authorId", "createdAt", "description", "id", "name", "updatedAt" FROM "ColorSystem";
DROP TABLE "ColorSystem";
ALTER TABLE "new_ColorSystem" RENAME TO "ColorSystem";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
