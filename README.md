# ARCHITECTURE.md

# Backend Architecture

> Projeto: Plataforma Inteligente de Adaptação de Provas para Educação Inclusiva (MVP)

---

# Objetivo

Este documento define a arquitetura oficial do backend do projeto.

Toda funcionalidade implementada deverá seguir os padrões aqui estabelecidos.

O objetivo é manter um código simples, organizado, escalável e fácil de manter, permitindo rápida evolução do produto sem perda de qualidade.

---

# Filosofia do Projeto

Este projeto possui duas prioridades:

1. Lançar rapidamente um MVP para validação com professores.
2. Manter qualidade suficiente para evoluir para um produto real.

Não buscamos criar a arquitetura mais sofisticada possível.

Buscamos criar a arquitetura mais simples que resolva o problema atual.

---

# Princípios Arquiteturais

## KISS

Keep It Simple.

Sempre escolher a solução mais simples possível.

Evitar abstrações prematuras.

---

## YAGNI

You Aren't Gonna Need It.

Não implementar funcionalidades pensando em problemas que ainda não existem.

A arquitetura deve crescer conforme o produto evolui.

---

## DRY

Don't Repeat Yourself.

Evitar duplicação de regras de negócio.

Caso uma lógica seja reutilizada, ela deve ser abstraída.

---

## Alta Coesão

Cada módulo deve ser responsável apenas pelo seu domínio.

Exemplo:

- Auth
- Exams
- Adaptation

---

## Baixo Acoplamento

Os módulos devem depender do mínimo possível entre si.

Sempre que possível utilizar abstrações.

---

## Composition over Inheritance

Preferir composição ao invés de herança.

---

## Clean Code

Priorizar:

- nomes claros
- funções pequenas
- responsabilidade única
- código legível

---

# Stack Oficial

## Linguagem

- TypeScript

## Runtime

- Node.js

## Framework HTTP

- Express

## Banco

- PostgreSQL

## ORM

- Prisma ORM

## Testes

- Jest
- Supertest

## Qualidade

- ESLint
- Prettier
- Husky
- lint-staged

---

# Arquitetura

O projeto utiliza uma arquitetura em camadas organizada por módulos de domínio.

Cada módulo representa uma parte do negócio.

Estrutura geral:

```text
src/
│
├── app.ts
├── server.ts
│
├── routes/
│
├── modules/
│
├── shared/
│
└── tests/
```

---

# Estrutura de Pastas

```text
src/
│
├── app.ts
├── server.ts
│
├── routes/
│   └── index.ts
│
├── modules/
│   ├── auth/
│   ├── exams/
│   └── adaptations/
│
├── shared/
│   ├── config/
│   ├── database/
│   ├── errors/
│   ├── middlewares/
│   ├── providers/
│   └── utils/
│
└── tests/
```

---

# Responsabilidade das Camadas

## Controller

Responsável por:

- receber requisições HTTP
- validar entrada
- chamar o Service
- retornar resposta HTTP

Não deve conter regra de negócio.

---

## Service

Responsável por:

- implementar regras de negócio
- executar casos de uso
- coordenar Providers
- coordenar Repositories

Toda regra de negócio deve existir nesta camada.

---

## Repository

Responsável exclusivamente pelo acesso ao banco.

Não deve conter regra de negócio.

---

## Provider

Responsável por comunicação com serviços externos.

Exemplos:

- OpenAI
- Gemini
- Serviço de Email
- Storage

---

## Middleware

Responsável por funcionalidades transversais.

Exemplos:

- autenticação
- autorização
- tratamento de erros
- logs

---

# Organização dos Módulos

Cada módulo deverá seguir a estrutura:

```text
module/
│
├── controllers/
├── services/
├── repositories/
├── routes/
├── schemas/
├── dtos/
└── types/
```

Nem todas as pastas são obrigatórias.

Criar somente quando houver necessidade.

---

# Convenção de Nomes

## Controllers

Sempre terminar com:

```text
Controller
```

Exemplo:

```text
CreateExamController
```

---

## Services

Cada Service representa um único caso de uso.

Exemplos:

```text
CreateExamService

UpdateExamService

DeleteExamService

GenerateAdaptationService
```

Nunca criar Services gigantes.

---

## Repository

Sempre terminar com:

```text
Repository
```

Exemplo:

```text
ExamRepository
```

---

## Providers

Sempre terminar com:

```text
Provider
```

Exemplo:

```text
OpenAIProvider
```

---

# Fluxo de Dependências

A comunicação deve seguir obrigatoriamente esta ordem:

```text
HTTP

↓

Controller

↓

Service

↓

Repository

↓

Prisma

↓

PostgreSQL
```

Nunca inverter esse fluxo.

---

# Providers

Toda integração externa deverá ser abstraída.

Nunca utilizar SDKs diretamente dentro dos Services.

Correto:

```text
Service

↓

AIProvider

↓

OpenAIProvider
```

Nunca:

```text
Service

↓

OpenAI SDK
```

---

# Prisma

Deve existir apenas uma instância do PrismaClient.

Nunca criar múltiplas instâncias.

---

# Variáveis de Ambiente

Nunca acessar:

```text
process.env
```

diretamente nos módulos.

Criar um arquivo responsável por validar e exportar as configurações.

Exemplo:

```text
shared/config/env.ts
```

---

# Tratamento de Erros

Nunca utilizar:

```ts
throw new Error();
```

Criar erros específicos.

Exemplo:

```text
AppError

ValidationError

UnauthorizedError

NotFoundError
```

---

# Validação

Toda entrada da API deverá ser validada.

Nenhum dado deve chegar ao Service sem validação.

---

# Testes

Todo caso de uso deverá possuir teste unitário.

Endpoints críticos deverão possuir testes de integração.

---

# Logs

Toda exceção inesperada deverá ser registrada.

Logs nunca devem expor:

- senhas
- tokens
- informações sensíveis

---

# Qualidade

Antes de qualquer commit deverão ser executados:

- Prettier
- ESLint

Em breve:

- Testes automatizados

---

# Objetivo do MVP

O MVP deve resolver apenas um problema:

Gerar provas adaptadas para alunos com TEA.

Nada além disso será desenvolvido nesta primeira versão.

Novas funcionalidades somente serão adicionadas após validação com usuários reais.

---

# Regra de Ouro

Sempre que surgir uma dúvida de arquitetura, escolher a alternativa que:

- seja mais simples;
- seja mais legível;
- seja mais fácil de testar;
- seja mais fácil de manter.

A arquitetura deve servir ao produto.

Nunca o contrário.
