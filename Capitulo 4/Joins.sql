-- CROSS JOIN
-- � uma jun��o comparada a um produto cartesiano entre duas tabelas
-- onde � realizado uma multiplica��o de todos os registros retornando todas as possibilidades
-- de combina��es poss�veis

-- no exemplo abaixo est� combinando todas as possibilidade de dias de semana com os dias 1,2 e 3...
SELECT D.n AS theday,
	   S.n AS shiftno
	FROM [dbo].[Nums] AS D
		CROSS JOIN [dbo].[Nums] AS S
	WHERE D.n <= 7
		AND S.n <= 3
	ORDER BY theday, shiftno;

-- INNER JOIN 
-- Inner join � uma jun��o na qual trar� todos os campos que tem na primeira tabela e tem na segunda,
-- geralmente usados para trazer a intersec��o da tabela a esquerda ligando a chave prim�ria com a
-- chave estrangeira da tabela � direita

-- no exemplo abaixo est� trazendo todos os 
SELECT S.companyname AS supplier,
	   S.country, 
	   P.productId,
	   P.productName,
	   P.unitPrice
	FROM [Production].[Suppliers] AS S
		INNER JOIN [Production].[Products] AS P
			ON S.supplierid = P.supplierid
		WHERE S.country LIKE N'Japan';


-- Exemplo LEFT OUTER JOIN ou LEFT JOIN da forma simplificada
-- o left join tras todos os registros da tabela da esquerda independentemente se tem ou n�o na tabela da direita,
-- quando n�o encontra registro na segunda tabela o resultado retornado vem null
-- Exemplo

SELECT
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
	WHERE S.country = N'Japan';


-- Multi join - � poss�vel combinar m�ltiplos joins em uma mesma query, por exemplo:

SELECT
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice,
	C.categoryname
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
		INNER JOIN Production.Categories AS C
			ON C.categoryid = P.categoryid
	WHERE S.country = N'Japan';



	SELECT
		S.companyname AS supplier, S.country,
		P.productid, P.productname, P.unitprice,
		C.categoryname
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN
			(Production.Products AS P
				INNER JOIN Production.Categories AS C
				ON C.categoryid = P.categoryid)
		ON S.supplierid = P.supplierid
	WHERE S.country = N'Japan';


-- Exercise
-- Join
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		INNER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId

-- Outer Join
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		LEFT OUTER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId

-- apenas os customers sem orders
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		LEFT OUTER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId
	WHERE O.CustId IS NULL

-- Adicionando filtros
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		LEFT OUTER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId
				AND O.OrderDate >= '20080201'
				AND O.OrderDate < '20080301'