-- Exemplos TOP

-- Seleciona os 10 primeiros da execu��o do select
SELECT TOP 10 orderid, orderdate, custid, empid
	FROM Sales.Orders

-- seleciona os primeiros equivalente a porcentagem do total de registros da tabela arredondando pra cima
SELECT TOP 1 PERCENT orderid, orderdate, custid, empid
	FROM Sales.Orders

-- tr�s o top 1, por�m se os registros que vierem na cl�usula order by forem repetidos ele tr�s tamb�m
-- WITH TIES � obrigat�rio ser usado com o ORDER BY, ao contr�rio to TOP isoladamente
SELECT TOP 1 WITH TIES orderid, orderdate, custid, empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC



-- Exemplos OFFSET-FETCH

-- Ignora os primeiros 50 registros do select e traz os pr�ximos 25
SELECT orderid, orderdate, custid, empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC
	OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

-- Trazendo todos os registros com exce��o dos 50 primeiros do retorno do select
SELECT orderid, orderdate, custid, empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC
	OFFSET 50 ROWS;


-- Exemplo de pagina��o com OFFSET-FETCH
DECLARE @pagesize AS BIGINT = 20, @pagenum AS BIGINT = 2;
SELECT orderid, 
	   orderdate, 
	   custid, 
	   empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC
	OFFSET (@pagesize - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY;


