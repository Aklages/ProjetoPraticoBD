-- Índices para chaves estrangeiras (joins e CASCADE)
CREATE INDEX idx_buffet_fk_cerimonial ON buffet (fk_cnpj_cerimonial);
CREATE INDEX idx_cardapio_fk_buffet ON cardapio (fk_cnpj_buffet);
CREATE INDEX idx_formatura_fk_cerimonial ON formatura (fk_cnpj_cerimonial);
CREATE INDEX idx_evento_fk_formatura ON evento (fk_cod_formatura);
CREATE INDEX idx_evento_fk_cardapio ON evento (fk_cod_cardapio);
CREATE INDEX idx_funcionario_fk_tipo ON funcionario (fk_cod_tipo_profissional);
CREATE INDEX idx_evento_funcionario_matricula ON evento_funcionario (matricula);
CREATE INDEX idx_evento_funcionario_evento ON evento_funcionario (cod_evento);
CREATE INDEX idx_telefone_fk_matricula ON telefone (fk_matricula);
CREATE INDEX idx_ca_cardapio ON cardapio_aperitivo (cod_cardapio);
CREATE INDEX idx_ca_aperitivo ON cardapio_aperitivo (cod_aperitivo);

-- Índices para ORDER BY
CREATE INDEX idx_evento_data_evento ON evento (data_evento);
CREATE INDEX idx_funcionario_nome ON funcionario (nome);
CREATE INDEX idx_cardapio_nome ON cardapio (nome);

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
