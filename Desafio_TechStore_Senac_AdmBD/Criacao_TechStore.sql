use master
GO
create database TechStore
GO
use TechStore
GO

--create table Categorias(
--	ID_CATEGORIA INT PRIMARY KEY NOT NULL,
--	NOME_CATEGORIA VARCHAR(100) NOT NULL
--);

--create table Produtos(
--	ID_PRODUTO INT PRIMARY KEY NOT NULL,
--	NOME_PRODUTO VARCHAR(200) NOT NULL,
--	PRECO_PRODUTO NUMERIC NOT NULL,
--	Q_ESTOQUE INT NOT NULL,
--	ID_CATEGORIA INT NOT NULL,
--CONSTRAINT fk_categorias_produtos foreign key (ID_CATEGORIA) references Categorias (ID_CATEGORIA),
  CONSTRAINT ck_Produtos_Preco
  CHECK (PRECO_PRODUTO >= 0),

  CONSTRAINT ck_Produtos_Estoque
  CHECK (Q_ESTOQUE >= 0)
--);

--create table Clientes(
--	ID_CLIENTE INT PRIMARY KEY NOT NULL,
--	NOME_CLIENTE VARCHAR(255) NOT NULL,
--	CPF_CNPJ VARCHAR(14) UNIQUE NOT NULL,
--	EMAIL_CLIENTE VARCHAR(255) NOT NULL,
--	CIDADE_CLIENTE VARCHAR(100) NOT NULL
--);

--create table Funcionarios(
--	ID_FUNCIONARIO INT PRIMARY KEY NOT NULL,
--	NOME_FUNCIONARIO VARCHAR(255) NOT NULL,
--	CARGO_FUNCIONARIO VARCHAR(155) NOT NULL,
--	SALARIO_FUNCIONARIO NUMERIC NOT NULL
--);

--create table Vendas(
--	ID_VENDA INT PRIMARY KEY NOT NULL,
--	DATA_VENDA DATETIME NOT NULL,
--	ID_CLIENTE INT NOT NULL,
--	ID_FUNCIONARIO INT NOT NULL
--CONSTRAINT fk_clientes_vendas foreign key (ID_CLIENTE) references Clientes (ID_CLIENTE),
--CONSTRAINT fk_funcionarios_vendas foreign key (ID_FUNCIONARIO) references Funcionarios (ID_FUNCIONARIO)
--);

--create table Itens_Venda(
--	ID_ITEM INT PRIMARY KEY NOT NULL,
--	ID_VENDA INT NOT NULL,
--	ID_PRODUTO INT NOT NULL,
--	Q_VENDIDO INT NOT NULL,
--	PRECO_PRODUTO NUMERIC NOT NULL
--CONSTRAINT fk_vendas_itensVenda foreign key (ID_VENDA) references Vendas (ID_VENDA),
--CONSTRAINT fk_produtos_itensVenda foreign key (ID_PRODUTO) references Produtos (ID_PRODUTO)
--);

--INSERÇÃO DE DADOS

USE TechStore
GO

-- Categorias
INSERT INTO dbo.Categorias (ID_CATEGORIA, NOME_CATEGORIA)
VALUES
(1, 'Notebooks'),
(2, 'Computadores'),
(3, 'Periféricos'),
(4, 'Monitores'),
(5, 'Smartphones');

-- Produtos
INSERT INTO dbo.Produtos (ID_PRODUTO, NOME_PRODUTO, PRECO_PRODUTO, Q_ESTOQUE, ID_CATEGORIA)
VALUES
(1, 'Notebook Dell Inspiron', 3500.00, 10, 1),
(2, 'Notebook Lenovo IdeaPad', 4200.00, 8, 1),
(3, 'iPhone 14', 5500.00, 15, 5),
(4, 'Samsung Galaxy S23', 4500.00, 12, 5),
(5, 'Mouse Gamer Logitech', 150.00, 30, 3),
(6, 'Teclado Mecânico Redragon', 280.00, 20, 3),
(7, 'Monitor LG 24"', 900.00, 10, 4);

-- Clientes
INSERT INTO dbo.Clientes (ID_CLIENTE, NOME_CLIENTE, CPF_CNPJ, EMAIL_CLIENTE, CIDADE_CLIENTE)
VALUES
(1, 'Rafael Rodrigues', '12345678901', 'rafael@gmail.com', 'São Paulo'),
(2, 'Ana Souza', '98765432100', 'ana@gmail.com', 'Rio de Janeiro'),
(3, 'Carlos Pereira', '11122233344', 'carlos@gmail.com', 'Belo Horizonte');

-- Funcionarios
INSERT INTO dbo.Funcionarios (ID_FUNCIONARIO, NOME_FUNCIONARIO, CARGO_FUNCIONARIO, SALARIO_FUNCIONARIO)
VALUES
(1, 'João Silva', 'Vendedor', 2500.00),
(2, 'Maria Oliveira', 'Gerente', 5000.00),
(3, 'Pedro Santos', 'Caixa', 2200.00),
(4, 'Elon Musk', 'CEO', 3000.00);

-- Vendas
INSERT INTO dbo.Vendas (ID_VENDA, DATA_VENDA, ID_CLIENTE, ID_FUNCIONARIO)
VALUES
(1, '2024-05-10 14:30:00', 1, 1),
(2, '2024-05-11 10:15:00', 2, 3),
(3, '2024-05-12 16:45:00', 3, 1);

-- Itens_Venda
INSERT INTO dbo.Itens_Venda (ID_ITEM, ID_VENDA, ID_PRODUTO, Q_VENDIDO, PRECO_PRODUTO)
VALUES
(1, 1, 1, 1, 3500.00),
(2, 1, 5, 2, 150.00),
(3, 2, 3, 1, 5500.00),
(4, 3, 7, 1, 900.00),
(5, 3, 6, 1, 280.00);