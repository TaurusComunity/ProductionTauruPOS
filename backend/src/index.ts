import express from "express";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("¡Servidor funcionando! 🚀");
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Servidor en http://localhost:${PORT}`));
