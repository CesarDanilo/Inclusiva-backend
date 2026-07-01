-- CreateEnum
CREATE TYPE "StatusAdaptacao" AS ENUM ('PROCESSANDO', 'SUGERIDA', 'APROVADA', 'EXPORTADA');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "perfis" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "diretrizesIA" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "perfis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provas" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "titulo" TEXT NOT NULL,
    "conteudoOriginal" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "provas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adaptacoes_prova" (
    "id" TEXT NOT NULL,
    "provaId" TEXT NOT NULL,
    "perfilId" TEXT NOT NULL,
    "status" "StatusAdaptacao" NOT NULL DEFAULT 'PROCESSANDO',
    "conteudoAdaptado" TEXT,
    "conteudoFinal" TEXT,
    "justificativa" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "adaptacoes_prova_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "perfis_nome_key" ON "perfis"("nome");

-- CreateIndex
CREATE INDEX "provas_userId_idx" ON "provas"("userId");

-- CreateIndex
CREATE INDEX "adaptacoes_prova_provaId_idx" ON "adaptacoes_prova"("provaId");

-- CreateIndex
CREATE INDEX "adaptacoes_prova_perfilId_idx" ON "adaptacoes_prova"("perfilId");

-- AddForeignKey
ALTER TABLE "provas" ADD CONSTRAINT "provas_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adaptacoes_prova" ADD CONSTRAINT "adaptacoes_prova_provaId_fkey" FOREIGN KEY ("provaId") REFERENCES "provas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adaptacoes_prova" ADD CONSTRAINT "adaptacoes_prova_perfilId_fkey" FOREIGN KEY ("perfilId") REFERENCES "perfis"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
