-- Views s�o uma esp�cie de tabela virtual, onde voc� define os dados que ela devem retornar
-- para reaproveit�-la de onde quiser, desde que tenha permiss�o para acess�-la, assim como tabelas normals
-- as Views s�o muito utilizadas para selects repetitivos com muitos joins na qual se utiliza com frequencia
-- as Views permite que voc� fa�a todas as opera��es normalmente como se fosse uma tabela, por�m n�o permite a
-- passagem de par�metros para sua execu��o;


-- Exemplo

IF OBJECT_ID('Sales.RankedProducts', 'V') IS NOT NULL DROP VIEW Sales.RankedProducts;
GO

CREATE VIEW Sales.RankedProducts
AS

	SELECT
		ROW_NUMBER() OVER(PARTITION BY categoryid ORDER BY unitprice, productid) AS rownum,
		categoryid, 
		productid, 
		productname, 
		unitprice
	FROM Production.Products;

GO

-- Selecionando os registros da View criada
SELECT *
	FROM  Sales.RankedProducts


-- Functions s�o como o pr�prio nome diz, fun��es que podemos criar do SQL para executar determinado bloco de c�digo
-- No exemplo abaixo, mostra uma function que retorna uma tabela, e assim podemos utilizar esta tabela dinamicamente 
-- tendo a possibilidade de mandar par�metros din�micos, diferentemente das views

-- Exemplo

IF OBJECT_ID('HR.GetManagers', 'IF') IS NOT NULL DROP FUNCTION HR.GetManagers;
GO

CREATE FUNCTION HR.GetManagers(@empid AS INT) RETURNS TABLE
AS

	RETURN	
		WITH EmpsCTE AS
		(
			SELECT empid, mgrid, firstname, lastname, 0 AS distance
				FROM HR.Employees
				WHERE empid = @empid
			UNION ALL
			SELECT M.empid, M.mgrid, M.firstname, M.lastname, S.distance + 1 AS distance
				FROM EmpsCTE AS S
					JOIN HR.Employees AS M
						ON S.mgrid = M.empid
		)
		SELECT empid, mgrid, firstname, lastname, distance
		FROM EmpsCTE;

GO


-- a fun��o tamb�m pode ser usada de qualquer lugar independente da se��o em que se encontra 
-- como o resultado da function � uma tabela, pode se fazer joins com este resultado normalmente
-- utilizando como uma tabela dinamica;

-- Exemplo
SELECT * 
	FROM HR.GetManagers(5) a 
		join HR.Employees e
			on e.empid = a.empid