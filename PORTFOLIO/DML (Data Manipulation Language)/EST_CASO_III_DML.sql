CREATE SCHEMA estudo_caso3_CC1N;
USE estudo_caso3_CC1N;

# TABELAS SEM CHAVES ESTRANGEIRAS
CREATE TABLE IF NOT EXISTS CLIENTES(
    CLIENTE_COD INT PRIMARY KEY AUTO_INCREMENT,
    CLIENTE_CNPJ VARCHAR(14) NOT NULL,
    CLIENTE_RATIVIDADE VARCHAR(100),
    CLIENTE_CADASTRAMENTO DATE NOT NULL,
    CLIENTE_CADASTRO VARCHAR(100));
    ALTER TABLE CLIENTES ADD CLIENTE_RAZAO_SOCIAL VARCHAR(100) NOT NULL;

CREATE TABLE IF NOT EXISTS PRODUTOS(
    PROD_COD INT PRIMARY KEY AUTO_INCREMENT,
    PROD_NOME VARCHAR(100) NOT NULL,
    PROD_COR VARCHAR(30) NOT NULL,
    PROD_DIMEN VARCHAR(50) NOT NULL,
    PROD_PESO DECIMAL(10,2) NOT NULL,
    PROD_PRECO DECIMAL(10,2) NOT NULL,
    PROD_TEMP_FABRI INT NOT NULL,
    PROD_DESENHO TEXT NOT NULL,
    PROD_HORAS_MAO_OBRA DECIMAL(10,2) NOT NULL);
    ALTER TABLE PRODUTOS DROP COLUMN PROD_DESENHO;

CREATE TABLE IF NOT EXISTS TIPO_ENDERECO(
    TIPO_ENDERECO_COD INT PRIMARY KEY AUTO_INCREMENT,
    TIPO_ENDERECO_NOME VARCHAR(50) NOT NULL);
    ALTER TABLE TIPO_ENDERECO MODIFY COLUMN TIPO_ENDERECO_NOME VARCHAR(75);

CREATE TABLE IF NOT EXISTS TIPOS_COMPONENTE(
    TIPOS_COMPONENTE_COD INT PRIMARY KEY AUTO_INCREMENT,
    TIPOS_COMPONENTE_NOME VARCHAR(50) NOT NULL);
    ALTER TABLE TIPOS_COMPONENTE CHANGE COLUMN TIPOS_COMPONENTE_NOME TIPOS_COMPONENTE_NOMECOMPLETO VARCHAR(150);

CREATE TABLE IF NOT EXISTS MAQUINAS(
    MAQUINAS_ID INT PRIMARY KEY AUTO_INCREMENT,
    MAQUINAS_TEMPO_VIDA INT,
    MAQUINAS_DATA_COMPRA DATE,
    MAQUINAS_DATA_FIM_GARANTIA DATE);


#-- TABELAS COM CHAVES ESTRANGEIRAS --

# ESTRUTURA DOS CLIENTES
CREATE TABLE IF NOT EXISTS TELEFONES_CLIENTE(
    TELEFONES_CLIENTE_ID INT PRIMARY KEY AUTO_INCREMENT,
    CLIENTE_COD INT,
    TELEFONE VARCHAR(15),
    FOREIGN KEY (CLIENTE_COD) REFERENCES CLIENTES(CLIENTE_COD));

CREATE TABLE IF NOT EXISTS ENDERECOS_CLIENTE(
    ENDERECOS_CLIENTE_ID INT PRIMARY KEY AUTO_INCREMENT,
    CLIENTE_COD INT,
    NUMERO VARCHAR(10),
    LOGRADOURO VARCHAR(100),
    COMPLEMENTO VARCHAR(50),
    CEP VARCHAR(10),
    BAIRRO VARCHAR(50),
    CIDADE VARCHAR(50),
    ESTADO VARCHAR(50),
    TIPO_ENDERECO_COD INT,
    FOREIGN KEY (CLIENTE_COD) REFERENCES CLIENTES(CLIENTE_COD),
    FOREIGN KEY (TIPO_ENDERECO_COD) REFERENCES TIPO_ENDERECO(TIPO_ENDERECO_COD));
    ALTER TABLE ENDERECOS_CLIENTE ADD INDEX idx_logradouro(LOGRADOURO);
    DROP INDEX idx_logradouro ON ENDERECOS_CLIENTE;

# ESTRUTURA DOS EMPREGADOS
CREATE TABLE IF NOT EXISTS ENDERECOS_EMPREGADOS(
    ENDERECOS_EMPREGADOS_ID INT PRIMARY KEY AUTO_INCREMENT,
    EMPREGADOS_NUM VARCHAR(10),
    EMPREGADOS_LOGRADOURO VARCHAR(100),
    EMPREGADOS_COMPLEMENTO VARCHAR(50),
    EMPREGADOS_CEP VARCHAR(10),
    EMPREGADOS_BAIRRO VARCHAR(50),
    EMPREGADOS_CIDADE VARCHAR(50),
    EMPREGADOS_ESTADO VARCHAR(50),
    TIPO_ENDERECO_COD INT,
    FOREIGN KEY (TIPO_ENDERECO_COD) REFERENCES TIPO_ENDERECO(TIPO_ENDERECO_COD));

CREATE TABLE IF NOT EXISTS EMPREGADOS(
    EMPREGADOS_MATRICULA INT PRIMARY KEY,
    EMPREGADOS_NOME VARCHAR(100) NOT NULL,
    EMPREGADOS_CARGO VARCHAR(50),
    EMPREGADOS_SALARIO DECIMAL(10, 2),
    EMPREGADOS_DATA_ADMISSAO DATE,
    EMPREGADOS_QUALIFICACOES TEXT,
    EMPREGADO_ENDERECO_ID INT,
    FOREIGN KEY (EMPREGADO_ENDERECO_ID) REFERENCES ENDERECOS_EMPREGADOS(ENDERECOS_EMPREGADOS_ID));

CREATE TABLE IF NOT EXISTS TELEFONES_EMPREGADO(
    TELEFONES_EMPREGADO_ID INT PRIMARY KEY AUTO_INCREMENT,
    EMPREGADOS_MATRICULA INT,
    TELEFONE VARCHAR(15),
    FOREIGN KEY (EMPREGADOS_MATRICULA) REFERENCES EMPREGADOS(EMPREGADOS_MATRICULA));

# ESTRUTURA DAS EMPRESAS
CREATE TABLE IF NOT EXISTS ENDERECOS_EMPRESA(
    ENDERECOS_EMPRESA_ID INT PRIMARY KEY AUTO_INCREMENT,
    ENDERECOS_EMPRESA_NUMERO VARCHAR(10),
    ENDERECOS_EMPRESA_LOGRADOURO VARCHAR(100),
    ENDERECOS_EMPRESA_COMPLEMENTO VARCHAR(50),
    ENDERECOS_EMPRESA_CEP VARCHAR(10),
    ENDERECOS_EMPRESA_BAIRRO VARCHAR(50),
    ENDERECOS_EMPRESA_CIDADE VARCHAR(50),
    ENDERECOS_EMPRESA_ESTADO VARCHAR(50),
    TIPO_ENDERECO_COD INT,
    FOREIGN KEY (TIPO_ENDERECO_COD) REFERENCES TIPO_ENDERECO(TIPO_ENDERECO_COD));

CREATE TABLE IF NOT EXISTS EMPRESAS(
    EMPRESAS_CNPJ VARCHAR(14) PRIMARY KEY,
    EMPRESAS_RSOCIAL VARCHAR(100) NOT NULL,
    EMPRESAS_PESSOA_CONTATO VARCHAR(100),
    ENDERECOS_EMPRESA_ID INT,
    FOREIGN KEY (ENDERECOS_EMPRESA_ID) REFERENCES ENDERECOS_EMPRESA(ENDERECOS_EMPRESA_ID));

# ESTRUTURA DOS FORNECEDORES
CREATE TABLE IF NOT EXISTS ENDERECOS_FORNECEDOR(
    ENDERECOS_FORNECEDOR_ID INT PRIMARY KEY AUTO_INCREMENT,
    ENDERECOS_FORNECEDOR_NUMERO VARCHAR(10),
    ENDERECOS_FORNECEDOR_LOGRADOURO VARCHAR(100),
    ENDERECOS_FORNECEDOR_COMPLEMENTO VARCHAR(50),
    ENDERECOS_FORNECEDOR_CEP VARCHAR(10),
    ENDERECOS_FORNECEDOR_BAIRRO VARCHAR(50),
    ENDERECOS_FORNECEDOR_CIDADE VARCHAR(50),
    ENDERECOS_FORNECEDOR_ESTADO VARCHAR(50),
    TIPO_ENDERECO_COD INT,
    FOREIGN KEY (TIPO_ENDERECO_COD) REFERENCES TIPO_ENDERECO(TIPO_ENDERECO_COD));

CREATE TABLE IF NOT EXISTS FORNECEDORES(
    FORNECEDORES_CNPJ VARCHAR(14) PRIMARY KEY,
    FORNECEDORES_RSOCIAL VARCHAR(100) NOT NULL,
    FORNECEDORES_PESSOA_CONTATO VARCHAR(100),
    ENDERECOS_FORNECEDOR_ID INT,
    FOREIGN KEY (ENDERECOS_FORNECEDOR_ID) REFERENCES ENDERECOS_FORNECEDOR(ENDERECOS_FORNECEDOR_ID));

CREATE TABLE IF NOT EXISTS ENCOMENDAS(
    ENCOMENDAS_NUMERO INT PRIMARY KEY AUTO_INCREMENT,
    ENCOMENDAS_DATA_INCLUSAO DATE NOT NULL,
    ENCOMENDAS_VALOR_TOTAL DECIMAL(10, 2),
    ENCOMENDAS_VALOR_DESCONTO DECIMAL(10, 2),
    ENCOMENDAS_VALOR_LIQUIDO DECIMAL(10, 2),
    ENCOMENDAS_COD_FORMA_PAGAMENTO INT,
    ENCOMENDAS_QUANT_PARCELAS INT,
    CLIENTE_COD INT,
    FOREIGN KEY (CLIENTE_COD) REFERENCES CLIENTES(CLIENTE_COD));

CREATE TABLE IF NOT EXISTS COMPONENTES (
    COMPONENTES_COD INT PRIMARY KEY AUTO_INCREMENT,
    COMPONENTES_NOME VARCHAR(100) NOT NULL,
    COMPONENTES_QUANT_ESTOQUE INT,
    COMPONENTES_PRECO_UNIT DECIMAL(10, 2),
    COMPONENTES_UNIDADE VARCHAR(20),
    TIPOS_COMPONENTE_COD INT,
    CNPJ_FORNECEDOR VARCHAR(14),
    FOREIGN KEY (TIPOS_COMPONENTE_COD) REFERENCES TIPOS_COMPONENTE(TIPOS_COMPONENTE_COD),
    FOREIGN KEY (CNPJ_FORNECEDOR) REFERENCES FORNECEDORES(FORNECEDORES_CNPJ));

CREATE TABLE IF NOT EXISTS RE(
    RE_COD INT PRIMARY KEY AUTO_INCREMENT,
    RE_QUANT_NECESSARIA INT,
    RE_UNIDADE VARCHAR(20),
    RE_TEMPO_USO INT,
    RE_HORAS_MAO_OBRA DECIMAL(10, 2),
    PROD_COD INT,
    FOREIGN KEY (PROD_COD) REFERENCES PRODUTOS(PROD_COD));

CREATE TABLE IF NOT EXISTS RM(
    RM_COD INT PRIMARY KEY AUTO_INCREMENT,
    RM_DATA DATE,
    RM_DESCRICAO TEXT,
    MAQUINAS_ID INT,
    FOREIGN KEY (MAQUINAS_ID) REFERENCES MAQUINAS(MAQUINAS_ID));

CREATE TABLE IF NOT EXISTS RS(
    RS_COD INT PRIMARY KEY AUTO_INCREMENT,
    RS_QUANTIDADE INT,
    RS_DATA_NECESSARIA DATE,
    COMPONENTES_COD INT,
    FOREIGN KEY (COMPONENTES_COD) REFERENCES COMPONENTES(COMPONENTES_COD));

INSERT INTO CLIENTES (CLIENTE_CNPJ, CLIENTE_RATIVIDADE, CLIENTE_CADASTRAMENTO, CLIENTE_CADASTRO, CLIENTE_RAZAO_SOCIAL)
VALUES ('12345678901234', 'Comércio', '2024-01-01', '2024-01-01', 'Cliente A');
INSERT INTO CLIENTES (CLIENTE_CNPJ, CLIENTE_RATIVIDADE, CLIENTE_CADASTRAMENTO, CLIENTE_CADASTRO, CLIENTE_RAZAO_SOCIAL)
VALUES ('22345678901234', 'Serviços', '2024-02-01', '2024-02-01', 'Cliente B');
INSERT INTO CLIENTES (CLIENTE_CNPJ, CLIENTE_RATIVIDADE, CLIENTE_CADASTRAMENTO, CLIENTE_CADASTRO, CLIENTE_RAZAO_SOCIAL)
VALUES ('32345678901234', 'Industrial', '2024-03-01', '2024-03-01', 'Cliente C');
INSERT INTO CLIENTES (CLIENTE_CNPJ, CLIENTE_RATIVIDADE, CLIENTE_CADASTRAMENTO, CLIENTE_CADASTRO, CLIENTE_RAZAO_SOCIAL)
VALUES ('42345678901234', 'Tecnologia', '2024-04-01', '2024-04-01', 'Cliente D');
INSERT INTO CLIENTES (CLIENTE_CNPJ, CLIENTE_RATIVIDADE, CLIENTE_CADASTRAMENTO, CLIENTE_CADASTRO, CLIENTE_RAZAO_SOCIAL)
VALUES ('52345678901234', 'Educação', '2024-05-01', '2024-05-01', 'Cliente E');

INSERT INTO TIPO_ENDERECO (TIPO_ENDERECO_NOME)
VALUES ('Residencial');
INSERT INTO TIPO_ENDERECO (TIPO_ENDERECO_NOME)
VALUES ('Comercial');
INSERT INTO TIPO_ENDERECO (TIPO_ENDERECO_NOME)
VALUES ('Industrial');
INSERT INTO TIPO_ENDERECO (TIPO_ENDERECO_NOME)
VALUES ('Faturamento');
INSERT INTO TIPO_ENDERECO (TIPO_ENDERECO_NOME)
VALUES ('Entrega');

INSERT INTO PRODUTOS (PROD_NOME, PROD_COR, PROD_DIMEN, PROD_PESO, PROD_PRECO, PROD_TEMP_FABRI, PROD_HORAS_MAO_OBRA)
VALUES ('Produto A', 'Azul', '10x20x5', 1.5, 50.00, 30, 1.5);
INSERT INTO PRODUTOS (PROD_NOME, PROD_COR, PROD_DIMEN, PROD_PESO, PROD_PRECO, PROD_TEMP_FABRI, PROD_HORAS_MAO_OBRA)
VALUES ('Produto B', 'Vermelho', '15x25x5', 2.0, 75.00, 40, 2.0);
INSERT INTO PRODUTOS (PROD_NOME, PROD_COR, PROD_DIMEN, PROD_PESO, PROD_PRECO, PROD_TEMP_FABRI, PROD_HORAS_MAO_OBRA)
VALUES ('Produto C', 'Verde', '20x30x5', 2.5, 100.00, 50, 2.5);
INSERT INTO PRODUTOS (PROD_NOME, PROD_COR, PROD_DIMEN, PROD_PESO, PROD_PRECO, PROD_TEMP_FABRI, PROD_HORAS_MAO_OBRA)
VALUES ('Produto D', 'Amarelo', '25x35x5', 3.0, 125.00, 60, 3.0);
INSERT INTO PRODUTOS (PROD_NOME, PROD_COR, PROD_DIMEN, PROD_PESO, PROD_PRECO, PROD_TEMP_FABRI, PROD_HORAS_MAO_OBRA)
VALUES ('Produto E', 'Preto', '30x40x5', 3.5, 150.00, 70, 3.5);

INSERT INTO TIPOS_COMPONENTE (TIPOS_COMPONENTE_NOMECOMPLETO)
VALUES ('Tipo A');
INSERT INTO TIPOS_COMPONENTE (TIPOS_COMPONENTE_NOMECOMPLETO)
VALUES ('Tipo B');
INSERT INTO TIPOS_COMPONENTE (TIPOS_COMPONENTE_NOMECOMPLETO)
VALUES ('Tipo C');
INSERT INTO TIPOS_COMPONENTE (TIPOS_COMPONENTE_NOMECOMPLETO)
VALUES ('Tipo D');
INSERT INTO TIPOS_COMPONENTE (TIPOS_COMPONENTE_NOMECOMPLETO)
VALUES ('Tipo E');

INSERT INTO MAQUINAS (MAQUINAS_TEMPO_VIDA, MAQUINAS_DATA_COMPRA, MAQUINAS_DATA_FIM_GARANTIA)
VALUES (5, '2022-01-01', '2025-01-01');
INSERT INTO MAQUINAS (MAQUINAS_TEMPO_VIDA, MAQUINAS_DATA_COMPRA, MAQUINAS_DATA_FIM_GARANTIA)
VALUES (7, '2021-01-01', '2026-01-01');
INSERT INTO MAQUINAS (MAQUINAS_TEMPO_VIDA, MAQUINAS_DATA_COMPRA, MAQUINAS_DATA_FIM_GARANTIA)
VALUES (10, '2020-01-01', '2030-01-01');
INSERT INTO MAQUINAS (MAQUINAS_TEMPO_VIDA, MAQUINAS_DATA_COMPRA, MAQUINAS_DATA_FIM_GARANTIA)
VALUES (15, '2019-01-01', '2034-01-01');
INSERT INTO MAQUINAS (MAQUINAS_TEMPO_VIDA, MAQUINAS_DATA_COMPRA, MAQUINAS_DATA_FIM_GARANTIA)
VALUES (20, '2018-01-01', '2038-01-01');

UPDATE CLIENTES SET CLIENTE_CADASTRAMENTO = '2023-12-01' WHERE CLIENTE_COD = 1;
UPDATE CLIENTES SET CLIENTE_RAZAO_SOCIAL = 'Cliente Atualizado A' WHERE CLIENTE_COD = 2;

UPDATE TIPO_ENDERECO SET TIPO_ENDERECO_NOME = 'Residencial Atualizado' WHERE TIPO_ENDERECO_COD = 1;
UPDATE TIPO_ENDERECO SET TIPO_ENDERECO_NOME = 'Comercial Atualizado' WHERE TIPO_ENDERECO_COD = 2;

UPDATE PRODUTOS SET PROD_PRECO = 55.00 WHERE PROD_COD = 1;
UPDATE PRODUTOS SET PROD_PESO = 1.8 WHERE PROD_COD = 2;

UPDATE TIPOS_COMPONENTE SET TIPOS_COMPONENTE_NOMECOMPLETO = 'Tipo A Atualizado' WHERE TIPOS_COMPONENTE_COD = 1;
UPDATE TIPOS_COMPONENTE SET TIPOS_COMPONENTE_NOMECOMPLETO = 'Tipo B Atualizado' WHERE TIPOS_COMPONENTE_COD = 2;

UPDATE MAQUINAS SET MAQUINAS_TEMPO_VIDA = 8 WHERE MAQUINAS_ID = 1;
UPDATE MAQUINAS SET MAQUINAS_DATA_COMPRA = '2023-01-01' WHERE MAQUINAS_ID = 2;

DELETE FROM TIPOS_COMPONENTE WHERE TIPOS_COMPONENTE_COD = 5;

