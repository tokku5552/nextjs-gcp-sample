"use client";

import { useGetTodos } from "@/hooks/useGetTodos";

import Link from "next/link";

export default function TodoList() {
  const { todos, isLoading, error } = useGetTodos();

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>{error.message}</div>;
  return (
    <>
      {todos &&
        todos.map((todo) => (
          <div key={todo.id}>
            <Link href={`/todo/${todo.id}`}>{todo.title}</Link>
          </div>
        ))}
    </>
  );
}
