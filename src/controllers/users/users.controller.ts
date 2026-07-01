import type { Request, Response } from "express";
import { UserServices } from "../../services/users/users.services.js";
import { PrismaUsersRepository } from "../../repository/PrismaUsersRepository.js";
import { passwordHashUtils } from "../../utils/passwordHash.utils.js";
import type { CreateUserDTO } from "../../interfaces/user/IUserRepository.js";

export class UserController {
  async getUser(req: Request, res: Response) {
    const userRepository = new PrismaUsersRepository();
    try {
      const userServices = new UserServices(userRepository);
      const user = await userServices.findUserById(req.params.id as string);
      res.status(200).json(user);
    } catch (error) {
      res.status(500).json({
        message: "Error fetching user",
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }

  async createUser(req: Request, res: Response) {
    const userRepository = new PrismaUsersRepository();
    try {
      const userServices = new UserServices(userRepository);
      const emailExists = await userServices.findUserByEmail(req.body.email);

      if (emailExists) {
        return res.status(400).json({ message: "Email already exists" });
      }

      const passwordhash = await passwordHashUtils(req.body.passwordHash);

      const userData: CreateUserDTO = { ...req.body, passwordHash: passwordhash };

      const user = await userServices.createUser(userData);
      res.status(201).json(user);
    } catch (error) {
      res.status(500).json({
        message: "Error creating user",
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }
}
