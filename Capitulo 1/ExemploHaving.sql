 --Cl�usula HAVING com GROUP BY � A cl�usula HAVING determina uma condi��o de busca para um grupo ou um conjunto de registros,
 -- definindo crit�rios para limitar os resultados obtidos a partir do agrupamento de registros. � importante lembrar que essa 
 --cl�usula s� pode ser usada em parceria com GROUP BY.
 -- Dentro de cada um dos grupos, a cl�usula HAVING pode ser usada para restringir apenas os registros que possuem numemployees
 -- superior a 1, por exemplo.
 --Obs: O HAVING � diferente do WHERE. O WHERE restringe os resultados obtidos sempre ap�s o uso da cl�usula FROM, 
 --ao passo que a cl�usula HAVING filtra o retorno do agrupamento.


SELECT country, YEAR(hiredate) AS yearhired, COUNT(*) AS numemployees
	FROM HR.Employees
	WHERE hiredate >= '20000101'
	GROUP BY country, YEAR(hiredate)
	HAVING COUNT(*) > 1
	ORDER BY country , yearhired DESC;

--SEM USAR HAVING
SELECT country, yearhired, numemployees FROM (
	SELECT country, YEAR(hiredate) AS yearhired, COUNT(*) AS numemployees
		FROM HR.Employees
		WHERE hiredate >= '20000101'
		GROUP BY country, YEAR(hiredate)
		)x
	WHERE x.numemployees > 1
	ORDER BY x.country , x.yearhired DESC

	