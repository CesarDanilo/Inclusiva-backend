import type { User } from "@prisma/client";

export interface CreateUserDTO {
  name: string;
  email: string;
  passwordHash: string;
  createdAt: Date;
}

export interface IUserRepository {
  create(data: CreateUserDTO): Promise<User>;

  findByEmail(email: string): Promise<User | null>;

  findById(id: string): Promise<User | null>;
}
