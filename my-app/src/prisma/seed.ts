import { parse } from "csv-parse/sync";
import fs from "fs";
import { resolve } from "path";
import { prisma } from "./";

const todos = () => {
  const csv = resolve("src/prisma/fixtures/todo.csv");
  const data = fs.readFileSync(csv);
  const records = parse(data);
  return records.map((record: string[]) =>
    prisma.todo.create({
      data: {
        title: record[0],
        description: record[1],
      },
    })
  );
};

async function main() {
  await prisma.$transaction([...todos()]);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
