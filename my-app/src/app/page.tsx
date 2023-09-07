"use client";

import { css } from "@/styled-system/css";
import { vstack, hstack } from "@/styled-system/patterns";
import { Todo } from "@prisma/client";
import Link from "next/link";
import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";

export default function Home() {
  const [todos, setTodos] = useState<Todo[]>([]);
  const { handleSubmit, register, formState } = useForm<{ title: string }>();
  useEffect(() => {
    (async () => {
      const res = await fetch("/api/todo", {
        method: "GET",
        headers: { "Content-Type": "application/json" },
      });
      const data = await res.json();

      setTodos(data.todos);
    })();
  }, []);

  return (
    <main>
      <div
        className={css({
          fontSize: "2xl",
          fontWeight: "bold",
          alignItems: "center",
        })}
      >
        Todo App
      </div>

      <div className={vstack({ padding: "8" })}>
        <form
          onSubmit={handleSubmit(async (value) => {
            const res = await fetch("/api/todo", {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify(value),
            });
            console.log(res);
          })}
        >
          <div className={hstack({})}>
            <input
              type="text"
              className={css({
                height: "40px",
                width: "100%",
                padding: "8px",
                borderRadius: "4px",
                border: "none",
                boxShadow: "0 0 0 1px rgba(0,0,0,0.1)",
              })}
              placeholder="Enter your todo"
              {...register("title")}
            />
            <button
              type="submit"
              className={css({
                display: "flex",
                borderWidth: "1px",
                borderColor: "gray",
                color: "gray",
                padding: "8px",
                fontSize: "12px",
              })}
            >
              Add
            </button>
          </div>
        </form>

        {!formState.isLoading &&
          todos &&
          todos.map((todo) => (
            <div key={todo.id}>
              <Link href={`/todo/${todo.id}`}>{todo.title}</Link>
            </div>
          ))}
      </div>
    </main>
  );
}
