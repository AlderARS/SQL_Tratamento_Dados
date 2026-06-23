# 🧹 SQL Data Cleaning Project

![MySQL](https://img.shields.io/badge/MySQL-8.0+-blue)
![SQL](https://img.shields.io/badge/SQL-Data%20Cleaning-orange)
![Status](https://img.shields.io/badge/Status-Concluído-success)

## 📖 Sobre o Projeto

Este projeto demonstra a aplicação de técnicas de **Data Cleaning** e **Data Quality** utilizando SQL no MySQL.

O objetivo foi transformar uma base de dados bruta contendo inconsistências, formatos divergentes e valores inválidos em um conjunto de dados padronizado e pronto para análises e processos de Business Intelligence.

O projeto simula um cenário real de tratamento de dados de clientes e vendas, abordando problemas frequentemente encontrados em ambientes corporativos.

---

# 🎯 Objetivos

* Identificar inconsistências em dados brutos.
* Padronizar formatos de texto, datas e contatos.
* Corrigir registros inválidos.
* Tratar valores nulos e inconsistentes.
* Criar uma tabela final pronta para análise.
* Aplicar boas práticas de qualidade de dados utilizando SQL.

---

# 🗂️ Estrutura da Base de Dados

## Tabela Original

### 📋 vendas_clientes_raw

Contém informações brutas de clientes e vendas.

Campos:

| Coluna        | Descrição                 |
| ------------- | ------------------------- |
| id            | Identificador do cliente  |
| nome          | Nome do cliente           |
| email         | Endereço de e-mail        |
| telefone      | Número de telefone        |
| data_cadastro | Data de cadastro          |
| cidade        | Cidade do cliente         |
| estado        | Estado                    |
| renda_mensal  | Renda mensal declarada    |
| valor_compra  | Valor da compra realizada |
| data_compra   | Data da compra            |
| produto       | Produto adquirido         |

---

# 🔍 Problemas Encontrados

A base de dados continha diversos problemas comuns em ambientes reais:

### 📧 E-mails

* Domínios incompletos
* Valores ausentes

Exemplo:

```text id="r4owm8"
maria@gmail
```

Transformado para:

```text id="8f1xhb"
maria@gmail.com
```

---

### 📱 Telefones

Problemas identificados:

* Formatos diferentes
* Espaços e caracteres extras
* Valores inválidos

Exemplo:

```text id="u0o7ee"
73 99999-1111
```

Transformado para:

```text id="vnv64m"
(73)99999-1111
```

---

### 📅 Datas

A base possuía múltiplos formatos:

```text id="p7qqxa"
2023-01-10
10/02/2023
2023/03/15
15-04-2023
```

Todos foram convertidos para o padrão:

```text id="5jtx3w"
YYYY-MM-DD
```

---

### 🌎 Localização

Padronização de:

* Cidade
* Estado

Exemplos:

```text id="fjlwmc"
jequie
JEQUIÉ
SALVADOR
Ba
```

Transformados para:

```text id="d6tt8r"
Jequie
Salvador
BA
```

---

### 💰 Campos Numéricos

Problemas encontrados:

* Uso de vírgula e ponto misturados
* Valores inválidos
* Strings em campos numéricos

Exemplos:

```text id="3zq02k"
3000,50
abc
NaN
```

Após tratamento:

```text id="5du9cu"
3000.50
NULL
NULL
```

---

# 🛠️ Técnicas Aplicadas

## ✍️ Padronização de Texto

* INITCAP()
* UPPER()
* CONCAT()

---

## 🔍 Validação de Dados

* REGEXP_LIKE()
* CASE WHEN
* Tratamento de valores inválidos

---

## 📅 Conversão de Datas

* STR_TO_DATE()

Conversão automática de múltiplos formatos para padrão único.

---

## 📞 Padronização de Telefones

* REPLACE()
* SUBSTRING()
* CONCAT()

---

## 💰 Conversão de Valores Monetários

* CAST()
* REPLACE()

Transformação de strings em valores numéricos.

---

# 📊 Resultado Final

Foi criada uma nova tabela:

### ✅ vendas_clientes_trat

A tabela final contém:

* Dados padronizados
* Formatos consistentes
* Valores inválidos corrigidos ou removidos
* Campos prontos para análises e dashboards

---

# 🚀 Como Executar

## 1️⃣ Criar o Schema

```sql id="n7xuhm"
CREATE SCHEMA tratamento;
USE tratamento;
```

## 2️⃣ Criar a Tabela Bruta

Execute o script contendo:

```sql id="e5a5v4"
CREATE TABLE vendas_clientes_raw (...);
```

## 3️⃣ Inserir os Dados

```sql id="g4jpy6"
INSERT INTO vendas_clientes_raw VALUES (...);
```

## 4️⃣ Executar os Scripts de Tratamento

Os tratamentos incluem:

* E-mails
* Telefones
* Datas
* Cidades
* Estados
* Valores monetários

## 5️⃣ Gerar a Tabela Tratada

```sql id="i3l5pv"
CREATE TABLE vendas_clientes_trat AS
SELECT ...
```

---

# 📈 Competências Demonstradas

✅ SQL para Data Cleaning

✅ Data Quality

✅ Tratamento de Dados

✅ Padronização de Informações

✅ Validação de Registros

✅ Transformação de Dados

✅ Engenharia de Dados

✅ Business Intelligence

---

# 🛠️ Tecnologias Utilizadas

| Tecnologia | Finalidade                           |
| ---------- | ------------------------------------ |
| 🐬 MySQL   | Banco de Dados                       |
| 📜 SQL     | Tratamento e transformação dos dados |

---

# 💡 Principais Aprendizados

Durante o desenvolvimento deste projeto foram aplicados conceitos amplamente utilizados em processos de ETL e Engenharia de Dados, incluindo padronização de dados, validação de registros, limpeza de inconsistências e preparação de bases para análises e dashboards.

---

# 👨‍💻 Autor

**AlderARS**

Projeto desenvolvido para prática de Data Cleaning, Data Quality e Engenharia de Dados utilizando SQL e MySQL.

⭐ Se este projeto foi útil para você, considere deixar uma estrela no repositório.
