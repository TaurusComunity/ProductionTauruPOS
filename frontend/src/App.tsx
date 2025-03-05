import { useEffect, useState } from "react";

function App() {
  const [message, setMessage] = useState("");

  useEffect(() => {
    fetch("http://localhost:5000")
      .then((res) => res.json())
      .then((data) => setMessage(data.message))
      .catch((error) => console.error("Error:", error));
  }, []);

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-background text-text">
      <h1 className="text-4xl font-bold text-primary">¡TailwindCSS funciona en TypeScript! 🎉</h1>
      <button className="mt-4 px-4 py-2 bg-secondary text-white rounded-lg">
        ¡Probar!
      </button>
      <p>{message}</p>
    </div>
  );
}

export default App;
