--Case Scenario 1: Code Review

--1. R: Eu recomendaria que o cliente para que ele uilizasse mais as fun��es de "SET" como o UNION, EXCEPT e INTERSECT
-- por exemplo, para que diminuisse a complexidade dos subselects. Tamb�m recomendaria que usasse APPLY OPERATORS 
-- Table Functions e CTE's para os casos que precisam de repeti��o de c�digo. Dessa forma acredito que j� melhoraria muito
-- a complexidade do c�digo e principalmente a performance das querys.

--2. R: Neste caso recomendaria que utilizasse VIEW para n�o precisar repetir a sele��o dos dados que sempre ser� utilizados
-- e ao inv�s de cursor, usar operadores como CROSS APPLY E OUTER APPLY por exemplo.

--3. R: Neste caso recomendaria que criasse os �ndices nos campos mais utilizados para os JOINS, pois isto melhoraria muito a performance deles.



--Case Scenario 2: Explaining Set Operators

--1. R: Sugeria que indexasse a View para melhorar a performance das querys

--2. R: Os operadores como INTERSECT e EXCEPT al�m de deixar o c�digo mais simples e leg�vel
-- do que usar operadores como inner e outer joins prop�e para n�s tamb�m um ganho de performance
-- j� que estes s�o espec�ficos para executar esta tarefa

