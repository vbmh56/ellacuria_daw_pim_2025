const express = require("express");
const app = express();
const port = 3000;

// Middleware para procesar JSON
app.use(express.json());

// Endpoint de prueba
app.get("/api/health", (req, res) => {
  res.json({ estado: "ok" });
});

app.listen(port, () => {
  console.log(`Servidor funcionando en http://localhost:${port}`);
});

app.get("/", (req, res) => {
  res.send("API de reserva de aulas funcionando");
});git 