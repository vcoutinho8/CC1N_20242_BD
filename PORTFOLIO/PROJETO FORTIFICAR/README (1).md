# Sistema de Gestão para o Projeto Fortificar | 💻🏙️

## 1. Estrutura do Banco de Dados

### Tabelas principais e suas funções:

1. **EMPRESAS**  
   Armazena os dados das empresas cadastradas, que podem submeter projetos para participar dos editais.  
   - **Exemplo:** Fortes Engenharia, EcoBuild Sustentável.  
   - **Campos incluem:** nome, CNPJ, endereço, contato e status (ativa/inativa).

2. **FUNCIONARIOS**  
   Gerencia os dados dos funcionários vinculados às empresas.  
   - **Exemplo:** João Silva (Engenheiro Civil da Fortes Engenharia).  
   - **Relacionamento:** Relacionado com a tabela `EMPRESAS` via `ID_EMPRESA`.

3. **EDITAIS**  
   Contém os editais disponíveis, com descrição, datas de abertura/fechamento e status (aberto/fechado).  
   - **Exemplo:** "Edital Habitação 2024".  
   - **Objetivo:** Base para submissão de projetos.

4. **PROJETOS**  
   Armazena informações sobre os projetos submetidos pelas empresas em resposta a editais.  
   - **Exemplo:** "Fortificar Habitação" submetido pela Fortes Engenharia.  
   - **Relacionamentos:**  
     - `EMPRESAS`: Empresa responsável.  
     - `EDITAIS`: Edital vinculado.

5. **DESPESAS**  
   Registra os gastos associados a cada projeto aprovado.  
   - **Exemplo:** Compra de materiais, pagamento de mão de obra.  
   - **Relacionamento:** Relacionado à tabela `PROJETOS` via `ID_PROJETO`.

6. **ODS (Objetivos de Desenvolvimento Sustentável)**  
   Lista os temas globais relacionados aos projetos, como erradicação da pobreza ou ação climática.  
   - **Exemplo:** "Cidades Sustentáveis".

7. **PROJETO_ODS**  
   Relaciona os projetos com os ODS que eles promovem.  
   - **Exemplo:** O projeto "Moradia Sustentável" está vinculado aos ODS "Erradicação da Pobreza" e "Consumo e Produção Responsáveis".

---

## 2. Fluxo de Funcionamento

### Etapas do Sistema:

1. **Cadastro de empresas e funcionários:**  
   - Empresas interessadas no programa são registradas no sistema.  
   - Cada empresa pode ter vários funcionários vinculados.

2. **Publicação de editais:**  
   - A Fortes Engenharia disponibiliza editais para atrair projetos, com descrições e prazos.

3. **Submissão de projetos:**  
   - Empresas submetem projetos vinculados a editais, incluindo informações como nome, descrição e orçamento solicitado.

4. **Avaliação de projetos:**  
   - Após análise, os projetos podem ser aprovados, com um valor final autorizado.  
   - Esse status é armazenado no campo `STATUS_PROJETO`.

5. **Registro de despesas:**  
   - Após a aprovação, as empresas começam a registrar despesas específicas para controle.

6. **Associação a ODS:**  
   - Cada projeto é relacionado a um ou mais ODS, evidenciando como contribui para os objetivos globais.

---

## 3. Consultas e Análises

### Objetivos das consultas (DQL):

- **Transparência:** Verificar onde os recursos estão sendo investidos.  
- **Gestão:** Acompanhar o status de projetos, despesas e valores aprovados.  
- **Impacto:** Identificar quais ODS estão sendo promovidos por projetos específicos.

---

## Benefícios do Sistema

- **Organização:** Centralização das informações, reduzindo inconsistências.  
- **Transparência:** Registro de despesas e vínculos com ODS promovem responsabilidade social.  
- **Gestão eficiente:** Relacionamentos bem definidos permitem consultas rápidas e precisas.  
- **Alinhamento estratégico:** Projetos vinculados a objetivos globais claros (ODS).
