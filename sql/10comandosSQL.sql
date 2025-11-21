--a) junções de 3 ou mais tabelas, com ORDER BY
--
--Faça um select com nome do cardapio, tipo do aperitivo e quantidade.
--ordene pelo nome do cardapio de forma crescente
SELECT c.nome, a.tipo_aperitivo, ca.quantidade
from cardapio as c
join cardapio_aperitivo as ca
on c.cod_cardapio = ca.cod_cardapio
join aperitivo as a
on a.cod_aperitivo = ca.cod_aperitivo
order by c.nome;

--b) junções de 3 ou mais tabelas, com ORDER BY e filtros na cláusula WHERE
--
--Faça um select com nome do cardapio, tipo do aperitivo e preco por pessoa, 
--selecione apenas os aperitivos com preco superior a 7. 
--ordene pelo nome do cardapio decrescente
SELECT c.nome, a.tipo_aperitivo, a.preco_pessoa
from cardapio as c
join cardapio_aperitivo as ca
on c.cod_cardapio = ca.cod_cardapio
join aperitivo as a
on a.cod_aperitivo = ca.cod_aperitivo
where a.preco_pessoa > 7
order by c.nome desc;

--c) junção de 3 ou mais tabelas, usando os operadores LIKE e BETWEEN
--
--Faça um select com nome do cardapio, tipo do aperitivo e preco por pessoa, 
--selecione apenas os aperitivos com preco maior que 5 e menor que 8,
--somente dos cardapios que terminam com a letra 'o'
SELECT c.nome, a.tipo_aperitivo, a.preco_pessoa
from cardapio as c
join cardapio_aperitivo as ca
on c.cod_cardapio = ca.cod_cardapio
join aperitivo as a
on a.cod_aperitivo = ca.cod_aperitivo
where c.nome like '%o'
and a.preco_pessoa BETWEEN 5 and 8;

--d) junção de 3 ou mais tabelas, usando os operadores IN e IS NULL/IS NOT NULL
--
--Selecione o nome, tipo do aperitivo e preco por pessoa dos cardapios:
--Cardápio Premium, Cardápio Mineiro, Cardápio de Sobremesas.
--não mostre preços nulos.
SELECT c.nome, a.tipo_aperitivo, a.preco_pessoa
from cardapio as c
join cardapio_aperitivo as ca
on c.cod_cardapio = ca.cod_cardapio
join aperitivo as a
on a.cod_aperitivo = ca.cod_aperitivo
where c.nome in ('Cardápio Premium', 'Cardápio Mineiro', 'Cardápio de Sobremesas')
and a.preco_pessoa is not null;

--e) junção de 2 ou mais tabelas com GROUP BY, sem HAVING, usando uma função agregada
--qualquer (MIN, MAX, AVG, SUM, COUNT). Use ORDER BY
--
--Selecionar o nome de cada cardápio e calcular a soma dos preços de seus itens, unindo as tabelas correspondentes.
--Agrupar os resultados por cardápio e ordená-los pelo valor total
SELECT 
    c.nome AS nome_cardapio,
    SUM(a.preco_pessoa * ca.quantidade) AS total_preco
FROM cardapio c
JOIN cardapio_aperitivo ca 
    ON c.cod_cardapio = ca.cod_cardapio
JOIN aperitivo a
    ON ca.cod_aperitivo = a.cod_aperitivo
GROUP BY c.nome
ORDER BY total_preco DESC;

--f) junção de 2 ou mais tabelas com GROUP BY e HAVING, usando uma função agregada
--qualquer (MIN, MAX, AVG, SUM, COUNT)
--
--Selecionar a descrição de cada tipo de funcionário e o salário médio dos funcionários pertencentes a esse tipo, realizando a junção entre as tabelas necessárias. 
--Agrupar os resultados por tipo de funcionário e exibir apenas os tipos cujo salário médio seja superior a R$ 2.500, usando HAVING para filtrar o grupo
SELECT tp.descricao,
       AVG(f.salario) AS salario_medio
FROM funcionario f
JOIN tipo_profissional tp
      ON f.fk_cod_tipo_profissional = tp.cod_tipo_profissional
GROUP BY descricao
HAVING AVG(f.salario) > 2500
ORDER BY salario_medio DESC;

--g) subselect sem correlação
--
--Selecionar o nome e salario dos funcionarios que são garçom
SELECT nome, salario
from funcionario
where fk_cod_tipo_profissional = (
    select cod_tipo_profissional
    from tipo_profissional
    where descricao = 'Garçom'
);

--h) subselect com correlação
--
--Faça uma query que lista os eventos que tem no cardápio pelo menos um aperitivo com preço maior que R$10,00 
SELECT e.cod_evento, e.descricao, c.nome AS cardapio
FROM evento e
JOIN cardapio c ON e.fk_cod_cardapio = c.cod_cardapio
WHERE EXISTS (
    SELECT 1
    FROM cardapio_aperitivo ca
    JOIN aperitivo a ON a.cod_aperitivo = ca.cod_aperitivo
    WHERE ca.cod_cardapio = c.cod_cardapio
      AND a.preco_pessoa > 10
);

--i) subselect com EXISTS
--
--Faça uma query que lista os funcionários que já participaram de pelo menos 1 evento 
SELECT f.nome AS funcionario
FROM funcionario f
WHERE EXISTS (
    SELECT ef.matricula
    FROM evento_funcionario ef
    WHERE ef.matricula = f.matricula
);

--j) junção de 2 ou mais tabelas com GROUP BY e HAVING, usando uma função agregada qualquer (MIN, MAX, AVG, SUM, COUNT)
--
--Faça uma query que liste os eventos e a quantidade de funcionários que participaram de cada evento, mostre apenas eventos com mais de 3 funcionários
SELECT e.cod_evento, e.descricao AS evento, COUNT(ef.matricula) AS total_funcionarios
FROM evento e
JOIN evento_funcionario ef ON e.cod_evento = ef.cod_evento
GROUP BY e.cod_evento, e.descricao
HAVING COUNT(ef.matricula) > 3;