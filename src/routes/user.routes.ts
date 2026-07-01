import { Router } from "express";
import { UserController } from "../controllers/users/users.controller.js";

const router = Router();
const userController = new UserController();

router.get("/user/:id", userController.getUser);
router.post("/user", userController.createUser);

export default router;
