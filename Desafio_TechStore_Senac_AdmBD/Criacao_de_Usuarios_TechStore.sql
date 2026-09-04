	--Criação de usuário
USE master
GO
	CREATE LOGIN user_funcionario
	WITH PASSWORD = '1234@func',
	CHECK_POLICY = ON;
	GO

USE TechStore
GO
	CREATE USER Funcionário
	FOR LOGIN user_funcionario;
	GO

USE master
GO
	CREATE LOGIN user_gerente
	WITH PASSWORD = '1234@ger',
	CHECK_POLICY = ON;
	GO

USE TechStore
GO
	CREATE USER Gerente
	FOR LOGIN user_gerente;
	GO

USE master
GO
	CREATE LOGIN user_adm
	WITH PASSWORD = '1234@adm',
	CHECK_POLICY = ON;
	GO

USE TechStore
GO
	CREATE USER Administrador
	FOR LOGIN user_adm;
	GO

	--Criação das Roles
CREATE ROLE RL_FUNCIONARIO;
	GO

	CREATE ROLE RL_GERENTE;
	GO

	CREATE ROLE RL_ADMIN;
	GO

GRANT SELECT on dbo.Vendas
TO RL_FUNCIONARIO;
GRANT SELECT on dbo.Produtos
TO RL_FUNCIONARIO;
GRANT SELECT on dbo.Itens_Venda
TO RL_FUNCIONARIO;
GRANT SELECT on dbo.Categorias
TO RL_FUNCIONARIO;

	GRANT SELECT on dbo.Vendas
	TO RL_GERENTE;
	GRANT SELECT on dbo.Produtos
	TO RL_GERENTE;
	GRANT SELECT on dbo.Itens_Venda
	TO RL_GERENTE;
	GRANT SELECT on dbo.Categorias
	TO RL_GERENTE;
	GRANT SELECT on dbo.Clientes
	TO RL_GERENTE;
	GRANT SELECT on dbo.Funcionarios
	TO RL_GERENTE;

GRANT SELECT on dbo.Vendas
TO RL_ADMIN;
GRANT SELECT on dbo.Produtos
TO RL_ADMIN;
GRANT SELECT on dbo.Itens_Venda
TO RL_ADMIN;
GRANT SELECT on dbo.Categorias
TO RL_ADMIN;
GRANT SELECT on dbo.Clientes
TO RL_ADMIN;
GRANT SELECT on dbo.Funcionarios
TO RL_ADMIN;

	--Adição de Membros
USE TechStore
GO
	ALTER ROLE RL_FUNCIONARIO ADD MEMBER Funcionário
	GO

	USE TechStore
	GO
	ALTER ROLE RL_GERENTE ADD MEMBER Gerente
	GO

	USE TechStore
	GO
	ALTER ROLE db_owner ADD MEMBER Administrador
	GO
USE TechStore
GO
ALTER ROLE RL_ADMIN ADD MEMBER Administrador
GO