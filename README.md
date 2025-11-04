# 🏢 Sistema de Gestão de Funcionários - TechSolutions

## 📋 Descrição
Sistema completo desenvolvido em **Dart** para gerenciamento de funcionários de uma empresa de tecnologia, implementando **CRUD completo** com banco de dados **MySQL** e seguindo os princípios de **POO** e arquitetura **MVC**.

---

## 🚀 Começando

### 📥 Pré-requisitos
- **Dart SDK** (versão >= 3.0.0)
- **MySQL Server** (8.0 ou superior)
- **MySQL Workbench** (opcional, mas recomendado)

### ⚙️ Configuração do Banco de Dados

1. **Execute o script SQL no MySQL Workbench:**
   🔗 [DOWNLOAD DO SCRIPT SQL](https://drive.google.com/arquivo-sql)

2. **O script inclui:**
   - Criação do banco `estudocaso2_db`
   - Tabela `funcionarios` com estrutura completa
   - Dados de exemplo para teste
   - Índices de performance

3. **Configure as credenciais** no arquivo principal:
   ```dart
   // Localize e edite estas linhas no código:
   static const String user = 'root';           // Seu usuário MySQL
   static const String password = 'password';   // Sua senha MySQL
   ```

### 🏃‍♂️ Execução do Sistema

```bash
# 1. Instale as dependências
dart pub get

# 2. Execute o sistema
dart run main.dart
```

---

## 🎯 Funcionalidades

### 👥 Gestão de Funcionários
- **Cadastrar** novos funcionários
- **Listar** todos os funcionários
- **Buscar** por ID ou matrícula
- **Atualizar** dados existentes
- **Excluir** funcionários

### 💰 Cálculos Automáticos
- **Gerentes**: 20% de bônus anual
- **Desenvolvedores**: 10% de bônus anual
- **Estagiários**: 5% de bônus anual

### 📊 Relatórios
- Estatísticas gerais da empresa
- Distribuição por cargo
- Folha salarial mensal/anual
- Projeções de custos

---

## 🏗️ Estrutura do Sistema

### 📁 Arquitetura MVC
```
📦 estudocaso2/
├── 🎨 Views/          # Interface do usuário
├── ⚙️ Controllers/     # Lógica de negócio
├── 🗃️ Models/          # Entidades do sistema
├── 🗄️ Database/        # Camada de dados
└── 🔧 Utils/          # Utilitários
```

### 🎯 Princípios de POO
- **Herança**: `Funcionario` ← `Gerente`, `Desenvolvedor`, `Estagiario`
- **Encapsulamento**: Atributos privados com getters/setters
- **Polimorfismo**: `calcularBonus()` implementado em cada classe
- **Abstração**: Classe `Funcionario` abstrata

---

## 💻 Como Usar

### 🎮 Menu Principal
```
════════════════════════════════════════
      SISTEMA DE GESTÃO DE FUNCIONÁRIOS
════════════════════════════════════════
1. 📝 Cadastrar Funcionário
2. 📋 Listar Todos os Funcionários
3. 🔍 Buscar Funcionário por ID
4. 🔎 Buscar Funcionário por Matrícula
5. ✏️  Atualizar Funcionário
6. 🗑️  Deletar Funcionário
7. 📊 Relatórios e Estatísticas
8. 🚪 Sair
────────────────────────────────────────
Escolha uma opção: 
```

### 📝 Exemplo de Cadastro
```
════════════════════════════════
    CADASTRO DE FUNCIONÁRIO
════════════════════════════════
Nome: João Silva
Matrícula: GER001
Salário Base: R$ 15000.00

Tipos de Funcionário:
1. Gerente (20% de bônus)
2. Desenvolvedor (10% de bônus)
3. Estagiário (5% de bônus)

Escolha o tipo (1-3): 1

✅ Funcionário cadastrado com sucesso!

Funcionário: João Silva
Cargo: Gerente
Matrícula: GER001
Salário: R$ 15000.00
Bônus: R$ 3000.00
```

---

## 🗃️ Estrutura do Banco de Dados

### 📊 Tabela `funcionarios`
| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | INT AUTO_INCREMENT | Chave primária |
| nome | VARCHAR(100) | Nome completo |
| matricula | VARCHAR(20) UNIQUE | Matrícula única |
| salario_base | DECIMAL(10,2) | Salário base |
| tipo | ENUM('Gerente','Desenvolvedor','Estagiario') | Cargo do funcionário |
| created_at | TIMESTAMP | Data de criação |
| updated_at | TIMESTAMP | Data de atualização |

---

## 📊 Exemplo de Relatório
```
════════════════════════════════
    RELATÓRIO COMPLETO
════════════════════════════════
📊 ESTATÍSTICAS GERAIS
────────────────────────────────
• Total de Funcionários: 5
• Folha Salarial Mensal: R$ 44500.00
• Total de Bônus Anual: R$ 6650.00
• Custo Total Anual: R$ 600650.00
• Maior Salário: R$ 15000.00
• Menor Salário: R$ 2000.00
• Média Salarial: R$ 8900.00

👥 DISTRIBUIÇÃO POR CARGO
────────────────────────────────
• Gerente: 2 funcionário(s) (40.0%)
• Desenvolvedor: 2 funcionário(s) (40.0%)
• Estagiario: 1 funcionário(s) (20.0%)

💰 CUSTO MENSAL POR CARGO
────────────────────────────────
• Gerente: R$ 32400.00
• Desenvolvedor: R$ 17050.00
• Estagiario: R$ 2100.00
```

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem**: Dart 3.0+
- **Banco de Dados**: MySQL 8.0+
- **Arquitetura**: MVC (Model-View-Controller)
- **Paradigma**: POO (Programação Orientada a Objetos)
- **Driver**: mysql1 (conexão com MySQL)
- **Interface**: Console/Terminal

---

## 📞 Suporte

### 🔍 Solução de Problemas Comuns

**Erro de Conexão com MySQL:**
- Verifique se o MySQL Server está rodando
- Confirme usuário e senha no arquivo `database_config.dart`
- Execute o script SQL fornecido no link do Drive
- Verifique se o banco `estudocaso2_db` foi criado

**Dependências Não Encontradas:**
```bash
# Execute no terminal:
dart pub get
```

**Problemas de Execução:**
- Certifique-se de ter o Dart SDK instalado
- Verifique a versão do Dart: `dart --version`
- Execute com: `dart run main.dart`

---

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como estudo de caso em **Dart**, **POO** e **MVC**.

---

## 👨‍💻 Desenvolvido por

**Estudo de Caso 2** - Sistema de Gestão de Funcionários  
💼 **TechSolutions** - 2024  
🎯 **Objetivo**: Demonstrar implementação de CRUD completo com Dart e MySQL

---

## 🎉 PRONTO PARA USAR!

```bash
# Clone o projeto, configure o banco e execute:
dart run main.dart
```

**Sistema desenvolvido com 💙 usando Dart e MySQL**

---

### 📋 CHECKLIST FINAL
- ✅ Banco de dados configurado
- ✅ Credenciais MySQL ajustadas
- ✅ Dependências instaladas
- ✅ Sistema executando
- ✅ Funcionalidades testadas

**Agora você está pronto para gerenciar seus funcionários!** 🚀
