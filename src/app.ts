import express from "express";
import cors from "cors";

import userRoutes from "./routes/user.routes.js";

const app = express();

app.use(express.json());
app.use(
  cors({
    origin: process.env.CORS_ALLOWED_ORIGINS?.split(",") || "*",
    credentials: true,
  }),
);

app.use("/api", userRoutes);

export { app };
