import { Todo } from "@prisma/client";
import useSWR from "swr";

export const useGetTodos = () => {
  const fetcher = (url: string) =>
    fetch(url, {
      method: "GET",
      headers: { "Content-Type": "application/json" },
    }).then((res) => res.json());
  const { data, isLoading, error, mutate } = useSWR("/api/todo", fetcher);
  const todos = data?.todos as Todo[];
  return { todos, isLoading, error, mutate };
};
