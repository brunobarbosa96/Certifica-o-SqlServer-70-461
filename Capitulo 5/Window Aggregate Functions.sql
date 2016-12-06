-- Window Aggregate Functions

-- Fun��es de agrega��o s�o fun��es proporcionadas pelo T-SQL e pelo SQL stantard, que permite 
-- agregar dados de alguma maneira.. S�o exemplos de fun��es de agrega��o: SUM, COUNT, AVG, MIN, e MAX
-- junto � estas fun��es podemos usar o OVER, que mais adiante ser� explicado melhor

-- Exemplo:
SELECT	custid, 
		orderid,
		val,
		SUM(val) OVER(PARTITION BY custid) AS custtotal,
		SUM(val) OVER() AS grandtotal
FROM Sales.OrderValues;
-- No exemplo acima, podemos perceber que sem o uso do over, as tuplas n�o agrupadas v�o causar um erro
-- este erro n�o ocorre utilizando o over, pois o over serve para indicar que esse agrupamento ir� funcionar de forma apartada
-- diferentemente de fun��es de agrega��es normais, que todas as colunas devem ser agrupadas de alguma forma para funcionar
-- no exemplo em que o over � combiando com o partition, � executado a agrega��o de acordo com o campo particionado
-- quando n�o se passa nada, faz-se uma somat�ria total de todos os registros


-- As fun��es de agrega��o podem ser usadas em conjunto tamb�m, como por exemplo:
SELECT	custid, 
		orderid,
		val,
		CAST(100.0 * val / SUM(val) OVER(PARTITION BY custid) AS NUMERIC(5, 2)) AS pctcust,
		CAST(100.0 * val / SUM(val) OVER() AS NUMERIC(5, 2)) AS pcttotal
FROM Sales.OrderValues;


-- As agrega��es tamb�m podem ser din�mica usando linhas acima ou abaixo da linha atual de acordo com o que voc� desejar
-- Segue algumas defini��es conforme cita no livro da certifica��o:
-- -> UNBOUNDED PRECEDING or FOLLOWING, meaning the beginning or end of the partition, respectively
-- -> CURRENT ROW, obviously representing the current row
-- -> <n> ROWS PRECEDING or FOLLOWING, meaning n rows before or after the current, respectively
-- Exemplo:

SELECT custid, orderid, orderdate, val,
	SUM(val) OVER(PARTITION BY custid
	ORDER BY orderdate, orderid
	ROWS BETWEEN UNBOUNDED PRECEDING
	AND CURRENT ROW) AS runningtotal
FROM Sales.OrderValues;