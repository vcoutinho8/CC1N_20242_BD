CREATE SCHEMA estudo_caso4_CC1N;
USE estudo_caso4_CC1N;

# TABELAS SEM CHAVES ESTRANGEIRAS
CREATE TABLE MODALIDADE(
    MODALIDADE_ID INT PRIMARY KEY,
    MODALIDADE_NOME VARCHAR(45) NOT NULL UNIQUE,
    MODALIDADE_DESCRICAO TEXT NOT NULL,
    MODALIDADE_CAPACIDADE INT NOT NULL);

CREATE TABLE PLANO_DE_TREINAMENTO(
    PLANO_ID INT PRIMARY KEY,
    PLANO_DESCRICAO TEXT NOT NULL,
    PLANO_DATA_CRIACAO DATE NOT NULL,
    PLANO_DATA_ATUALIZACAO DATE NOT NULL);

CREATE TABLE AULA(
    AULA_ID INT PRIMARY KEY,
    AULA_HORARIO TIME NOT NULL,
    AULA_CAPACIDADE INT NOT NULL);

# TABELAS COM CHAVES ESTRANGEIRAS
CREATE TABLE ALUNO(
    ALUNO_ID INT PRIMARY KEY,
    ALUNO_NOME VARCHAR(50) NOT NULL,
    ALUNO_CPF VARCHAR(15) NOT NULL UNIQUE,
    ALUNO_DATA_NASCIMENTO DATE NOT NULL,
    ALUNO_ESTADO VARCHAR(30) NOT NULL,
    ALUNO_CIDADE VARCHAR(45) NOT NULL,
    ALUNO_RUA VARCHAR(30) NOT NULL,
    ALUNO_NUMRUA INT NOT NULL,
    ALUNO_CEP CHAR(8) NOT NULL,
    MODALIDADE_INTERESSE INT NOT NULL,
    CONSTRAINT FK_ALUNO_MODALIDADE FOREIGN KEY (MODALIDADE_INTERESSE) REFERENCES MODALIDADE(MODALIDADE_ID));

CREATE TABLE INSTRUTOR(
    INSTRUTOR_ID INT PRIMARY KEY,
    INSTRUTOR_NOME VARCHAR(45) NOT NULL,
    MODALIDADE_ENSINA INT NOT NULL,
    CONSTRAINT FK_INSTRUTOR_MODALIDADE FOREIGN KEY (MODALIDADE_ENSINA) REFERENCES MODALIDADE(MODALIDADE_ID));

CREATE TABLE PAGAMENTO(
    PAGAMENTO_ID INT PRIMARY KEY,
    PAGAMENTO_DATA DATE NOT NULL,
    PAGAMENTO_VALOR DECIMAL(10, 3) NOT NULL,
    PAGAMENTO_STATUS BOOLEAN NOT NULL,
    ALUNO_ID INT,
    CONSTRAINT FK_PAGAMENTO_ALUNO FOREIGN KEY (ALUNO_ID) REFERENCES ALUNO(ALUNO_ID));

# ENTIDADES ASSOCIATIVAS
CREATE TABLE ALUNO_PLANO(
    ALUNO_ID INT,
    PLANO_ID INT,
    PRIMARY KEY (ALUNO_ID, PLANO_ID),
    CONSTRAINT FK_ALUNO_PLANO_ALUNO FOREIGN KEY (ALUNO_ID) REFERENCES ALUNO(ALUNO_ID),
    CONSTRAINT FK_ALUNO_PLANO_PLANO FOREIGN KEY (PLANO_ID) REFERENCES PLANO_DE_TREINAMENTO(PLANO_ID));

CREATE TABLE ALUNO_AULA(
    ALUNO_ID INT,
    AULA_ID INT,
    PRIMARY KEY (ALUNO_ID, AULA_ID),
    CONSTRAINT FK_ALUNO_AULA_ALUNO FOREIGN KEY (ALUNO_ID) REFERENCES ALUNO(ALUNO_ID),
    CONSTRAINT FK_ALUNO_AULA_AULA FOREIGN KEY (AULA_ID) REFERENCES AULA(AULA_ID));

CREATE TABLE INSTRUTOR_AULA(
    INSTRUTOR_ID INT,
    AULA_ID INT,
    PRIMARY KEY (INSTRUTOR_ID, AULA_ID),
    CONSTRAINT FK_INSTRUTOR_AULA_INSTRUTOR FOREIGN KEY (INSTRUTOR_ID) REFERENCES INSTRUTOR(INSTRUTOR_ID),
    CONSTRAINT FK_INSTRUTOR_AULA_AULA FOREIGN KEY (AULA_ID) REFERENCES AULA(AULA_ID));

-- EXEMPLOS DE ALTER TABLE PARA ALUNO
ALTER TABLE ALUNO ADD COLUMN ALUNO_EMAIL VARCHAR(100);
ALTER TABLE ALUNO DROP COLUMN ALUNO_CPF;
ALTER TABLE ALUNO CHANGE COLUMN ALUNO_ESTADO ALUNO_MUNICIPIO VARCHAR(150);
ALTER TABLE ALUNO ADD INDEX IDX_ALUNO_CIDADE (ALUNO_CIDADE);

-- EXEMPLOS DE ALTER TABLE PARA INSTRUTOR
ALTER TABLE INSTRUTOR ADD COLUMN INSTRUTOR_EMAIL VARCHAR(100);
ALTER TABLE INSTRUTOR CHANGE COLUMN INSTRUTOR_NOME INSTRUTOR_NOME_COMPLETO VARCHAR(150);
ALTER TABLE INSTRUTOR ADD INDEX IDX_INSTRUTOR_MODALIDADE (MODALIDADE_ENSINA);

-- EXEMPLOS DE ALTER TABLE PARA MODALIDADE
ALTER TABLE MODALIDADE ADD COLUMN MODALIDADE_PRECO DECIMAL(10, 2);
ALTER TABLE MODALIDADE DROP COLUMN MODALIDADE_CAPACIDADE;
ALTER TABLE MODALIDADE CHANGE COLUMN MODALIDADE_DESCRICAO MODALIDADE_DETALHES TEXT;
ALTER TABLE MODALIDADE ADD INDEX IDX_MODALIDADE_NOME (MODALIDADE_NOME);

-- EXEMPLOS DE ALTER TABLE PARA PAGAMENTO
ALTER TABLE PAGAMENTO ADD COLUMN PAGAMENTO_COMPROVANTE VARCHAR(100);
ALTER TABLE PAGAMENTO CHANGE COLUMN PAGAMENTO_VALOR PAGAMENTO_TOTAL DECIMAL(15, 2);
ALTER TABLE PAGAMENTO ADD INDEX IDX_PAGAMENTO_DATA (PAGAMENTO_DATA);

-- EXEMPLO DE DROP TABLE
DROP TABLE IF EXISTS ALUNO_PLANO; -- REMOVE A TABELA "AULA" CASO EXISTA
