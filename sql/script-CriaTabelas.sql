CREATE TABLE cerimonial (
    cnpj_cerimonial CHAR(18) PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    endereco VARCHAR(100) NOT NULL
);

CREATE TABLE buffet (
    cnpj_buffet CHAR(18) PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    tempo_parceria DATE NOT NULL,
    fk_cnpj_cerimonial CHAR(18) NOT NULL,
    
    CONSTRAINT fk_buffet_cerimonial
        FOREIGN KEY (fk_cnpj_cerimonial)
        REFERENCES cerimonial(cnpj_cerimonial)
        ON DELETE CASCADE
);

CREATE TABLE cardapio (
    cod_cardapio SERIAL PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    fk_cnpj_buffet CHAR(18) NOT NULL,
    
    CONSTRAINT fk_cardapio_buffet
        FOREIGN KEY (fk_cnpj_buffet)
        REFERENCES buffet(cnpj_buffet)
        ON DELETE CASCADE
);

CREATE TABLE aperitivo (
    cod_aperitivo SERIAL PRIMARY KEY,
    tipo_aperitivo VARCHAR(80) NOT NULL,
    preco_pessoa DECIMAL(10,2) NOT NULL,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE cardapio_aperitivo (
    cod_cardapio INTEGER NOT NULL,
    cod_aperitivo INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,

    PRIMARY KEY (cod_cardapio, cod_aperitivo),

    CONSTRAINT fk_ca_cardapio
        FOREIGN KEY (cod_cardapio)
        REFERENCES cardapio(cod_cardapio)
        ON DELETE CASCADE,

    CONSTRAINT fk_ca_aperitivo
        FOREIGN KEY (cod_aperitivo)
        REFERENCES aperitivo(cod_aperitivo)
        ON DELETE CASCADE
);

CREATE TABLE formatura (
    cod_formatura SERIAL PRIMARY KEY,
    nome_curso VARCHAR(40) NOT NULL,
    faculdade VARCHAR(40) NOT NULL,
    nome_chefe_sala VARCHAR(80) NOT NULL,
    telefone_chefe_sala CHAR(15) NOT NULL,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(40) NOT NULL,
    fk_cnpj_cerimonial CHAR(18) NOT NULL,
    
    CONSTRAINT fk_formatura_cerimonial
        FOREIGN KEY (fk_cnpj_cerimonial)
        REFERENCES cerimonial(cnpj_cerimonial)
        ON DELETE CASCADE
);

CREATE TABLE evento (
    cod_evento SERIAL PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_termino TIME NOT NULL,
    localizacao VARCHAR(100) NOT NULL,
    data_evento DATE NOT NULL,
    descricao VARCHAR(120) NOT NULL,
    fk_cod_formatura INTEGER NOT NULL,
    fk_cod_cardapio INTEGER NOT NULL,

    CONSTRAINT fk_evento_formatura
        FOREIGN KEY (fk_cod_formatura)
        REFERENCES formatura(cod_formatura)
        ON DELETE CASCADE,

    CONSTRAINT fk_evento_cardapio
        FOREIGN KEY (fk_cod_cardapio)
        REFERENCES cardapio(cod_cardapio)
        ON DELETE RESTRICT
);

CREATE TABLE tipo_profissional (
    cod_tipo_profissional SERIAL PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE funcionario (
    matricula SERIAL PRIMARY KEY,
    salario DECIMAL(10,2) NOT NULL,
    nome VARCHAR(80) NOT NULL,
    fk_cod_tipo_profissional INTEGER NOT NULL,
    
    CONSTRAINT fk_funcionario_tp
        FOREIGN KEY (fk_cod_tipo_profissional)
        REFERENCES tipo_profissional(cod_tipo_profissional)
        ON DELETE RESTRICT
);

CREATE TABLE evento_funcionario (
    matricula INTEGER NOT NULL,
    cod_evento INTEGER NOT NULL,
    quantidade_horas INTEGER NOT NULL,

    PRIMARY KEY (matricula, cod_evento),

    CONSTRAINT fk_ef_funcionario
        FOREIGN KEY (matricula)
        REFERENCES funcionario(matricula)
        ON DELETE CASCADE,

    CONSTRAINT fk_ef_evento
        FOREIGN KEY (cod_evento)
        REFERENCES evento(cod_evento)
        ON DELETE CASCADE
);

CREATE TABLE telefone (
    telefone CHAR(15) PRIMARY KEY,
    fk_matricula INTEGER NOT NULL,
    
    CONSTRAINT fk_telefone_funcionario
        FOREIGN KEY (fk_matricula)
        REFERENCES funcionario(matricula)
        ON DELETE CASCADE
);