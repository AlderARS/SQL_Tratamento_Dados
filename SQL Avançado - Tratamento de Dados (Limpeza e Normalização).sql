CREATE SCHEMA tratamento;
USE tratamento;

CREATE TABLE vendas_clientes_raw (
    id VARCHAR(10),
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20),
    data_cadastro VARCHAR(20),
    cidade VARCHAR(50),
    estado VARCHAR(5),
    renda_mensal VARCHAR(20),
    valor_compra VARCHAR(20),
    data_compra VARCHAR(20),
    produto VARCHAR(50)
);

INSERT INTO vendas_clientes_raw VALUES
('001', 'João Silva', 'joao@gmail.com', '73999990000', '2023-01-10', 'Jequié', 'BA', '2500', '199.90', '2023-02-01', 'Notebook'),
('002', 'Maria Souza', 'maria@gmail', '73 99999-1111', '10/02/2023', 'jequie', 'ba', '3000,50', '89,90', '01-03-2023', 'Mouse'),
('003', 'Carlos Lima', NULL, '73988887777', '2023/03/15', 'Salvador', 'BA', NULL, '150.00', '2023-03-20', 'Teclado'),
('004', 'Ana Clara', 'ana@gmail.com', NULL, '15-04-2023', 'SALVADOR', 'Ba', '4000', '299.99', '2023-04-18', 'Monitor'),
('005', 'Pedro Santos', 'pedro@gmail.com', '73977776666', '2023-05-01', 'Feira de Santana', 'BA', '3500', 'abc', '2023-05-05', 'Notebook'),
('006', 'João Silva', 'joao@gmail.com', '73999990000', '2023-01-10', 'Jequié', 'BA', '2500', '199.90', '2023-02-01', 'Notebook'),
('007', 'Fernanda Alves', 'fernanda@gmail.com', '73966665555', '2023-06-12', 'Vitoria da Conquista', 'BA', '2800', '120.50', '2023-06-15', 'Mouse'),
('008', 'Lucas Rocha', 'lucas@gmail.com', '73955554444', '2023-07-20', 'Jequié', 'BA', 'NaN', '75.00', '2023-07-25', 'Teclado'),
('009', 'Bruna Costa', 'bruna@gmail.com', 'erro', '2023-08-05', 'Salvador', 'BA', '3200', '200.00', '2023-08-10', 'Monitor'),
('010', 'Ricardo Mendes', 'ricardo@gmail.com', '73944443333', '', 'Ilheus', 'BA', '2900', '180.00', '2023-09-01', 'Notebook');

-- Apenas a primeira letra de cada palavra maiúscula em cada cidade
SELECT initcap(cidade) AS cidade_trat FROM vendas_clientes_raw; -- tabela cidade

-- Ambas as lebras maiusculas na sigla do estado
SELECT UPPER(estado) AS estado_trat FROM vendas_clientes_raw; -- tabela estado

-- Excluir valores string misturados com numericos e substituir virgula por ponto
SELECT CASE
	WHEN REGEXP_LIKE(valor_compra, '^[0-9.,]+$')
		THEN CAST(REPLACE(valor_compra, ',', '.') AS DECIMAL(10,2))
    ELSE NULL
END AS valor_compra_trat,
CASE
	WHEN REGEXP_LIKE(renda_mensal, '^[0-9.,]+$')
		THEN CAST(REPLACE(renda_mensal, ',', '.') AS DECIMAL(10,2))
    ELSE NULL
END AS renda_mensal_trat
FROM vendas_clientes_raw;
    
SELECT CASE -- Adicionar .com quando estiver faltando
	WHEN email LIKE '%.com' THEN email
    ELSE CONCAT(email, '.com')
END AS email_trat
FROM vendas_clientes_raw;

-- padronizar os 4 tipos de data ano-mes-dia; dia-mes-ano; dia/mes/ano; ano/mes/dia em apenas ano-mes-dia
SELECT CASE
	WHEN data_cadastro IS NULL OR data_cadastro = "" THEN NULL
	WHEN data_cadastro LIKE '____-__-__' THEN STR_TO_DATE(data_cadastro, '%Y-%m-%d')
    WHEN data_cadastro LIKE '__-__-____' THEN STR_TO_DATE(data_cadastro, '%d-%m-%Y')
    WHEN data_cadastro LIKE '____/__/__' THEN STR_TO_DATE(data_cadastro, '%Y/%m/%d')
    WHEN data_cadastro LIKE '__/__/____' THEN STR_TO_DATE(data_cadastro, '%d/%m/%Y')
END AS data_cadastro_trat,
CASE
	WHEN data_compra IS NULL OR data_compra = "" THEN NULL
	WHEN data_compra LIKE '____-__-__' THEN STR_TO_DATE(data_compra, '%Y-%m-%d')
    WHEN data_compra LIKE '__-__-____' THEN STR_TO_DATE(data_compra, '%d-%m-%Y')
    WHEN data_compra LIKE '____/__/__' THEN STR_TO_DATE(data_compra, '%Y/%m/%d')
    WHEN data_compra LIKE '__/__/____' THEN STR_TO_DATE(data_compra, '%d/%m/%Y')
END AS data_compra_trat
FROM vendas_clientes_raw;

-- adicionar parenteses no ddd do telefone e um hifen apos os 5 proximos numeros
WITH telefone_1 AS (
SELECT REPLACE(REPLACE(telefone, " ", ""), "-", "") AS telefone
FROM vendas_clientes_raw
) SELECT CONCAT('(', SUBSTRING(telefone, 1, 2), ')', SUBSTRING(telefone, 3, 5), "-", SUBSTRING(telefone, 8, 4)) AS telefone_trat
FROM telefone_1;


-- SALVANDO TODO O TRATAMENTO EM UMA NOVA TABELA
CREATE TABLE vendas_clientes_trat AS -- Salvando o tratamento em uma nova tabela
SELECT id, nome, 
CASE -- coluna email
	WHEN email LIKE '%.com' THEN email
    ELSE CONCAT(email, '.com')
END AS email_trat,
 CASE -- coluna telefone
	WHEN telefone IS NULL OR telefone = '' OR telefone REGEXP '[A-Za-z]' THEN NULL
	ELSE CONCAT( '(', SUBSTRING(REPLACE(REPLACE(telefone, ' ', ''), '-', ''), 1, 2), ')',
		SUBSTRING(REPLACE(REPLACE(telefone, ' ', ''), '-', ''), 3, 5), '-',
		SUBSTRING(REPLACE(REPLACE(telefone, ' ', ''), '-', ''), 8, 4))
    END AS telefone_trat,
CASE -- coluna data_cadastro
	WHEN data_cadastro IS NULL OR data_cadastro = "" THEN NULL
	WHEN data_cadastro LIKE '____-__-__' THEN STR_TO_DATE(data_cadastro, '%Y-%m-%d')
    WHEN data_cadastro LIKE '__-__-____' THEN STR_TO_DATE(data_cadastro, '%d-%m-%Y')
    WHEN data_cadastro LIKE '____/__/__' THEN STR_TO_DATE(data_cadastro, '%Y/%m/%d')
    WHEN data_cadastro LIKE '__/__/____' THEN STR_TO_DATE(data_cadastro, '%d/%m/%Y')
END AS data_cadastro_trat,
initcap(cidade) AS cidade_trat, -- coluna cidade -- UDF utilizada
UPPER(estado) AS estado_trat, -- coluna estado
CASE -- coluna renda_mensal
	WHEN REGEXP_LIKE(renda_mensal, '^[0-9.,]+$')
		THEN CAST(REPLACE(renda_mensal, ',', '.') AS DECIMAL(10,2))
    ELSE NULL
END AS renda_mensal_trat,
    CASE -- coluna valor_compra
	WHEN REGEXP_LIKE(valor_compra, '^[0-9.,]+$')
		THEN CAST(REPLACE(valor_compra, ',', '.') AS DECIMAL(10,2))
    ELSE NULL
END AS valor_compra_trat,
CASE -- coluna data_compra
	WHEN data_compra IS NULL OR data_compra = "" THEN NULL
	WHEN data_compra LIKE '____-__-__' THEN STR_TO_DATE(data_compra, '%Y-%m-%d')
    WHEN data_compra LIKE '__-__-____' THEN STR_TO_DATE(data_compra, '%d-%m-%Y')
    WHEN data_compra LIKE '____/__/__' THEN STR_TO_DATE(data_compra, '%Y/%m/%d')
    WHEN data_compra LIKE '__/__/____' THEN STR_TO_DATE(data_compra, '%d/%m/%Y')
END AS data_compra_trat,
produto
FROM vendas_clientes_raw;

SELECT * FROM vendas_clientes_raw;
SELECT * FROM vendas_clientes_trat;