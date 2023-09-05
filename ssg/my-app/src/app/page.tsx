"use client";

import { Button } from "@/components";
import { css } from "@/styled-system/css";
import { vstack, hstack } from "@/styled-system/patterns";

export default function Home() {
  const onSubmit = (event: React.MouseEvent<HTMLButtonElement>) => {
    console.log("clicked!");
  };
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
        <div className={hstack({})}>
          <input placeholder="a" />
          <Button size="sm" type="default" onClick={onSubmit}>
            Click
          </Button>
        </div>
        <div>a</div>
        <div>a</div>
      </div>
    </main>
  );
}
