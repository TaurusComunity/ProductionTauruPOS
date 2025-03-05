/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#1E3A8A",
        secondary: "#9333EA",
        accent: "#FACC15",
        background: "#F3F4F6",
        text: "#111827",
      },
    },
  },
  plugins: [],
};
