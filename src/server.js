const express = require("express");
const path = require("path");

const app = express();

// Servir archivos estáticos desde la carpeta 'public'
app.use(express.static(path.join(__dirname, "../public")));

// Ruta para la página de inicio
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "../public/views/index.html"));
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
