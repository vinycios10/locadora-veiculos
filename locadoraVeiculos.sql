-- ============================================================
-- BANCO DE DADOS - LOCADORA DE VEÍCULOS
-- SGBD: PostgreSQL
-- ============================================================


-- ============================================================
-- 1. CRIAÇÃO DOS TIPOS
-- ============================================================

CREATE TYPE ENDERECO AS (
    CEP CHAR(8),
    Rua VARCHAR(40),
    Numero INT,
    Cidade VARCHAR(40),
    Estado VARCHAR(30)
);


-- ============================================================
-- 2. CRIAÇÃO DAS TABELAS
-- ============================================================

-- ------------------------------------------------------------
-- Tabela: Cliente
-- ------------------------------------------------------------

CREATE TABLE Cliente (
    CPF CHAR(11) PRIMARY KEY,
    Nome VARCHAR(40) NOT NULL,
    DataNascimento DATE NOT NULL,
    Whastapp CHAR(11) NOT NULL,
    Endereco ENDERECO NOT NULL,

    CHECK (
        EXTRACT(
            YEAR FROM AGE(NOW(), DataNascimento)
        ) >= 18
    ),

    CHECK (
        LENGTH(CPF) = 11
    )
);


-- ------------------------------------------------------------
-- Tabela: Seguradora
-- ------------------------------------------------------------

CREATE TABLE Seguradora (
    CNPJ CHAR(14) PRIMARY KEY,
    NomeSeguradora VARCHAR(40) NOT NULL,
    Endereco ENDERECO NOT NULL,

    CHECK (
        LENGTH(CNPJ) = 14
    )
);


-- ------------------------------------------------------------
-- Tabela: Carro
-- ------------------------------------------------------------

CREATE TABLE Carro (
    Placa CHAR(7) PRIMARY KEY,
    Fabricante VARCHAR(20) NOT NULL,
    Modelo VARCHAR(20) NOT NULL,
    Cor VARCHAR(20) NOT NULL,
    ValorDiaria FLOAT NOT NULL,
    DataInicio DATE NOT NULL,
    DataFim DATE NOT NULL,

    CNPJ_Seguradora CHAR(14) NOT NULL,
    CPF_Cliente CHAR(11) NOT NULL,

    CONSTRAINT fkSeguradora
        FOREIGN KEY (CNPJ_Seguradora)
        REFERENCES Seguradora(CNPJ)
        ON UPDATE CASCADE,

    CONSTRAINT fkCliente
        FOREIGN KEY (CPF_Cliente)
        REFERENCES Cliente(CPF)
        ON UPDATE CASCADE
);


-- ------------------------------------------------------------
-- Tabela: Historico_Aluguel
-- ------------------------------------------------------------

CREATE TABLE Historico_Aluguel (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    placa_h CHAR(7),
    fabricante_h VARCHAR(20),
    modelo_h VARCHAR(20),
    cor_h VARCHAR(20),
    valor_diaria_h FLOAT,
    data_inicio_h DATE,
    data_fim_h DATE,
    cpf_cliente_h CHAR(11)
);


-- ============================================================
-- 3. INSERÇÃO DE DADOS (INSERT)
-- ============================================================

-- ------------------------------------------------------------
-- Inserção de clientes
-- ------------------------------------------------------------

INSERT INTO Cliente
VALUES (
    '12345678901',
    'Caio',
    '1990-02-01',
    '74912345678',
    ROW(
        '49402',
        'rua w',
        120,
        'jua',
        'ba'
    )
);

INSERT INTO Cliente
VALUES (
    '11111111111',
    'HUGUINHO',
    '1980-03-10',
    '87999998881',
    ROW(
        '25660000',
        'RUA 1',
        1,
        'JUAZEIRO',
        'BAHIA'
    )
);

INSERT INTO Cliente
VALUES (
    '11111111112',
    'HUGUINHO',
    '1985-10-15',
    '87999998882',
    ROW(
        '27660100',
        'RUA DAS FLORES',
        25,
        'ITAINÓPOLIS',
        'PIAUÍ'
    )
);

INSERT INTO Cliente
VALUES (
    '11111111113',
    'ZEZINHO',
    '1990-09-25',
    '87999998883',
    ROW(
        '25760100',
        'RUA DAS DÍVIDAS',
        30,
        'AFRÂNIO',
        'PERNAMBUCO'
    )
);

INSERT INTO Cliente
VALUES (
    '11111111114',
    'PATINHAS',
    '1990-09-26',
    '87999998884',
    ROW(
        '25767111',
        'RUA DO SOL',
        47,
        'BELÉM',
        'PARÁ'
    )
);

INSERT INTO Cliente
VALUES (
    '11111111115',
    'PARDAL',
    '1995-10-05',
    '87999998885',
    ROW(
        '25767555',
        'RUA DAS VASSOURAS',
        100,
        'ÁTOMO',
        'LÍQUIDO'
    )
);

INSERT INTO Cliente
VALUES (
    '11111111116',
    'DONALD',
    '1960-10-05',
    '87999998886',
    ROW(
        '25767234',
        'RUA DOS FOFOQUEIROS',
        134,
        'MYCITY',
        'MYSTATE'
    )
);

INSERT INTO Cliente
VALUES (
    '11111111117',
    'PATILDA',
    '1997-10-10',
    '87999998887',
    ROW(
        '25766533',
        'RUA DOS EMIRADOS',
        190,
        'SAUDITAS',
        'ZARÁBIAS'
    )
);


-- ------------------------------------------------------------
-- Inserção de seguradoras
-- ------------------------------------------------------------

INSERT INTO Seguradora
VALUES (
    '11111111111111',
    'SEGURADORA A LTDA',
    ROW(
        '78956000',
        'RUA 10',
        785,
        'JEQUIÉ',
        'BAHIA'
    )
);

INSERT INTO Seguradora
VALUES (
    '11111111111112',
    'SEGURADORA B LTDA',
    ROW(
        '88955600',
        'RUA COHAB',
        75,
        'PETROLINA',
        'PERNAMBUCO'
    )
);


-- ------------------------------------------------------------
-- Inserção de carro
-- ------------------------------------------------------------

INSERT INTO Carro
VALUES (
    'A5458TJ',
    'FORD',
    'FIESTA',
    'AZUL PEROLIZADO',
    80.50,
    '2022-04-09',
    '2022-04-20',
    '11111111111112',
    '11111111112'
);


-- ============================================================
-- 4. ATUALIZAÇÃO DE DADOS (UPDATE)
-- ============================================================

UPDATE Cliente
SET Nome = 'CREOSVALDA'
WHERE CPF = '11111111112';

UPDATE Cliente
SET Endereco.CEP = '45896321'
WHERE CPF = '11111111115';


-- ============================================================
-- 5. EXCLUSÃO DE DADOS (DELETE)
-- ============================================================

DELETE FROM Cliente
WHERE CPF = '11111111115';

DELETE FROM Cliente
WHERE CPF = '11111111113';


-- ============================================================
-- 6. CONSULTAS (SELECT)
-- ============================================================

SELECT *
FROM Cliente
WHERE CPF = '11111111112';

SELECT *
FROM Carro
WHERE Cor LIKE 'AZUL%';

SELECT *
FROM Carro
WHERE Cor = UPPER('azul perolizado');

SELECT CPF, DataNascimento, Endereco
FROM Cliente
WHERE Nome = INITCAP('CAIO');

SELECT COUNT(*)
FROM Cliente;

SELECT (Endereco).CEP
FROM Seguradora
WHERE CNPJ = '11111111111111';

SELECT *
FROM Cliente
WHERE (Endereco).Estado = SUBSTR('bahia', 1, 2);

SELECT *
FROM Cliente
WHERE LENGTH((Endereco).Estado) = 5;

SELECT *
FROM Cliente
ORDER BY Nome;

SELECT *
FROM Cliente
ORDER BY Nome DESC;

SELECT DataNascimento, Nome
FROM Cliente
GROUP BY DataNascimento, Nome;

SELECT (Endereco).Estado, COUNT(*)
FROM Cliente
GROUP BY (Endereco).Estado
HAVING (Endereco).Estado = 'PERNAMBUCO';


-- ============================================================
-- 7. FUNCTIONS
-- ============================================================

-- Function: DIASRESTANTES
-- Retorna o número de dias restantes da locação de um carro.

CREATE OR REPLACE FUNCTION DIASRESTANTES(char(11))
RETURNS SETOF INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        DataFim - CURRENT_DATE AS "DIAS RESTANTES"
    FROM Carro
    WHERE CPF_Cliente = $1;
END;
$$;

SELECT DIASRESTANTES('11111111112');


-- Function: func_historico
-- Gera o histórico das alterações de aluguel.

CREATE OR REPLACE FUNCTION func_historico()
RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.DataFim <> OLD.DataFim THEN

        INSERT INTO Historico_Aluguel (
            placa_h,
            fabricante_h,
            modelo_h,
            cor_h,
            valor_diaria_h,
            data_inicio_h,
            data_fim_h,
            cpf_cliente_h
        )
        VALUES (
            NEW.Placa,
            NEW.Fabricante,
            NEW.Modelo,
            NEW.Cor,
            NEW.ValorDiaria,
            NEW.DataInicio,
            NEW.DataFim,
            NEW.CPF_Cliente
        );

    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;


-- ============================================================
-- 8. PROCEDURES
-- ============================================================

-- Procedure: APAGA_CLIENTE
-- Remove um cliente da tabela Cliente.

CREATE OR REPLACE PROCEDURE APAGA_CLIENTE(char(11))
LANGUAGE plpgsql
AS $$
BEGIN

    DELETE FROM Cliente
    WHERE CPF = $1;

END;
$$;

CALL APAGA_CLIENTE('11111111117');


-- Procedure: AlterarNomeSeguradora
-- Altera o nome de uma seguradora.

CREATE OR REPLACE PROCEDURE AlterarNomeSeguradora(
    char(14),
    varchar(40)
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE Seguradora
    SET NomeSeguradora = $2
    WHERE CNPJ = $1;

END;
$$;

CALL AlterarNomeSeguradora(
    '11111111111111',
    'SEGURADORA BAHIA'
);


-- ============================================================
-- 9. TRIGGERS
-- ============================================================

-- Trigger: gat_gera_historico
-- Auxilia na geração do histórico de aluguéis.

CREATE OR REPLACE TRIGGER gat_gera_historico
AFTER UPDATE OF CPF_Cliente
ON Carro
FOR EACH ROW
EXECUTE FUNCTION func_historico();
