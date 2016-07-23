-- Exemplos conversoes

-- inpl�citas
DECLARE @numero int = '1',
		@string char(10) = 123456,
		@data	date = '2016-07-22'

SELECT @numero AS numero,
	   @string AS string,
	   @data	   AS Date

-- expl�citas

SELECT CAST(@numero AS INT) AS numero,
	   CAST(@string AS char(10)) AS string,
	   
	   TRY_CAST('abc' AS INT) AS "Conversao que retorna NULL"--,
	   --CAST ('abc' AS INT) AS "Erro conversao pass�vel de erro"

-- Diferen�a entre CAST, CONVERT e PARSE

SELECT CAST('2016-07-22' AS DATE) AS conversaoDataComCAST
-- A convers�o do cast n�o precisa passar mais nenhum par�metro
-- a n�o ser o que eu quero converter e para qual tipo

SELECT CONVERT(DATETIME, '2016-07-22', 101) AS conversaoDataComCONVERT
-- A convers�o com o convert deve ser feita, passando como primeiro argumento o
-- tipo do dado ap�s a convers�o, a express�o que deve ser convertida e como ultimo par�metro
-- deve se passar o codigo do estilo que vai ser usado, 101 por exemplo representa
-- o pradr�o dos EUA

SELECT PARSE('2016-07-22' AS DATE USING 'en-US') AS conversaoDataComPARSE
-- Para a convers�o com o m�todo parse, deve ser informado como primeiro par�metro o valor 
-- da express�o que quero converter apelidando com o tipo e logo ap�s o using para informar
-- qual a cultura que quero usar, lembrando que suporta algumas culturas contidas no .NET

SELECT 1 + 1,
	   1 + '1',
	   1 + '1' + '1',
	   '1' + '1',
	   '1' + '1' + '1' + 'TESTE'
	   --1 + '1' + 'TESTE' -- este ir� falhar pois o SQL tentar� fazer uma convers�o impl�cita come�ando pelo menor tipo
							-- e quando chegar no tipo char de teste n�o conseguir� converter para int