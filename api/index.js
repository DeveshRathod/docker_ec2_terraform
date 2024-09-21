import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import connectionDB from "./database/connection.js";
import userRoutes from "./routes/user.routes.js";
import adminRoutes from "./routes/admin.routes.js";
import productRoutes from "./routes/product.routes.js";
import paymentRoute from "./routes/payment.routes.js";
import path from "path";

// configurations
const app = express();
app.use(express.json());
app.use(cors());
dotenv.config();
const __dirname = path.resolve();

// connection to DB
connectionDB();

app.listen(4000, () => {
  console.log("Server Started");
});

// health check route
app.get("/health", (req, res) => {
  res.status(200).json({ status: "UP" });
});

// routes
app.use("/api/user", userRoutes);
app.use("/api/admin", adminRoutes);
app.use("/api/products", productRoutes);
app.use("/api/payment", paymentRoute);

app.use(express.static(path.join(__dirname, "/client/dist")));
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "client", "dist", "index.html"));
});
