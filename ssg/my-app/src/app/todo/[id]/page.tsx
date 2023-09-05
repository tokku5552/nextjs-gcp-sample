import { prisma } from "@/prisma";
import Link from "next/link";

const getTodo = async (id: string) => {
  const todo = await prisma.todo.findUnique({ where: { id: parseInt(id) } });
  return todo;
};

export default async function Todo({ params }: { params: { id: string } }) {
  const { id } = params;
  const todo = await getTodo(id);
  return (
    <>
      <h1>Todo detail</h1>
      <p>id: {id}</p>
      <p>title: {todo?.title}</p>
      <p>description: {todo?.description}</p>
      <Link href="/">戻る</Link>
    </>
  );
}
