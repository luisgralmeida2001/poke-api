# Dashboard Interativo de Comparação de Pokémon

Este repositório contém um projeto desenvolvido em **R** utilizando o framework **Shiny**, que permite criar um **dashboard interativo** para explorar e comparar atributos dos Pokémon da primeira geração (151 Pokémon). O objetivo principal é demonstrar o uso de APIs públicas e ferramentas de visualização interativa, utilizando a **PokeAPI** como fonte de dados.

---

## 🎯 **Objetivo do Projeto**

Criar uma plataforma intuitiva que:
- Permita aos usuários explorar os atributos de Pokémon.
- Compare dois Pokémon e analise qual teria vantagem em uma batalha com base nos seus atributos (HP, Ataque, Defesa, Velocidade, entre outros).
- Demonstre o uso prático de APIs públicas com ferramentas de ciência de dados.

---

## 🛠️ **Ferramentas Utilizadas**

- **R**: Linguagem principal para manipulação e visualização de dados.
- **Shiny**: Framework usado para criar a interface interativa do dashboard.
- **PokeAPI**: API pública utilizada para obter informações detalhadas sobre os Pokémon.
- **httr e jsonlite**: Pacotes R para manipulação de requisições HTTP e dados JSON.

---

## ⚙️ **Funcionalidades do Dashboard**

1. **Exploração de Dados**:  
   Os usuários podem selecionar dois Pokémon de listas suspensas para visualizar suas informações detalhadas, incluindo:
   - Nome.
   - HP.
   - Ataque.
   - Defesa.
   - Velocidade.
   - Imagem oficial do Pokémon.

2. **Comparação entre Pokémon**:  
   O dashboard calcula e exibe um vencedor provável com base em uma pontuação derivada dos atributos principais.

3. **Interface Intuitiva**:  
   Fácil de usar, com feedback em tempo real para explorar os dados.

---

## 📦 **Como Rodar o Projeto**

### Pré-requisitos
- Ter o R instalado na sua máquina.
- Instalar os pacotes necessários:
  ```R
  install.packages(c("shiny", "httr", "jsonlite"))
