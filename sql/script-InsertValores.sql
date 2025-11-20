-- INSERTS ONLY

INSERT INTO cerimonial (cnpj_cerimonial, nome, endereco)
VALUES ('12.345.678/0001-99', 'Cerimonial Estrela', 'Av. Central, 1000 - Belo Horizonte');

INSERT INTO buffet (cnpj_buffet, nome, endereco, tempo_parceria, fk_cnpj_cerimonial)
VALUES
('11.111.111/0001-11', 'Buffet Sabor Mineiro', 'Rua das Flores, 50', '2020-05-10', '12.345.678/0001-99'),
('22.222.222/0001-22', 'Buffet Delícias da Serra', 'Rua Horizonte, 88', '2018-03-20', '12.345.678/0001-99'),
('33.333.333/0001-33', 'Buffet Gourmet Festas', 'Av. do Sol, 1200', '2021-09-14', '12.345.678/0001-99');

INSERT INTO cardapio (nome, fk_cnpj_buffet)
VALUES
('Cardápio Mineiro', '11.111.111/0001-11'),
('Cardápio de Doces', '11.111.111/0001-11'),
('Cardápio Finger Food', '11.111.111/0001-11'),
('Cardápio Premium', '22.222.222/0001-22'),
('Cardápio Vegetariano', '22.222.222/0001-22'),
('Cardápio Italiano', '22.222.222/0001-22'),
('Cardápio Clássico', '33.333.333/0001-33'),
('Cardápio de Sobremesas', '33.333.333/0001-33'),
('Cardápio Light', '33.333.333/0001-33');

INSERT INTO aperitivo (tipo_aperitivo, preco_pessoa, descricao)
VALUES
('Coxinha', 4.00, 'Coxinha tradicional'),
('Pão de queijo', 3.00, 'Pão de queijo mineiro'),
('Tábua de frios', 12.00, 'Variedade de queijos e frios'),
('Brigadeiro', 2.50, 'Docinho tradicional'),
('Beijinho', 2.50, 'Docinho de coco'),
('Mini Sanduíches', 5.00, 'Sanduíches sortidos'),
('Risoto', 10.00, 'Risoto de parmesão'),
('Salada verde', 4.50, 'Mix de folhas'),
('Lasanha', 8.00, 'Lasanha bolonhesa'),
('Macarrão ao pesto', 7.00, 'Massa ao molho pesto'),
('Petit Gateau', 9.00, 'Sobremesa de chocolate'),
('Frutas frescas', 5.00, 'Frutas da estação');

INSERT INTO cardapio_aperitivo VALUES
(1, 1, 200), (1, 2, 150), (1, 3, 40),
(2, 4, 180), (2, 5, 160),
(3, 1, 100), (3, 6, 120),
(4, 7, 80),  (4, 3, 30),
(5, 8, 90),  (5, 2, 100),
(6, 9, 70),  (6, 10, 85),
(7, 6, 110), (7, 3, 40),
(8, 4, 200), (8, 11, 60),
(9, 12, 130), (9, 8, 80);

INSERT INTO formatura (
    nome_curso, faculdade, nome_chefe_sala,
    telefone_chefe_sala, valor_pagamento,
    forma_pagamento, fk_cnpj_cerimonial
)
VALUES
('Engenharia de Software', 'PUC Minas', 'Marcos Andrade',
 '(31)98765-4321', 15000.00, 'Pix', '12.345.678/0001-99');

INSERT INTO evento (hora_inicio, hora_termino, localizacao, data_evento, descricao,
                     fk_cod_formatura, fk_cod_cardapio)
VALUES
('19:00','02:00','Espaço Diamante','2025-01-15','Festa de formatura Buffet 1',1,1),
('10:00','12:00','Auditório Central','2025-01-14','Culto ecumênico Buffet 1',1,2),
('18:00','21:00','Auditório PUC','2025-01-16','Colação Buffet 1',1,3);

INSERT INTO evento VALUES
(DEFAULT,'20:00','01:00','Espaço Horizonte','2025-02-10','Jantar de gala Buffet 2',1,4),
(DEFAULT,'08:00','11:00','Teatro Municipal','2025-02-09','Palestra de honra Buffet 2',1,5),
(DEFAULT,'17:00','22:00','Salão Imperial','2025-02-11','Baile de honra Buffet 2',1,6);

INSERT INTO evento VALUES
(DEFAULT,'21:00','03:00','Clube Estrela','2025-03-20','Festa temática Buffet 3',1,7),
(DEFAULT,'09:00','12:00','Salão Paroquial','2025-03-19','Culto ecumênico Buffet 3',1,8),
(DEFAULT,'15:00','19:00','Centro de Convenções','2025-03-21','Coquetel de formatura Buffet 3',1,9);

INSERT INTO tipo_profissional (descricao)
VALUES
('Garçom'), ('Segurança'), ('Fotógrafo'), ('Coordenador'), ('DJ');

INSERT INTO funcionario (salario, nome, fk_cod_tipo_profissional)
VALUES
(2000,'João Pereira',1),
(2500,'Ana Silva',3),
(1800,'Carlos Mendes',1),
(3000,'Fernanda Rocha',4),
(2200,'Bruno Carvalho',2),
(2800,'Eduardo Costa',5),
(1900,'Paulo Henrique',1),
(2600,'Mariana Duarte',3);

DO $$
DECLARE e INT; f INT;
BEGIN
    FOR e IN 1..9 LOOP
        FOR f IN 1..5 LOOP
            INSERT INTO evento_funcionario (matricula, cod_evento, quantidade_horas)
            VALUES (f, e, 6);
        END LOOP;
    END LOOP;
END$$;

INSERT INTO telefone VALUES
('(31)91234-1111',1),
('(31)91234-2222',2),
('(31)91234-3333',3),
('(31)91234-4444',4),
('(31)91234-5555',5),
('(31)91234-6666',6),
('(31)91234-7777',7),
('(31)91234-8888',8);
