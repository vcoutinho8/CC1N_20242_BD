CREATE SCHEMA estudo_caso2_CC1N;
USE estudo_caso2_CC1N;

# TABELAS SEM CHAVES ESTRANGEIRAS
CREATE TABLE IF NOT EXISTS PASSAGEIROS (
    PASS_CPF VARCHAR(15) PRIMARY KEY, 
    PASS_NOME VARCHAR(45) NOT NULL,
    PASS_TELEFONE VARCHAR(15) NOT NULL,
    PASS_ESTADO VARCHAR(45) NOT NULL,
    PASS_CIDADE VARCHAR(30) NOT NULL,
    PASS_BAIRRO VARCHAR(45) NOT NULL,
    PASS_RUA VARCHAR(30) NOT NULL,
    PASS_NUMRUA INT NOT NULL);

CREATE TABLE IF NOT EXISTS AEROPORTOS (
    AEROP_COD INT PRIMARY KEY,
    AEROP_NOME VARCHAR(50) NOT NULL,
    AEROP_CIDADE VARCHAR(45) NOT NULL,
    AEROP_PAIS VARCHAR(30) NOT NULL,
    AEROP_LATITUDE DECIMAL(10,3) NOT NULL,
    AEROP_LONGITUDE DECIMAL(10,3) NOT NULL);


CREATE TABLE IF NOT EXISTS AERONAVES (
    AERON_PREFIXO VARCHAR(10) PRIMARY KEY, 
    AERON_MODELO VARCHAR(50) NOT NULL,
    AERON_ANOFABR DATE NOT NULL,
    AERON_FABRICANTE VARCHAR(45) NOT NULL,
    AERON_CAPACIDADE DECIMAL(10,3) NOT NULL,
    AERON_AUTONOMIA VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS FUNCIONARIOS (
    FUNC_ID INT PRIMARY KEY,
    FUNC_NOME VARCHAR(45) NOT NULL,
    FUNC_DATANASC DATE NOT NULL,
    FUNC_ESTADO VARCHAR(30) NOT NULL,
    FUNC_CIDADE VARCHAR(45) NOT NULL,
    FUNC_NUMRUA INT NOT NULL,
    FUNC_RUA VARCHAR(30) NOT NULL,
    FUNC_BAIRRO VARCHAR(30) NOT NULL,
    FUNC_CPF VARCHAR(15) NOT NULL,
    FUNC_FUNCAO VARCHAR(30) NOT NULL);

# TABELAS COM CHAVES ESTRANGEIRAS
CREATE TABLE IF NOT EXISTS VOOS (
    VOO_ID INT PRIMARY KEY,
    VOO_DATA DATE NOT NULL,
    VOO_HORA TIME NOT NULL,
    VOO_AEROP_ORIGEM INT NOT NULL,
    VOO_AEROP_DESTINO INT NOT NULL,
    VOO_AERONAVES VARCHAR(10) NOT NULL,
    CONSTRAINT FK_AEROPORTOS_ORIGEM FOREIGN KEY (VOO_AEROP_ORIGEM) REFERENCES AEROPORTOS (AEROP_COD),
    CONSTRAINT FK_AEROPORTOS_DESTINO FOREIGN KEY (VOO_AEROP_DESTINO) REFERENCES AEROPORTOS (AEROP_COD),
    CONSTRAINT FK_AERONAVES FOREIGN KEY (VOO_AERONAVES) REFERENCES AERONAVES (AERON_PREFIXO));

CREATE TABLE IF NOT EXISTS RESERVAS (
    RESERVA_COD INT PRIMARY KEY,
    VOO_ID INT,
    PASS_CPF VARCHAR(15),  
    CONSTRAINT FK_VOO_ID FOREIGN KEY (VOO_ID) REFERENCES VOOS (VOO_ID),
    CONSTRAINT FK_PASS_CPF FOREIGN KEY (PASS_CPF) REFERENCES PASSAGEIROS (PASS_CPF));

# TABELAS COM ENTIDADES ASSOCIATIVAS
CREATE TABLE IF NOT EXISTS EQUIPES (
    FUNC_ID INT NOT NULL,
    VOO_ID INT NOT NULL,
    PRIMARY KEY (FUNC_ID, VOO_ID),
    CONSTRAINT FK_FUNC_ID FOREIGN KEY (FUNC_ID) REFERENCES FUNCIONARIOS (FUNC_ID),
    CONSTRAINT FK_VOO_ID2 FOREIGN KEY (VOO_ID) REFERENCES VOOS (VOO_ID));
    
-- EXEMPLOS DE ALTER TABLE PARA PASSAGEIROS
ALTER TABLE PASSAGEIROS 
    ADD COLUMN PASS_EMAIL VARCHAR(100),
    DROP COLUMN PASS_TELEFONE,
    CHANGE COLUMN PASS_ESTADO PASS_CIDADE_ORIGEM VARCHAR(45),
    ADD INDEX IDX_PASSAGEIROS_CIDADE (PASS_CIDADE);

-- EXEMPLOS DE ALTER TABLE PARA AEROPORTOS
ALTER TABLE AEROPORTOS 
    ADD COLUMN AEROP_HORARIO_FUNCIONAMENTO VARCHAR(50),
    CHANGE COLUMN AEROP_CIDADE AEROP_CIDADE_LOCAL VARCHAR(45),
    ADD INDEX IDX_AEROPORTOS_NOME (AEROP_NOME);

-- EXEMPLOS DE ALTER TABLE PARA AERONAVES
ALTER TABLE AERONAVES 
    ADD COLUMN AERON_ANO_ATUAL INT,
    CHANGE COLUMN AERON_CAPACIDADE AERON_CAPACIDADE_PASSAGEIROS DECIMAL(10,3),
    ADD INDEX IDX_AERONAVES_MODELO (AERON_MODELO);

-- EXEMPLOS DE ALTER TABLE PARA FUNCIONARIOS
ALTER TABLE FUNCIONARIOS 
    ADD COLUMN FUNC_EMAIL VARCHAR(100),
    CHANGE COLUMN FUNC_FUNCAO FUNC_CARGO VARCHAR(30),
    ADD INDEX IDX_FUNCIONARIOS_NOME (FUNC_NOME);

-- EXEMPLOS DE ALTER TABLE PARA VOOS
ALTER TABLE VOOS 
    ADD COLUMN VOO_STATUS VARCHAR(20),
    CHANGE COLUMN VOO_AERONAVES VOO_AERONAVE_PREFIXO VARCHAR(10),
    ADD INDEX IDX_VOOS_DATA (VOO_DATA);

-- EXEMPLOS DE ALTER TABLE PARA RESERVAS
ALTER TABLE RESERVAS 
    ADD COLUMN RESERVA_STATUS VARCHAR(20),
    CHANGE COLUMN VOO_ID RESERVA_VOO_ID INT,
    ADD INDEX IDX_RESERVAS_PASS_CPF (PASS_CPF);

-- EXEMPLO DE DROP TABLE
DROP TABLE IF EXISTS EQUIPES;