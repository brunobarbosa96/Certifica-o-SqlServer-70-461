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


-- GROUPING SETS
-- Grouping sets � nada mais do que poder agrupar na mesma query por v�rios grupos diferentes ao mesmo tempo

--Exemplo: 
SELECT	shipperid, 
		YEAR(shippeddate) AS shipyear, 
		COUNT(*) AS numorders
	FROM Sales.Orders
	GROUP BY GROUPING SETS
	(
	( shipperid, YEAR(shippeddate) ),
	( shipperid ),
	( YEAR(shippeddate) ),
	( )
	);

-- O Grouping Set � uma forma de fazer quaisquer agrupamentos que desejar, por�m deve-se passar todos as combina��es 
-- desejadas nos parametros dos sets
-- o T-SQL fornece mais dois operadores para grouping sets que nos auxilia a agrupar de v�rias formas sem que tenha que 
-- ficar informando as opera��es poss�veis.. s�o eles o CUBE e o ROLLUP
SELECT	shipperid, 
		YEAR(shippeddate) AS shipyear, 
		COUNT(*) AS numorders
	FROM Sales.Orders
	GROUP BY CUBE( shipperid, YEAR(shippeddate) );

-- Exemplo para descobrir quando um elemento est� agrupado ou n�o
SELECT
		shipcountry, GROUPING(shipcountry) AS grpcountry,
		shipregion , GROUPING(shipregion) AS grpcountry,
		shipcity , GROUPING(shipcity) AS grpcountry,
		COUNT(*) AS numorders
	FROM Sales.Orders
	GROUP BY ROLLUP( shipcountry, shipregion, shipcity );


-- Grouping_Id retorna o resultado das elementos que est�o agrupados atrav�s do BITMAP
SELECT	GROUPING_ID( shipcountry, shipregion, shipcity ) AS grp_id,
		shipcountry, 
		shipregion, 
		shipcity,
		COUNT(*) AS numorders
	FROM Sales.Orders
	GROUP BY ROLLUP( shipcountry, shipregion, shipcity );