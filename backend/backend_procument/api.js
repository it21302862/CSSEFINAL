const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const siteManagerRoutes = require("./routes/siteManagerRoutes");
const supplierRoutes = require("./routes/supplierRoutes");
const requestRoutes = require("./routes/requestRoutes");
const siteRoutes = require("./routes/siteRoutes");
const swaggerSpecs = require("./swagger");
const swaggerUi = require("swagger-ui-express");
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(cors());

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpecs));

// Connect to MongoDB
mongoose.connect(
  "mongodb+srv://itpprojectdb:Pass123itp@itp.jet5d6f.mongodb.net/test",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  }
);
const db = mongoose.connection;

db.on("error", console.error.bind(console, "MongoDB connection error:"));
db.once("open", () => {
  console.log("Connected to MongoDB");
});

// Routes
app.use("/api", siteManagerRoutes);
app.use("/api", supplierRoutes);
app.use("/api", requestRoutes);
app.use("/api", siteRoutes);
// 404 Route
app.use((req, res) => {
  res.status(404).json({ error: "Not Found" });
});

// Error Handling Middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: "Internal Server Error" });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

module.exports = app;
