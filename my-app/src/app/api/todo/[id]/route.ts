import { prisma } from "@/prisma";
import { NextResponse } from "next/server";

export async function GET(_: Request, { params }: { params: { id: string } }) {
  const id = Number(params.id);
  const todo = await prisma.todo.findUnique({ where: { id } });
  return NextResponse.json({ todo });
}
