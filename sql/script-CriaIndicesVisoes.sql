-- Índices
CREATE INDEX idx_evento_data_evento ON evento (data_evento);
CREATE INDEX idx_aperitivo_preco_pessoa ON aperitivo (preco_pessoa);

-- View evento completo
CREATE VIEW vw_evento_completo AS
SELECT 
    e.cod_evento,
    e.data_evento,
    e.hora_inicio,
    e.hora_termino,
    e.localizacao,
    e.descricao AS descricao_evento,

    f.cod_formatura,
    f.nome_curso,
    f.faculdade,

    c.cod_cardapio,
    c.nome AS nome_cardapio,

    b.cnpj_buffet,
    b.nome AS nome_buffet,

    ce.cnpj_cerimonial,
    ce.nome AS nome_cerimonial
FROM evento e
JOIN formatura f ON e.fk_cod_formatura = f.cod_formatura
JOIN cardapio c ON e.fk_cod_cardapio = c.cod_cardapio
JOIN buffet b ON c.fk_cnpj_buffet = b.cnpj_buffet
JOIN cerimonial ce ON b.fk_cnpj_cerimonial = ce.cnpj_cerimonial;

-- View dos funcionarios escalados
CREATE VIEW vw_funcionarios_eventos AS
SELECT 
    f.matricula,
    f.nome AS nome_funcionario,
    f.salario,
    
    tp.descricao AS tipo_profissional,

    e.cod_evento,
    e.data_evento,
    e.localizacao,
    
    ef.quantidade_horas
FROM evento_funcionario ef
JOIN funcionario f ON ef.matricula = f.matricula
JOIN tipo_profissional tp ON f.fk_cod_tipo_profissional = tp.cod_tipo_profissional
JOIN evento e ON ef.cod_evento = e.cod_evento;