import './App.css'

function App() {

  return (
    <>
    <div className="h-screen flex flex-col justify-center items-center bg-bg-empty text-mono-blanco">
      <h1 className="text-4xl font-bold text-semaforo-verde">¡Hola, mundo! 🚀</h1>
      <p className="text-semaforo-rojo shadow p-2">Este es un texto en rojo.</p>
      <button className="px-4 py-2 mt-4 bg-shopper-primary text-white rounded-md">
        Botón Shopper
      </button>
    </div>
    </>
  );
}

export default App
