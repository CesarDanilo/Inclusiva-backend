import { prisma } from "../config/prisma.js";
import type { CreateUserDTO, IUserRepository } from "../interfaces/user/IUserRepository.js";
import type { User } from "@prisma/client";

export class PrismaUsersRepository implements IUserRepository {
  async create(data: CreateUserDTO): Promise<User> {
    const user = await prisma.user.create({
      data,
    });

    return user;
  }

  async findByEmail(email: string): Promise<User | null> {
    const user = await prisma.user.findUnique({
      where: { email },
    });

    return user;
  }

  async findById(id: string): Promise<User | null> {
    const user = await prisma.user.findUnique({
      where: { id },
    });

    return user;
  }
}
