import { prisma } from "@/prisma";
import { NextApiRequest } from "next";
import { NextResponse } from "next/server";

export async function GET(request: NextApiRequest) {
  const id = parseInt(request.query.id as string);
  const todo = await prisma.todo.findUnique({ where: { id } });
  return NextResponse.json({ todo });
}
