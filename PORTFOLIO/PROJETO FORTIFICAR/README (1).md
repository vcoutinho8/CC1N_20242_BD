1. Estrutura do Banco de Dados
Tabelas principais e suas funções:
1. EMPRESAS:
Armazena os dados das empresas cadastradas, que podem submeter
projetos para participar dos editais.
o Exemplo: Fortes Engenharia, EcoBuild Sustentável.
o Campos incluem nome, CNPJ, endereço, contato e status
(ativa/inativa).
2. FUNCIONARIOS:
Gerencia os dados dos funcionários vinculados a empresas.
o Exemplo: João Silva (Engenheiro Civil da Fortes Engenharia).
o Relacionado com EMPRESAS via ID_EMPRESA.
3. EDITAIS:
Contém os editais disponíveis, com descrição, datas de
abertura/fechamento e status (aberto/fechado).
o Exemplo: "Edital Habitação 2024".
o Editais são a base para submeter projetos.
4. PROJETOS:
Armazena informações sobre os projetos submetidos pelas empresas
em resposta a editais.
o Exemplo: "Fortificar Habitação" submetido pela Fortes
Engenharia.
o Relaciona-se a EMPRESAS (empresa responsável) e EDITAIS
(edital vinculado).
5. DESPESAS:
Registra os gastos associados a cada projeto aprovado.
o Exemplo: Compra de materiais, pagamento de mão de obra.
o Relaciona-se a PROJETOS via ID_PROJETO.
6. ODS (Objetivos de Desenvolvimento Sustentável):
Lista os temas globais relacionados aos projetos, como erradicação da
pobreza ou ação climática.
o Exemplo: "Cidades Sustentáveis".
7. PROJETO_ODS:
Relaciona os projetos com os ODS que eles promovem.
o Exemplo: O projeto "Moradia Sustentável" está vinculado aos
ODS "Erradicação da Pobreza" e "Consumo e Produção
Responsáveis".
2. Fluxo de Funcionamento
Etapas do Sistema:
1. Cadastro de empresas e funcionários:
o Empresas interessadas no programa são registradas no sistema
com seus dados. Cada empresa pode ter vários funcionários
vinculados.
2. Publicação de editais:
o A Fortes Engenharia disponibiliza editais para atrair projetos, com
descrições e prazos.
3. Submissão de projetos:
o As empresas submetem projetos vinculados a editais, incluindo
informações como nome, descrição e orçamento solicitado.
4. Avaliação de projetos:
o Após análise, os projetos podem ser aprovados, com um valor
final autorizado. Esse status é armazenado no campo
STATUS_PROJETO.
5. Registro de despesas:
o Após a aprovação, as empresas vinculadas ao projeto começam
a registrar despesas específicas para controle.
6. Associação a ODS:
o Cada projeto é relacionado a um ou mais ODS, evidenciando
como ele contribui para os objetivos globais.
3. Consultas e Análises
Objetivos das consultas (DQL):
• Transparência: Verificar onde os recursos estão sendo investidos.
• Gestão: Acompanhar status de projetos, despesas e valores aprovados.
• Impacto: Identificar quais ODS estão sendo promovidos por projetos
específicos.
Benefícios do Sistema
• Organização: Todas as informações estão centralizadas, reduzindo o
risco de inconsistências.
• Transparência: Registro de despesas e vínculos com ODS promovem
responsabilidade social.
• Gestão eficiente: Relacionamentos bem definidos permitem consultas
rápidas e precisas.
• Alinhamento estratégico: Projetos são vinculados a objetivos globais
claros (ODS).
