import bcrypt from "bcrypt";

export async function passwordHashUtils(passwordHash: string) {
  return passwordHash ? await bcrypt.hash(passwordHash, 10) : null;
}
