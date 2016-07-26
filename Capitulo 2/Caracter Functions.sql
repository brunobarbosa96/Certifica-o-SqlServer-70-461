-- Caracter Functions

-- Exemplos Concatena��o

-- concatena��o utilizando o '+' por�m, dessa forma quando h� algum valor null toda a string se torna null tamb�m
SELECT empid, 
	   country, 
	   region, 
	   city,
	   country + N',' + region + N',' + city AS location
	FROM HR.Employees;

-- COALASCE serve para pegar o primeiro valor n�o nulo encontrado na express�o
SELECT empid, 
	   country, 
	   region, 
	   city,
	   country + COALESCE( N',' + region, N'') + N',' + city AS location
	FROM HR.Employees;


-- CONCAT ele j� serve para concatenar a string toda j� trocando valores nulos por vazio
SELECT empid, 
	   country, 
	   region, 
	   city,
	   CONCAT(country, N',' + region, N',' + city) AS location
	FROM HR.Employees;

-- Manipula��o de strings

-- SUBSTRING primiero par�metro: string, segundo par�metro: onde vai come�ar a ler, terceiro par�metro: quantas posi��es
-- LEFT OU RIGHT recebe a string como primeiro par�metro e quantos posi��es ele vai percorrer, da esquerda pra direita ou da direita para a esquerda, respectivamente
-- CHARINDEX retorna o index da primeira apari��o do caractere especificado no primeiro par�metro 
-- PATINDEX funciona como o CHARINDEX por�m assim como o LIKE o PARINDEX busca por um padr�o especificado, por exemplo achar numeros entre uma string
-- LEN retorna a quantidade de caracteres contida na string
-- DATALENGTH retorna a quantidade de bytes que tem a string  

--Exemplo:

DECLARE @Nome varchar(20) = 'Bruno Barbosa'
SELECT SUBSTRING(@Nome, 1 , 5) AS "SUBSTRING",
	   
	   LEFT(@Nome, 5) AS "LEFT",
	   
	   RIGHT(@Nome, 7) AS "RIGHT",
	   
	   CHARINDEX(' ', @Nome) AS "CHARINDEX",
	   
	   LEFT(@nome, CHARINDEX(' ', @nome) -1) AS "LEFT CHARINDEX",
	   
	   PATINDEX('%[0-9]%', 'ASUASBUAB1234TESTE') AS "PATINDEX",

	   LEN(@nome) AS "LEN",
	   LEN(N'Bruno Barbosa') AS "LEN NVARCHAR",

	   DATALENGTH(@nome) AS "DATALENGTH",
	   DATALENGTH(N'Bruno Barbosa') AS "DATALENGTH NVARChAR"

-- REPLACE para trocar algum caracter por outro
-- REPLICATE replica algum caracter,
-- STUFF ele possui 4 argumentos, o primeiro � a string, o segundo � de onde ele vai come�ar a ler, o terceiro � o caracter que vai remover
--	e o quarto o caracter que ele vai inserir no lugar... alterando a string

-- Exemplo
SELECT REPLACE('0.1.2.3.4', '.', '/') AS "REPLACE",
	   REPLICATE('0', 10) AS "REPLICATE",
	   STUFF('.Brunoo Barbosa.', 1, 1, '') AS "STUFF"


-- Formata��o de strings
--UPPER deixa string em caixa alta
--LOWER deixa string em caixa baixa
--LTRIM remove os brancos da esquerda
--RTRIM remove os brancos da direita
--FORMAT formata a string no padr�o que mandar

-- Exemplo
SELECT UPPER('bruno barbosa') AS "UPPER",
	   LOWER('BRUNO BARBOSA') AS "LOWER",
	   LTRIM(' Bruno Barbosa ') AS "LTRIM",
	   RTRIM(' Bruno Barbosa ') AS "RTRIM",
	   FORMAT(123, '00000') AS "FORMAT"

-- CASE EXEMPLO -- o CASE retorna valores de acordo com a clausula WHEN
SELECT productid, 
	   productname, 
	   unitprice, 
	   discontinued,
	   CASE discontinued
			WHEN 0 THEN 'No'
			WHEN 1 THEN 'Yes'
			ELSE 'Unknown'
	   END AS discontinued_desc
	FROM Production.Products;

SELECT productid, 
	   productname, 
	   unitprice,
	   CASE
			WHEN unitprice < 20.00 THEN 'Low'
			WHEN unitprice < 40.00 THEN 'Medium'
			WHEN unitprice >= 40.00 THEN 'High'
			ELSE 'Unknown'
	   END AS pricerange
	FROM Production.Products;