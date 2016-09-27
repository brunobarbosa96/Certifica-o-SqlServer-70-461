-- DICA: 
	--As opera��es descritas abaixo funcionam da mesma forma que as oper��es matem�ticas.

	-- Para executar esses "set operators" � necess�rio que ambos os selects possuam a mesma quantidade de colunas e 
	-- o tipo delas sejam compat�veis

	-- Em uma query que usa mais de um desses operadores � importante saber que INTERSET tem prioridade sobre UNION e EXCEPT 
	-- enquanto EXCEPT e UNION tem a mesma prioridade
	-- por�m voc� pode mudar isso for�ando a prioridade com par�nteses ();


-- Union � um operador que une os dois selects aplicando um distinct entre eles
-- ou seja, traz o resultado de ambos os selects unidos no mesmo resultado por�m n�o traz nada duplicado

SELECT country,
	   region,
	   city
	FROM HR.Employees

UNION

SELECT country,
	   region,
	   city
	FROM Sales.Customers;


-- Union All � um operador que trabalha da mesmma forma que o union, por�m ele traz todos os registros
-- das tabelas que retornadas nos selects independentemente se repete ou n�o.

SELECT country,
	   region,
	   city
	FROM HR.Employees

UNION ALL

SELECT country,
	   region,
	   city
	FROM Sales.Customers;

-- INTERSECT � um operador que trabalha com mais de um select, trazendo como retorno tudo que tem em comum entre ambos
-- ao contr�rio do union que traz tudo junto, este apenas tr�s quem tem em comum, exatamente como aprendemos na intersec��o na matem�tica.


SELECT country,
	   region,
	   city
	FROM HR.Employees

INTERSECT

SELECT country,
	   region,
	   city
	FROM Sales.Customers;

-- EXCEPT - � um operador que traz tudo que est� na primeira query exceto os registro da primeira que aparece na segunda
-- em outras palavras � uma exce��o.. exemplo: traz pra mim todos os registros desse select que n�o esteja nesse outro.. 
--exemplo:

SELECT country,
	   region,
	   city
	FROM HR.Employees

EXCEPT

SELECT country,
	   region,
	   city
	FROM Sales.Customers;

