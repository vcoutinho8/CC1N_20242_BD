-- Inserindo Empresas
INSERT INTO EMPRESAS (NOME_EMP, CNPJ_EMP, LOGRADOURO_EMP, NUMERO_EMP, BAIRRO_EMP, CIDADE_EMP, UF_EMP, TELEFONE_EMP, EMAIL_EMP, STATUS_EMPRESA) 
VALUES 
('Fortes Engenharia', '12.345.678/0001-99', 'Av. Central', '123', 'Centro', 'Guarapari', 'ES', '(27) 3333-4444', 'contato@fortesengenharia.com', TRUE),
('Construtora ABC', '98.765.432/0001-11', 'Rua das Flores', '45', 'Muquiçaba', 'Vila Velha', 'ES', '(27) 2222-1111', 'contato@abcconstrutora.com', FALSE);

-- Inserindo Funcionários
INSERT INTO FUNCIONARIOS (NOME_FUNC, CARGO_FUNC, EMAIL_FUNC, TELEFONE_FUNC, ID_EMPRESA) 
VALUES 
('João Silva', 'Engenheiro Civil', 'joao@fortesengenharia.com', '(27) 99999-8888', 1),
('Ana Costa', 'Gestora de Projetos', 'ana@abcconstrutora.com', '(27) 98888-7777', 2);

-- Inserindo Editais
INSERT INTO EDITAIS (NOME_EDITAL, DESC_EDITAL, DATA_ABERTURA_EDITAL, DATA_FECHAMENTO_EDITAL, STATUS_EDITAL) 
VALUES 
('Edital Habitação 2024', 'Financiamento para projetos de habitação popular.', '2024-01-01', '2024-06-30', TRUE),
('Edital Infraestrutura 2023', 'Foco em projetos de infraestrutura urbana.', '2023-01-01', '2023-12-31', FALSE);

-- Inserindo Projetos
INSERT INTO PROJETOS (ID_EMPRESA, ID_EDITAL, NOME_PROJETO, DESC_PROJETO, STATUS_PROJETO, VALOR_APROVADO_PROJ) 
VALUES 
(1, 1, 'Fortificar Habitação', 'Construção de 50 unidades habitacionais.', TRUE, 500000.00),
(2, 2, 'Infraestrutura Urbana ABC', 'Reforma de praças e calçadas.', FALSE, 250000.00);

-- Inserindo Despesas
INSERT INTO DESPESAS (ID_PROJETO, DATA_DESPESA, VALOR, DESCRICAO) 
VALUES 
(1, '2024-02-15', 50000.00, 'Compra de materiais de construção'),
(1, '2024-03-01', 20000.00, 'Pagamento de mão de obra'),
(2, '2023-07-20', 15000.00, 'Reforma de praça central');

-- Inserindo ODS (Objetivos de Desenvolvimento Sustentável)
INSERT INTO ODS (NOME_ODS, DESC_ODS) 
VALUES 
('Erradicação da Pobreza', 'Acabar com a pobreza em todas as suas formas, em todos os lugares.'),
('Cidades Sustentáveis', 'Tornar as cidades e os assentamentos humanos inclusivos, seguros, resilientes e sustentáveis.');

-- Relacionando Projetos com ODS
INSERT INTO PROJETO_ODS (ID_PROJETO, ID_ODS) 
VALUES 
(1, 1), -- Fortificar Habitação vinculado a "Erradicação da Pobreza"
(2, 2); -- Infraestrutura Urbana ABC vinculado a "Cidades Sustentáveis"
