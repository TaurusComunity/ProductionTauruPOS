import './App.css'

function App() {

  return (
    <>
    <div className="h-screen flex flex-col justify-center items-center bg-bg-empty text-mono-blanco">
      <h1 className="text-4xl font-bold text-semaforo-verde">¡Hola, mundo! 🚀</h1>
      <p className="text-essentials-primary shadow px-3">Este es un texto en rojo pero no funciona el padding.</p>
      <button className="mt-10 bg-shopper-primary text-white rounded-md">
        Botón Shopper
      </button>
    </div>
    </>
  );
}

export default App
