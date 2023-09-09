import TodoForm from "@/components/TodoForm";
import TodoList from "@/components/TodoList";

import { css } from "@/styled-system/css";
import { vstack } from "@/styled-system/patterns";

export default function Home() {
  return (
    <main>
      <div
        className={css({
          fontSize: "2xl",
          fontWeight: "bold",
          textAlign: "center",
        })}
      >
        Todo App
      </div>

      <div className={vstack({ padding: "8" })}>
        <TodoForm /> {/* Client Component */}
        <TodoList /> {/* Client Component */}
      </div>
    </main>
  );
}
