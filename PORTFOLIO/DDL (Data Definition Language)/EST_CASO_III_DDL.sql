CREATE SCHEMA estudo_caso3_CC1N;
USE estudo_caso3_CC1N;

# TABELAS SEM CHAVES ESTRANGEIRAS
CREATE TABLE IF NOT EXISTS CLIENTES(
    CLIENTE_COD INT PRIMARY KEY AUTO_INCREMENT,
    CLIENTE_CNPJ VARCHAR(14) NOT NULL,
    CLIENTE_RATIVIDADE VARCHAR(100),
    CLIENTE_CADASTRAMENTO DATE NOT NULL,
    CLIENTE_CADASTRO VARCHAR(100));

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

CREATE TABLE IF NOT EXISTS TIPO_ENDERECO(
    TIPO_ENDERECO_COD INT PRIMARY KEY AUTO_INCREMENT,
    TIPO_ENDERECO_NOME VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS TIPOS_COMPONENTE(
    TIPOS_COMPONENTE_COD INT PRIMARY KEY AUTO_INCREMENT,
    TIPOS_COMPONENTE_NOME VARCHAR(50) NOT NULL);

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

# TABELAS ASSOCIATIVAS
CREATE TABLE IF NOT EXISTS ENCOMENDAS_CLIENTES(
    ENCOMENDAS_CLIENTES_COD INT PRIMARY KEY AUTO_INCREMENT,
    ENCOMENDAS_NUMERO INT,
    CLIENTE_COD INT,
    FOREIGN KEY (ENCOMENDAS_NUMERO) REFERENCES ENCOMENDAS(ENCOMENDAS_NUMERO),
    FOREIGN KEY (CLIENTE_COD) REFERENCES CLIENTES(CLIENTE_COD));

-- EXEMPLOS DE ALTER TABLE PARA CLIENTES
ALTER TABLE CLIENTES ADD CLIENTE_RAZAO_SOCIAL VARCHAR(100) NOT NULL;
ALTER TABLE CLIENTES DROP COLUMN CLIENTE_CADASTRO;
ALTER TABLE CLIENTES MODIFY COLUMN CLIENTE_CNPJ VARCHAR(18);
ALTER TABLE CLIENTES CHANGE COLUMN CLIENTE_RATIVIDADE CLIENTE_ATIVIDADE VARCHAR(150);

-- EXEMPLOS DE ALTER TABLE PARA PRODUTOS
ALTER TABLE PRODUTOS ADD COLUMN PROD_MATERIAL VARCHAR(50);
ALTER TABLE PRODUTOS DROP COLUMN PROD_DESENHO;
ALTER TABLE PRODUTOS MODIFY COLUMN PROD_PRECO DECIMAL(12,2);
ALTER TABLE PRODUTOS CHANGE COLUMN PROD_TEMP_FABRI PROD_TEMPO_FABRICACAO INT;

-- EXEMPLOS DE ALTER TABLE PARA TIPO_ENDERECO
ALTER TABLE TIPO_ENDERECO ADD COLUMN TIPO_ENDERECO_DESC VARCHAR(100);
ALTER TABLE TIPO_ENDERECO DROP COLUMN TIPO_ENDERECO_DESC;
ALTER TABLE TIPO_ENDERECO MODIFY COLUMN TIPO_ENDERECO_NOME VARCHAR(75);
ALTER TABLE TIPO_ENDERECO CHANGE COLUMN TIPO_ENDERECO_NOME TIPO_END_NOME_COMPLETO VARCHAR(75);

-- EXEMPLOS DE ALTER TABLE PARA TIPOS_COMPONENTE
ALTER TABLE TIPOS_COMPONENTE ADD COLUMN TIPOS_COMPONENTE_DESC VARCHAR(100);
ALTER TABLE TIPOS_COMPONENTE DROP COLUMN TIPOS_COMPONENTE_DESC;
ALTER TABLE TIPOS_COMPONENTE MODIFY COLUMN TIPOS_COMPONENTE_NOME VARCHAR(75);
ALTER TABLE TIPOS_COMPONENTE CHANGE COLUMN TIPOS_COMPONENTE_NOME TIPOS_COMPONENTE_NOMECOMPLETO VARCHAR(150);

-- EXEMPLOS DE ALTER TABLE PARA MAQUINAS
ALTER TABLE MAQUINAS ADD COLUMN MAQUINAS_MODELO VARCHAR(50);
ALTER TABLE MAQUINAS DROP COLUMN MAQUINAS_MODELO;
ALTER TABLE MAQUINAS MODIFY COLUMN MAQUINAS_TEMPO_VIDA DECIMAL(5,2);
ALTER TABLE MAQUINAS CHANGE COLUMN MAQUINAS_DATA_FIM_GARANTIA MAQUINAS_DATA_GARANTIA_FINAL DATE;

-- EXEMPLOS DE ALTER TABLE PARA TELEFONES_CLIENTE
ALTER TABLE TELEFONES_CLIENTE ADD COLUMN TIPO_TELEFONE VARCHAR(20);
ALTER TABLE TELEFONES_CLIENTE DROP COLUMN TIPO_TELEFONE;
ALTER TABLE TELEFONES_CLIENTE MODIFY COLUMN TELEFONE VARCHAR(20);
ALTER TABLE TELEFONES_CLIENTE CHANGE COLUMN TELEFONE TELEFONE_NUMERO VARCHAR(20);

-- EXEMPLOS DE ALTER TABLE PARA ENDERECOS_CLIENTE
ALTER TABLE ENDERECOS_CLIENTE ADD COLUMN PAIS VARCHAR(50);
ALTER TABLE ENDERECOS_CLIENTE DROP COLUMN PAIS;
ALTER TABLE ENDERECOS_CLIENTE MODIFY COLUMN LOGRADOURO VARCHAR(150);
ALTER TABLE ENDERECOS_CLIENTE CHANGE COLUMN ESTADO UF VARCHAR(2);

-- EXEMPLOS DE ALTER TABLE PARA EMPREGADOS
ALTER TABLE EMPREGADOS ADD COLUMN EMPREGADOS_EMAIL VARCHAR(100);
ALTER TABLE EMPREGADOS CHANGE COLUMN EMPREGADOS_CARGO EMPREGADOS_CARGO_ATUAL VARCHAR(50);
ALTER TABLE EMPREGADOS ADD INDEX IDX_EMPREGADO_NOME (EMPREGADOS_NOME);
ALTER TABLE EMPREGADOS DROP COLUMN EMPREGADOS_QUALIFICACOES;

-- EXEMPLOS DE ALTER TABLE PARA TELEFONES_EMPREGADO
ALTER TABLE TELEFONES_EMPREGADO ADD COLUMN TELEFONES_EMPREGADO_TIPO VARCHAR(20);
ALTER TABLE TELEFONES_EMPREGADO CHANGE COLUMN TELEFONE TELEFONE_NUMERO VARCHAR(15);
ALTER TABLE TELEFONES_EMPREGADO ADD INDEX IDX_EMPREGADO_TELEFONE (EMPREGADOS_MATRICULA);
ALTER TABLE TELEFONES_EMPREGADO DROP COLUMN TELEFONES_EMPREGADO_ID;

-- EXEMPLOS DE ALTER TABLE PARA ENDERECOS_EMPRESA
ALTER TABLE ENDERECOS_EMPRESA ADD COLUMN ENDERECOS_EMPRESA_TELEFONE VARCHAR(15);
ALTER TABLE ENDERECOS_EMPRESA CHANGE COLUMN ENDERECOS_EMPRESA_NUMERO ENDERECOS_EMPRESA_NUMERO_COMPLETO VARCHAR(10);
ALTER TABLE ENDERECOS_EMPRESA ADD INDEX IDX_EMPRESA_LOGRADOURO (ENDERECOS_EMPRESA_LOGRADOURO);
ALTER TABLE ENDERECOS_EMPRESA DROP COLUMN ENDERECOS_EMPRESA_COMPLEMENTO;

-- EXEMPLOS DE ALTER TABLE PARA FORNECEDORES
ALTER TABLE FORNECEDORES ADD COLUMN FORNECEDORES_EMAIL VARCHAR(100);
ALTER TABLE FORNECEDORES CHANGE COLUMN FORNECEDORES_RSOCIAL FORNECEDORES_RAZAO_SOCIAL VARCHAR(100);
ALTER TABLE FORNECEDORES ADD INDEX IDX_FORNECEDOR_CNPJ (FORNECEDORES_CNPJ);
ALTER TABLE FORNECEDORES DROP COLUMN FORNECEDORES_PESSOA_CONTATO;

-- EXEMPLOS DE ALTER TABLE PARA ENCOMENDAS
ALTER TABLE ENCOMENDAS ADD COLUMN ENCOMENDAS_STATUS VARCHAR(20);
ALTER TABLE ENCOMENDAS CHANGE COLUMN ENCOMENDAS_VALOR_TOTAL ENCOMENDAS_VALOR_BRUTO DECIMAL(10, 2);
ALTER TABLE ENCOMENDAS ADD INDEX IDX_ENCOMENDAS_DATA (ENCOMENDAS_DATA_INCLUSAO);
ALTER TABLE ENCOMENDAS DROP COLUMN ENCOMENDAS_COD_FORMA_PAGAMENTO;

-- EXEMPLOS DE ALTER TABLE PARA COMPONENTES
ALTER TABLE COMPONENTES ADD COLUMN COMPONENTES_DESCRICAO TEXT;
ALTER TABLE COMPONENTES CHANGE COLUMN COMPONENTES_UNIDADE COMPONENTES_UNIDADE_MEDIDA VARCHAR(20);
ALTER TABLE COMPONENTES ADD INDEX IDX_COMPONENTE_NOME (COMPONENTES_NOME);
ALTER TABLE COMPONENTES DROP COLUMN COMPONENTES_QUANT_ESTOQUE;

-- EXEMPLOS DE ALTER TABLE PARA RE
ALTER TABLE RE ADD COLUMN RE_OBSERVACAO TEXT;
ALTER TABLE RE CHANGE COLUMN RE_HORAS_MAO_OBRA RE_HORAS_MAO_OBRA_TOTAL DECIMAL(10, 2);
ALTER TABLE RE ADD INDEX IDX_RE_PRODUTO (PROD_COD);
ALTER TABLE RE DROP COLUMN RE_UNIDADE;

-- EXEMPLOS DE ALTER TABLE PARA RM
ALTER TABLE RM ADD COLUMN RM_OBSERVACAO TEXT;
ALTER TABLE RM CHANGE COLUMN RM_DESCRICAO RM_NOTAS TEXT;
ALTER TABLE RM ADD INDEX IDX_RM_MAQUINA (MAQUINAS_ID);
ALTER TABLE RM DROP COLUMN RM_COD;

-- EXEMPLOS DE ALTER TABLE PARA RS
ALTER TABLE RS ADD COLUMN RS_OBSERVACAO TEXT;
ALTER TABLE RS CHANGE COLUMN RS_QUANTIDADE RS_QTD_NECESSARIA INT;
ALTER TABLE RS ADD INDEX IDX_RS_COMPONENTE (COMPONENTES_COD);
ALTER TABLE RS DROP COLUMN RS_DATA_NECESSARIA;

-- EXEMPLOS DE ALTER TABLE PARA ENCOMENDAS_CLIENTES
ALTER TABLE ENCOMENDAS_CLIENTES ADD COLUMN DATA_PEDIDO DATE;
ALTER TABLE ENCOMENDAS_CLIENTES DROP COLUMN DATA_PEDIDO;
ALTER TABLE ENCOMENDAS_CLIENTES MODIFY COLUMN CLIENTE_COD INT NOT NULL;
ALTER TABLE ENCOMENDAS_CLIENTES CHANGE COLUMN ENCOMENDAS_NUMERO NUMERO_ENCOMENDA INT;

DROP SCHEMA estudo_caso3_cc1n
