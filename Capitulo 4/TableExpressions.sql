-- Row Number � uma fun��o como outra qualquer que tem o obetivo de retornar o numero da linha da
-- query que est� sendo escrita de acordo com o que passar no over, esta fun��o ser� estudada na unidade 5
-- mas por enquanto, ela retorna o numero da linha e pode ser usada apenas no select e no order by

SELECT
	ROW_NUMBER() OVER(PARTITION BY categoryid
	ORDER BY unitprice, productid) AS rownum,
	categoryid, 
	productid, 
	productname, 
	unitprice
FROM Production.Products;


-- como ent�o podemos filtrar alguma coluna de acordo com o rownum sendo que n�o pode coloc�-lo no WHERE
-- Resposta: Table Expressions
-- S�o esp�cies de tabelas tempor�rias ou tabelas derivadas que surgem atravez de uma query relacional

-- Tabelas Derivadas (Derived Tables) 
-- Selecionando apenas quem tiver rownum menor ou igual a 2

SELECT rownum, categoryid, productid, productname, unitprice
FROM  (SELECT
			ROW_NUMBER() OVER(PARTITION BY categoryid
			ORDER BY unitprice, productid) AS rownum,
			categoryid, 
			productid, 
			productname, 
			unitprice
		FROM Production.Products) AS p
		WHERE rownum <= 2;


-- Commom Table Expressions - CTEs

-- CTE s�o um tipo de tabelas tempor�rias que assim comos as derived tables, apenas funcionam na se��o em que est� sendo utilizada
-- a principal regra de uma CTE � deve se executar o comando que utiliza os resultados da query imediatamente ap�s a sua declara��o

-- exemplo

WITH C AS 
(
	SELECT
		ROW_NUMBER() OVER(PARTITION BY categoryid
		ORDER BY unitprice, productid) AS rownum,
		categoryid, 
		productid, 
		productname, 
		unitprice
	FROM Production.Products	
), C1 AS
(
	SELECT rownum,
	   categoryid,
	   productid,
	   productname,
	   unitprice
	FROM C
	WHERE rownum <= 2
	UNION
	SELECT 200 AS rownum,
		categoryid,
	   productid,
	   productname,
	   unitprice
		FROM Production.Products
)
SELECT * 
	FROM C1;


-- Recurs�o com CTE
-- Geralmente na recurs�o � utilizado o UNION ALL

-- Exemplo
WITH EmpsCTE AS
(
	SELECT empid, mgrid, firstname, lastname, 0 AS distance
		FROM HR.Employees
		WHERE empid = 9 -- ponto de start da recurs�o. Esse ser� o primeiro registro da busca
	UNION ALL
	SELECT M.empid, M.mgrid, M.firstname, M.lastname, S.distance + 1 AS distance
		FROM EmpsCTE AS S --  da um select na propria CTE para que busque a partir do ponto inicial todas as filhas que ele possue
			JOIN HR.Employees AS M -- com esse inner join ele varre todas as filhas e suas filhas recursivamente 
				ON S.mgrid = M.empid --at� que encontre campos nulos para todas as sa�das
)
SELECT empid, mgrid, firstname, lastname, distance
FROM EmpsCTE;