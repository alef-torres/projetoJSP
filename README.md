# Sistema CRUD com JSP, HTML, CSS e PostgreSQL

Este é um projeto CRUD simples feito utilizando tecnologias mais antigas do ecossistema Java Web: **JSP (JavaServer Pages)**, **HTML**, **CSS** e **Java** puro para conexão com banco de dados **PostgreSQL**.

## 💡 Objetivo do Projeto

O objetivo principal deste projeto é entender **como aplicações web eram construídas antes da popularização de frameworks modernos** como Spring, React, Angular e afins. Eu tenho interesse em compreender como a web evoluiu, e acredito que conhecer essas abordagens mais antigas ajuda a valorizar as tecnologias atuais.

## 🧱 Estrutura da Aplicação

### 🔐 Página de Login

- Tela inicial onde o usuário informa nome e senha.
- Os dados são comparados com registros salvos no banco de dados PostgreSQL.
- Se válidos, o usuário é redirecionado para a página hub.

### 🧭 Página Hub

- Um simples menu de navegação HTML com três opções:
  - Acesso à tabela de usuários.
  - Acesso à tabela de bairros.
  - Sair e voltar ao login.

### 👥 Página de Usuários

- Exibe todos os usuários cadastrados em uma **tabela HTML**.
- Cada linha contém:
  - ID do usuário
  - Nome
  - Nível de acesso
  - Botões: **Alterar** e **Excluir**

#### Funcionalidades

- **Adicionar Novo Usuário**: Abre um **modal** com campos em branco.
- **Alterar Usuário**: Abre o **modal** preenchido com os dados do usuário.
- **Excluir Usuário**: Remove o usuário do banco.
- **Voltar para Hub** e **Voltar para Login**

### 🏘️ Página de Bairros

- Estrutura e funcionamento muito semelhantes à página de usuários.
- Cada bairro possui:
  - ID
  - Nome
- Modal de cadastro e edição.
- Funcionalidades de adicionar, alterar e excluir.

## 🛠️ Tecnologias Utilizadas

- **Frontend**: HTML5, CSS3
- **Backend**: JSP + Java puro (Servlets e JDBC)
- **Banco de Dados**: PostgreSQL (versão 7+)
- **Servidor**: Apache Tomcat

## 📚 Aprendizado

> "Fiz questão de implementar esse sistema utilizando **tecnologias consideradas antigas**, como JSP e JDBC direto, sem frameworks modernos. Isso me ajudou a compreender os fundamentos do desenvolvimento web com Java e como as soluções evoluíram ao longo do tempo."

## 📂 Estrutura de Pastas (Exemplo)

```
/webapp
│
├── index.jsp               # Login
├── hub.html                # Página principal
├── painelUsers.jsp         # Tabela de usuários
├── painelBairros.jsp       # Tabela de bairros
├── CSS/
│   └── styles.css          # Estilo visual
├── JS/
│   └── scripts.js          # (Opcional) scripts para modais
```

## 🧪 Como Executar

1. Clonar o repositório
2. Abrir no Eclipse ou IDE compatível com projetos dinâmicos JSP
3. Configurar o Apache Tomcat (versão 9 recomendado)
4. Importar o banco de dados PostgreSQL e ajustar as credenciais nos arquivos `.jsp`
5. Executar o servidor e acessar via navegador:  
   `http://localhost:8080/SeuProjeto`

## 📌 Observação

Este projeto é de caráter **educacional**, voltado para estudo e entendimento de como funcionava a arquitetura Web com JSP antes da consolidação de tecnologias modernas.
