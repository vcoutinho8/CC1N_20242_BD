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

INSERT INTO MODALIDADE (MODALIDADE_ID, MODALIDADE_NOME, MODALIDADE_DESCRICAO, MODALIDADE_CAPACIDADE) VALUES (1, 'Yoga', 'Aula de relaxamento e flexibilidade', 20);
INSERT INTO MODALIDADE (MODALIDADE_ID, MODALIDADE_NOME, MODALIDADE_DESCRICAO, MODALIDADE_CAPACIDADE) VALUES (2, 'Pilates', 'Aula de fortalecimento do core', 15);
INSERT INTO MODALIDADE (MODALIDADE_ID, MODALIDADE_NOME, MODALIDADE_DESCRICAO, MODALIDADE_CAPACIDADE) VALUES (3, 'CrossFit', 'Treinamento de alta intensidade', 25);
INSERT INTO MODALIDADE (MODALIDADE_ID, MODALIDADE_NOME, MODALIDADE_DESCRICAO, MODALIDADE_CAPACIDADE) VALUES (4, 'Spinning', 'Aula de ciclismo indoor', 30);
INSERT INTO MODALIDADE (MODALIDADE_ID, MODALIDADE_NOME, MODALIDADE_DESCRICAO, MODALIDADE_CAPACIDADE) VALUES (5, 'Zumba', 'Dança com foco em queima calórica', 20);

INSERT INTO PLANO_DE_TREINAMENTO (PLANO_ID, PLANO_DESCRICAO, PLANO_DATA_CRIACAO, PLANO_DATA_ATUALIZACAO) VALUES (1, 'Plano Semestral', '2024-01-01', '2024-01-01');
INSERT INTO PLANO_DE_TREINAMENTO (PLANO_ID, PLANO_DESCRICAO, PLANO_DATA_CRIACAO, PLANO_DATA_ATUALIZACAO) VALUES (2, 'Plano Anual', '2024-01-01', '2024-01-01');
INSERT INTO PLANO_DE_TREINAMENTO (PLANO_ID, PLANO_DESCRICAO, PLANO_DATA_CRIACAO, PLANO_DATA_ATUALIZACAO) VALUES (3, 'Plano Mensal', '2024-01-01', '2024-01-01');
INSERT INTO PLANO_DE_TREINAMENTO (PLANO_ID, PLANO_DESCRICAO, PLANO_DATA_CRIACAO, PLANO_DATA_ATUALIZACAO) VALUES (4, 'Plano Trimestral', '2024-01-01', '2024-01-01');
INSERT INTO PLANO_DE_TREINAMENTO (PLANO_ID, PLANO_DESCRICAO, PLANO_DATA_CRIACAO, PLANO_DATA_ATUALIZACAO) VALUES (5, 'Plano Especial', '2024-01-01', '2024-01-01');

INSERT INTO AULA (AULA_ID, AULA_HORARIO, AULA_CAPACIDADE) VALUES (1, '08:00:00', 20);
INSERT INTO AULA (AULA_ID, AULA_HORARIO, AULA_CAPACIDADE) VALUES (2, '10:00:00', 25);
INSERT INTO AULA (AULA_ID, AULA_HORARIO, AULA_CAPACIDADE) VALUES (3, '15:00:00', 20);
INSERT INTO AULA (AULA_ID, AULA_HORARIO, AULA_CAPACIDADE) VALUES (4, '18:00:00', 15);
INSERT INTO AULA (AULA_ID, AULA_HORARIO, AULA_CAPACIDADE) VALUES (5, '20:00:00', 30);

INSERT INTO ALUNO (ALUNO_ID, ALUNO_NOME, ALUNO_CPF, ALUNO_DATA_NASCIMENTO, ALUNO_ESTADO, ALUNO_CIDADE, ALUNO_RUA, ALUNO_NUMRUA, ALUNO_CEP, MODALIDADE_INTERESSE) VALUES (1, 'João Silva', '12345678901', '2000-01-01', 'ES', 'Guarapari', 'Rua A', 10, '29100000', 1);
INSERT INTO ALUNO (ALUNO_ID, ALUNO_NOME, ALUNO_CPF, ALUNO_DATA_NASCIMENTO, ALUNO_ESTADO, ALUNO_CIDADE, ALUNO_RUA, ALUNO_NUMRUA, ALUNO_CEP, MODALIDADE_INTERESSE) VALUES (2, 'Maria Souza', '23456789012', '1999-02-02', 'ES', 'Vila Velha', 'Rua B', 20, '29100111', 2);
INSERT INTO ALUNO (ALUNO_ID, ALUNO_NOME, ALUNO_CPF, ALUNO_DATA_NASCIMENTO, ALUNO_ESTADO, ALUNO_CIDADE, ALUNO_RUA, ALUNO_NUMRUA, ALUNO_CEP, MODALIDADE_INTERESSE) VALUES (3, 'Pedro Oliveira', '34567890123', '1998-03-03', 'ES', 'Vitória', 'Rua C', 30, '29100222', 3);
INSERT INTO ALUNO (ALUNO_ID, ALUNO_NOME, ALUNO_CPF, ALUNO_DATA_NASCIMENTO, ALUNO_ESTADO, ALUNO_CIDADE, ALUNO_RUA, ALUNO_NUMRUA, ALUNO_CEP, MODALIDADE_INTERESSE) VALUES (4, 'Ana Costa', '45678901234', '2001-04-04', 'ES', 'Cariacica', 'Rua D', 40, '29100333', 4);
INSERT INTO ALUNO (ALUNO_ID, ALUNO_NOME, ALUNO_CPF, ALUNO_DATA_NASCIMENTO, ALUNO_ESTADO, ALUNO_CIDADE, ALUNO_RUA, ALUNO_NUMRUA, ALUNO_CEP, MODALIDADE_INTERESSE) VALUES (5, 'Lucas Pereira', '56789012345', '2002-05-05', 'ES', 'Serra', 'Rua E', 50, '29100444', 5);

INSERT INTO INSTRUTOR (INSTRUTOR_ID, INSTRUTOR_NOME, MODALIDADE_ENSINA) VALUES (1, 'Carlos Silva', 1);
INSERT INTO INSTRUTOR (INSTRUTOR_ID, INSTRUTOR_NOME, MODALIDADE_ENSINA) VALUES (2, 'Mariana Souza', 2);
INSERT INTO INSTRUTOR (INSTRUTOR_ID, INSTRUTOR_NOME, MODALIDADE_ENSINA) VALUES (3, 'Rafael Dias', 3);
INSERT INTO INSTRUTOR (INSTRUTOR_ID, INSTRUTOR_NOME, MODALIDADE_ENSINA) VALUES (4, 'Carla Nogueira', 4);
INSERT INTO INSTRUTOR (INSTRUTOR_ID, INSTRUTOR_NOME, MODALIDADE_ENSINA) VALUES (5, 'Paula Lima', 5);

INSERT INTO PAGAMENTO (PAGAMENTO_ID, PAGAMENTO_DATA, PAGAMENTO_VALOR, PAGAMENTO_STATUS, ALUNO_ID) VALUES (1, '2024-01-15', 100.500, TRUE, 1);
INSERT INTO PAGAMENTO (PAGAMENTO_ID, PAGAMENTO_DATA, PAGAMENTO_VALOR, PAGAMENTO_STATUS, ALUNO_ID) VALUES (2, '2024-02-15', 200.750, TRUE, 2);
INSERT INTO PAGAMENTO (PAGAMENTO_ID, PAGAMENTO_DATA, PAGAMENTO_VALOR, PAGAMENTO_STATUS, ALUNO_ID) VALUES (3, '2024-03-15', 150.000, FALSE, 3);
INSERT INTO PAGAMENTO (PAGAMENTO_ID, PAGAMENTO_DATA, PAGAMENTO_VALOR, PAGAMENTO_STATUS, ALUNO_ID) VALUES (4, '2024-04-15', 300.250, TRUE, 4);
INSERT INTO PAGAMENTO (PAGAMENTO_ID, PAGAMENTO_DATA, PAGAMENTO_VALOR, PAGAMENTO_STATUS, ALUNO_ID) VALUES (5, '2024-05-15', 400.000, FALSE, 5);

INSERT INTO ALUNO_PLANO (ALUNO_ID, PLANO_ID) VALUES (1, 1);
INSERT INTO ALUNO_PLANO (ALUNO_ID, PLANO_ID) VALUES (2, 2);
INSERT INTO ALUNO_PLANO (ALUNO_ID, PLANO_ID) VALUES (3, 3);
INSERT INTO ALUNO_PLANO (ALUNO_ID, PLANO_ID) VALUES (4, 4);
INSERT INTO ALUNO_PLANO (ALUNO_ID, PLANO_ID) VALUES (5, 5);

INSERT INTO ALUNO_AULA (ALUNO_ID, AULA_ID) VALUES (1, 1);
INSERT INTO ALUNO_AULA (ALUNO_ID, AULA_ID) VALUES (2, 2);
INSERT INTO ALUNO_AULA (ALUNO_ID, AULA_ID) VALUES (3, 3);
INSERT INTO ALUNO_AULA (ALUNO_ID, AULA_ID) VALUES (4, 4);
INSERT INTO ALUNO_AULA (ALUNO_ID, AULA_ID) VALUES (5, 5);

INSERT INTO INSTRUTOR_AULA (INSTRUTOR_ID, AULA_ID) VALUES (1, 1);
INSERT INTO INSTRUTOR_AULA (INSTRUTOR_ID, AULA_ID) VALUES (2, 2);
INSERT INTO INSTRUTOR_AULA (INSTRUTOR_ID, AULA_ID) VALUES (3, 3);
INSERT INTO INSTRUTOR_AULA (INSTRUTOR_ID, AULA_ID) VALUES (4, 4);
INSERT INTO INSTRUTOR_AULA (INSTRUTOR_ID, AULA_ID) VALUES (5, 5);

UPDATE MODALIDADE SET MODALIDADE_CAPACIDADE = 22 WHERE MODALIDADE_ID = 1;
UPDATE MODALIDADE SET MODALIDADE_NOME = 'Yoga Avançado' WHERE MODALIDADE_ID = 1;

UPDATE PLANO_DE_TREINAMENTO SET PLANO_DESCRICAO = 'Plano Bimestral' WHERE PLANO_ID = 1;
UPDATE PLANO_DE_TREINAMENTO SET PLANO_DATA_ATUALIZACAO = '2024-02-01' WHERE PLANO_ID = 1;

UPDATE AULA SET AULA_CAPACIDADE = 25 WHERE AULA_ID = 1;
UPDATE AULA SET AULA_HORARIO = '09:00:00' WHERE AULA_ID = 1;

UPDATE ALUNO SET ALUNO_CIDADE = 'Vitória' WHERE ALUNO_ID = 1;
UPDATE ALUNO SET ALUNO_RUA = 'Rua Nova' WHERE ALUNO_ID = 1;

UPDATE INSTRUTOR SET INSTRUTOR_NOME = 'Carlos Mendes' WHERE INSTRUTOR_ID = 1;
UPDATE INSTRUTOR SET MODALIDADE_ENSINA = 2 WHERE INSTRUTOR_ID = 1;

UPDATE PAGAMENTO SET PAGAMENTO_STATUS = FALSE WHERE PAGAMENTO_ID = 1;
UPDATE PAGAMENTO SET PAGAMENTO_VALOR = 105.000 WHERE PAGAMENTO_ID = 1;

UPDATE ALUNO_PLANO SET PLANO_ID = 2 WHERE ALUNO_ID = 1;
UPDATE ALUNO_PLANO SET ALUNO_ID = 2 WHERE PLANO_ID = 1;

UPDATE ALUNO_AULA SET AULA_ID = 2 WHERE ALUNO_ID = 1;
UPDATE ALUNO_AULA SET ALUNO_ID = 2 WHERE AULA_ID = 1;

UPDATE INSTRUTOR_AULA SET AULA_ID = 2 WHERE INSTRUTOR_ID = 1;
UPDATE INSTRUTOR_AULA SET INSTRUTOR_ID = 2 WHERE AULA_ID = 1;

DELETE FROM PAGAMENTO WHERE PAGAMENTO_ID = 5;


