use TechStore
go

--Triggers TechStore
--select * from  dbo.Categorias
--select * from  dbo.Clientes
--select * from  dbo.Funcionarios
--select * from  dbo.Itens_Venda
--select * from  dbo.Produtos
--select * from  dbo.Vendas

	--LISTA TODOS OS PRODUTOS
select NOME_PRODUTO as 'Todos os Produtos' FROM DBO.Produtos

	--CALCULA O PREÇO MÉDIO DOS PRODUTOS
SELECT CAST(AVG(PRECO_PRODUTO) AS DECIMAL(10,2)) AS 'Preço Médio'
FROM Produtos;

	--IDENFICA O PRODUTO MAIS CARO
SELECT NOME_PRODUTO AS 'Produto Mais Caro',
	   PRECO_PRODUTO AS 'Preço'
FROM Produtos
WHERE PRECO_PRODUTO = (
    SELECT MAX(PRECO_PRODUTO)
    FROM Produtos
);

	--IDENFICA O PRODUTO MAIS BARATO
SELECT NOME_PRODUTO AS 'Produto Mais Barato',
	   PRECO_PRODUTO AS 'Preço'
FROM Produtos
WHERE PRECO_PRODUTO = (
    SELECT MIN(PRECO_PRODUTO)
    FROM Produtos
);

	--CALCULA A QUANTIDADE TOTAL DE PRODUTOS EM ESTOQUE
SELECT SUM(Q_ESTOQUE) AS 'Quantidade Total em Estoque' from dbo.Produtos

	--CALCULA O VALOR FINANCEIRO TOTAL DO ESTOQUE
--SELECT Q_ESTOQUE as 'Estoque', PRECO_PRODUTO as 'Valor', (Q_ESTOQUE * PRECO_PRODUTO) AS 'Valor de Estoque'
--FROM Produtos;

SELECT SUM(Q_ESTOQUE * PRECO_PRODUTO) AS 'Valor Total do Estoque' -- SUM soma
FROM Produtos;

	--CALCULAR O PREÇO MÉDIO POR CATEGORIA
SELECT
    C.NOME_CATEGORIA AS 'Categoria',
    CAST(AVG(P.PRECO_PRODUTO) AS DECIMAL(10,2)) AS 'Preço Médio'
FROM Produtos P --Usou o P para identificar produtos
INNER JOIN Categorias C --e o C para Categorias
    ON P.ID_CATEGORIA = C.ID_CATEGORIA
GROUP BY C.NOME_CATEGORIA;

	--CALCULAR QUANTIDADE DE PRODUTOS POR CATEGORIA
SELECT
    Categorias.NOME_CATEGORIA AS 'Categoria',
    COUNT(Produtos.ID_PRODUTO) AS 'Quantidade de Produtos' -- O count vai somar a quantidades de ids existentes
FROM Produtos
INNER JOIN Categorias
    ON Produtos.ID_CATEGORIA = Categorias.ID_CATEGORIA
GROUP BY Categorias.NOME_CATEGORIA;

	--CALCULAR O VALOR TOTAL DE CADA VENDA
SELECT Q_VENDIDO AS 'Quantidade Vendida', PRECO_PRODUTO AS 'Preço do Produto',
(Q_VENDIDO * PRECO_PRODUTO) AS 'Total de Cada Venda'
FROM dbo.Itens_Venda

--CREATE TRIGGER trg_CalcularTotalVenda
--ON Itens_Venda
--AFTER INSERT
--AS
--BEGIN
--    PRINT 'Item adicionado à venda!'
--END

	--CALCULAR O FATURAMENTO TOTAL DA LOJA
SELECT CAST(SUM(Q_VENDIDO * PRECO_PRODUTO) AS DECIMAL(10,2)) AS 'Faturamento Total'
FROM dbo.Itens_Venda

	--CALCULAR QUANTO CADA VENDEDOR VENDEU
SELECT f.ID_FUNCIONARIO AS 'ID do Funcionário', f.NOME_FUNCIONARIO AS 'Nome do Funcionário', CAST(SUM(iv.Q_VENDIDO * iv.PRECO_PRODUTO) AS decimal(10,2)) AS 'Total Vendido'
FROM Funcionarios f
INNER JOIN Vendas v
ON f.ID_FUNCIONARIO = v.ID_FUNCIONARIO
INNER JOIN Itens_Venda iv --"INNER JOIN" junta dados de duas ou mais tabelas
ON v.ID_VENDA = iv.ID_VENDA
GROUP BY
	f.ID_FUNCIONARIO,
	f.NOME_FUNCIONARIO
ORDER BY [Total Vendido] DESC;

	--IDENTIFICAR QUAL VENDEDOR VENDEU MAIS
SELECT TOP 1
    f.ID_FUNCIONARIO AS 'ID do Funcionário',
    f.NOME_FUNCIONARIO AS 'Nome do Funcionário',
    CAST(SUM(iv.Q_VENDIDO * iv.PRECO_PRODUTO) AS DECIMAL(10,2)) AS 'Total Vendido'
FROM Funcionarios f
INNER JOIN Vendas v
    ON f.ID_FUNCIONARIO = v.ID_FUNCIONARIO
INNER JOIN Itens_Venda iv
    ON v.ID_VENDA = iv.ID_VENDA
GROUP BY
    f.ID_FUNCIONARIO,
    f.NOME_FUNCIONARIO
ORDER BY SUM(iv.Q_VENDIDO * iv.PRECO_PRODUTO) DESC;


	--TRIGGER PARA DIMINUIR O ESTOQUE AUTOMATICAMENTE
CREATE TRIGGER trg_BaixarEstoque
ON Itens_Venda
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.Q_ESTOQUE = p.Q_ESTOQUE - i.Q_VENDIDO
    FROM Produtos p
    INNER JOIN inserted i
        ON p.ID_PRODUTO = i.ID_PRODUTO;
END