import type { IUserRepository, CreateUserDTO } from "../../interfaces/user/IUserRepository.js";

export class UserServices {
  constructor(private userRepository: IUserRepository) {}

  async createUser(data: CreateUserDTO) {
    return await this.userRepository.create(data);
  }

  async findUserByEmail(email: string) {
    return await this.userRepository.findByEmail(email);
  }

  async findUserById(id: string) {
    return await this.userRepository.findById(id);
  }
}
