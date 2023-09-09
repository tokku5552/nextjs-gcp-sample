"use client";

import { useGetTodos } from "@/hooks/useGetTodos";
import { css } from "@/styled-system/css";
import { hstack } from "@/styled-system/patterns";
import { useForm } from "react-hook-form";

export default function TodoForm() {
  const { handleSubmit, register, reset } = useForm<{ title: string }>();
  const { mutate } = useGetTodos();

  return (
    <form
      onSubmit={handleSubmit(async (value) => {
        const res = await fetch("/api/todo", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(value),
        });
        console.log(res);
        reset();
        mutate();
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
  );
}
