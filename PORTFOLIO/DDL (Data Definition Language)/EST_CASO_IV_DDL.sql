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

ALTER TABLE MODALIDADE ADD COLUMN MODALIDADE_DURACAO INT;
ALTER TABLE MODALIDADE DROP COLUMN MODALIDADE_DURACAO;
ALTER TABLE MODALIDADE MODIFY COLUMN MODALIDADE_CAPACIDADE DECIMAL(10,2);
ALTER TABLE MODALIDADE CHANGE COLUMN MODALIDADE_NOME NOME_MODALIDADE VARCHAR(50);

ALTER TABLE PLANO_DE_TREINAMENTO ADD COLUMN PLANO_DURACAO INT;
ALTER TABLE PLANO_DE_TREINAMENTO DROP COLUMN PLANO_DURACAO;
ALTER TABLE PLANO_DE_TREINAMENTO MODIFY COLUMN PLANO_DATA_CRIACAO DATETIME;
ALTER TABLE PLANO_DE_TREINAMENTO CHANGE COLUMN PLANO_DESCRICAO DESCRICAO_PLANO TEXT;

ALTER TABLE AULA ADD COLUMN AULA_LOCAL VARCHAR(100);
ALTER TABLE AULA DROP COLUMN AULA_LOCAL;
ALTER TABLE AULA MODIFY COLUMN AULA_CAPACIDADE SMALLINT;
ALTER TABLE AULA CHANGE COLUMN AULA_HORARIO HORARIO_AULA TIME;

ALTER TABLE ALUNO ADD COLUMN ALUNO_EMAIL VARCHAR(50);
ALTER TABLE ALUNO DROP COLUMN ALUNO_EMAIL;
ALTER TABLE ALUNO MODIFY COLUMN ALUNO_NUMRUA VARCHAR(10);
ALTER TABLE ALUNO CHANGE COLUMN ALUNO_CEP CEP_ALUNO CHAR(9);

ALTER TABLE INSTRUTOR ADD COLUMN INSTRUTOR_ESPECIALIZACAO VARCHAR(50);
ALTER TABLE INSTRUTOR DROP COLUMN INSTRUTOR_ESPECIALIZACAO;
ALTER TABLE INSTRUTOR MODIFY COLUMN INSTRUTOR_NOME VARCHAR(60);
ALTER TABLE INSTRUTOR CHANGE COLUMN MODALIDADE_ENSINA ENSINA_MODALIDADE INT;

ALTER TABLE PAGAMENTO ADD COLUMN PAGAMENTO_TIPO VARCHAR(30);
ALTER TABLE PAGAMENTO DROP COLUMN PAGAMENTO_TIPO;
ALTER TABLE PAGAMENTO MODIFY COLUMN PAGAMENTO_VALOR DECIMAL(12, 3);
ALTER TABLE PAGAMENTO CHANGE COLUMN PAGAMENTO_STATUS STATUS_PAGAMENTO BOOLEAN;

ALTER TABLE ALUNO_PLANO ADD COLUMN DATA_INSCRICAO DATE;
ALTER TABLE ALUNO_PLANO DROP COLUMN DATA_INSCRICAO;
ALTER TABLE ALUNO_PLANO MODIFY COLUMN PLANO_ID INT NOT NULL;
ALTER TABLE ALUNO_PLANO CHANGE COLUMN ALUNO_ID ID_ALUNO INT;

ALTER TABLE ALUNO_AULA ADD COLUMN AULA_PARTICIPACAO CHAR(1);
ALTER TABLE ALUNO_AULA DROP COLUMN AULA_PARTICIPACAO;
ALTER TABLE ALUNO_AULA MODIFY COLUMN AULA_ID INT NOT NULL;
ALTER TABLE ALUNO_AULA CHANGE COLUMN ALUNO_ID ID_ALUNO INT;

ALTER TABLE INSTRUTOR_AULA ADD COLUMN DATA_INICIO DATE;
ALTER TABLE INSTRUTOR_AULA DROP COLUMN DATA_INICIO;
ALTER TABLE INSTRUTOR_AULA MODIFY COLUMN AULA_ID INT NOT NULL;
ALTER TABLE INSTRUTOR_AULA CHANGE COLUMN INSTRUTOR_ID ID_INSTRUTOR INT;

DROP SCHEMA estudo_caso4_cc1n;

