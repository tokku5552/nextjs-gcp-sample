import { cva } from "@/styled-system/css";

const button = cva({
  base: {
    display: "flex",
    borderWidth: "1px",
    borderColor: "gray",
  },
  variants: {
    type: {
      default: { color: "gray" },
      danger: { color: "red", borderColor: "red" },
    },
    size: {
      sm: { padding: "8px", fontSize: "12px" },
      lg: { padding: "16px", fontSize: "16px" },
    },
  },
  defaultVariants: {
    type: "default",
  },
});

export interface ButtonProps {
  children: React.ReactNode;
  size?: "sm" | "lg";
  type?: "default" | "danger";
  onClick?: (event: React.MouseEvent<HTMLButtonElement>) => void;
}

export default function Button({ children, size, type, onClick }: ButtonProps) {
  return (
    <button type="button" className={button({ size, type })} onClick={onClick}>
      {children}
    </button>
  );
}
