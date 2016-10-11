-- Agrupamentos s�o, como o pr�prio nome diz, agrupar dados de acordo com alguma refer�ncia
-- n�o � obrigat�rio em uma cl�usula o uso do Group By para estar agrupado, pois pode estar agrupado tamb�m por fun��es de agrega��o

-- Exemplo de agrupamento usando fun��es de agrega��o:
SELECT COUNT(*) AS numorders
	FROM Sales.Orders;

-- na fun��o de agrega��o acima, ir� agrupar todos os dados em um �nico grupo, j� que n�o foi especificado outro

-- para especificar o agrupamento em outros grupo, ou agrupar sem usar fun��es de agrega��o, podemos utilizar o 
-- GROUP BY, como por exemplo: 

SELECT	shipperid, 
		YEAR(shippeddate) AS shippedyear,
		COUNT(*) AS numorders
	FROM Sales.Orders
	GROUP BY shipperid, YEAR(shippeddate);

-- Neste caso retorna o resultado de acordo com o shipper id e o ano de shippeddate, retornando a quantidade de numorders para cada grupo
-- o group by pode se usar v�rios argumentos como no exemplo anterior, como tamb�m um s�.

-- Para filtrar os grupos, tem um comando parecido com o WHERE, o HAVING, ele somente pode ser usado para filtrar agrupamentos

-- Exemplo:
-- filtrando todos os registros que possuem shippeddate e ap�s filtra os grupos que possuem menos de 100 numorders ent�o executa o SELECT

SELECT	shipperid, 
		YEAR(shippeddate) AS shippedyear,
		COUNT(*) AS numorders
	FROM Sales.Orders
	WHERE shippeddate IS NOT NULL
	GROUP BY shipperid, YEAR(shippeddate)
	HAVING COUNT(*) < 100;


-- o T-SQL suporta v�rios tipos de fun��es de agrega��o, como por exemplo: COUNT, MAX, MIN, AVG e SUM

-- Exemplo
SELECT	shipperid,
		COUNT(*) AS numorders,
		COUNT(shippeddate) AS shippedorders,
		MIN(shippeddate) AS firstshipdate,
		MAX(shippeddate) AS lastshipdate,
		SUM(val) AS totalvalue
	FROM Sales.OrderValues
	GROUP BY shipperid;

-- Geralmente, as fun��es de agrega��o suportam a cl�usula DISTINCT para n�o contabilizar registros que se repetirem no processo
-- por�m este comando � mais comumente usado no COUNT


-- Exemplo:

SELECT	shipperid, 
		COUNT(DISTINCT shippeddate) AS numshippingdates,
		COUNT(shippeddate) AS numshippingdatesWithoutDistinct
	FROM Sales.Orders
	GROUP BY shipperid;