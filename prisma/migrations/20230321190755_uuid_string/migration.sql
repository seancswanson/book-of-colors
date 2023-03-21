-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ColorSystem" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "imageURL" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "authorId" INTEGER NOT NULL,
    CONSTRAINT "ColorSystem_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_ColorSystem" ("authorId", "createdAt", "description", "id", "imageURL", "name", "updatedAt", "uuid") SELECT "authorId", "createdAt", "description", "id", "imageURL", "name", "updatedAt", "uuid" FROM "ColorSystem";
DROP TABLE "ColorSystem";
ALTER TABLE "new_ColorSystem" RENAME TO "ColorSystem";
CREATE UNIQUE INDEX "ColorSystem_uuid_key" ON "ColorSystem"("uuid");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
