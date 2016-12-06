-- ROW_NUMBER - retorna a enumera��o de linhas de acordo com o over
-- RANK - traz um rank de numeros contando de um em um, por isso h� falhas quando se repete a coloca��o
-- DENSE_RANK - traz um rank de numeros contando todas as linhas seguindo sempre do ultimo colocado em ordem
-- NTILE - traz um ranque na quantidade de registros dividito pelo parametro, sendo assim traz uma media de valores em cada posi��o

SELECT custid, orderid, val,
	ROW_NUMBER() OVER(ORDER BY val) AS rownum,
	RANK() OVER(ORDER BY val) AS rnk,
	DENSE_RANK() OVER(ORDER BY val) AS densernk,
	NTILE(100) OVER(ORDER BY val) AS ntile100
FROM Sales.OrderValues;



-- LAG retorna o valor do registro anterior de acordo com a cl�usula informada
-- LEAD retorna o valor do registro posterior ao da cl�usula informada

SELECT	custid, 
		orderid, 
		orderdate, 
		val,
		LAG(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS prev_val,
		LEAD(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS next_val
	FROM Sales.OrderValues;



-- FIRST_VALUE retorna o valor do primeiro valor da cl�usula informada
-- LAST_VALUE retorna o valor do ultimo valor da cl�usula informada

SELECT	custid, 
		orderid, 
		orderdate, 
		val,
		FIRST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS first_val,
		LAST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS last_val
FROM Sales.OrderValues;



WITH C AS
(
SELECT shipperid, orderid, freight,
ROW_NUMBER() OVER(PARTITION BY shipperid
ORDER BY freight DESC, orderid) AS rownum
FROM Sales.Orders
)
SELECT shipperid, orderid, freight
FROM C
WHERE rownum <= 3
ORDER BY shipperid, rownum;