import { PrismaClient } from "@prisma/client";
import colorSystemData from "../src/server/color_systems.json";
import { v4 as uuidv4 } from "uuid";

interface ColorList {
  names: string[];
  values: string[];
}

interface ColorSystem {
  name: string;
  imageURL: string;
  uuid: string;
  description: string;
  colors: ColorList;
}

interface ColorSystemJSON {
  books: ColorSystem[];
}

const colorSystemJson = colorSystemData as unknown as ColorSystemJSON;

const prisma = new PrismaClient();

async function main() {
  const user = await prisma.user.findUnique({
    where: { email: "hello@swansondigitalarts.com" },
  });

  for (const book of colorSystemJson.books) {
    console.log(book);

    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-call
    await prisma.colorSystem.create({
      data: {
        uuid: uuidv4(),
        name: book.name,
        imageURL: book.imageURL,
        description: book.description,
        author: { connect: { id: user!.id } },
        colors: {
          create: book.colors.names.map((color, index) => ({
            name: color,
            hexValue: book.colors.values[index] || "#null",
          })),
        },
      },
    });
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
