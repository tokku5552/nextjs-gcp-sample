import { prisma } from "@/prisma";
import { NextApiRequest } from "next";
import { NextResponse } from "next/server";

export async function GET(_: NextApiRequest) {
  const todos = await prisma.todo.findMany();
  return NextResponse.json({ todos });
}

export async function POST(request: Request) {
  const body = await request.json();
  const todo = await prisma.todo.create({
    data: {
      title: body.title,
      description: "",
      status: false,
    },
  });
  return NextResponse.json({ todo });
}

export const config = {
  api: {
    bodyParser: true,
  },
  dynamic: "force-dynamic",
};
