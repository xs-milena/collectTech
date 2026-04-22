-- criação do banco de dados
CREATE DATABASE collect_tech;
USE collect_tech;

-- Cadastro empresa
CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    telefone CHAR(11),
    email VARCHAR(100) NOT NULL UNIQUE, -- EMAIL único
    senha VARCHAR(100) NOT NULL,
    situacao_usuario BOOLEAN NOT NULL DEFAULT FALSE, -- ativo ou inativo
    colocado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    codigo_ativacao CHAR(5) UNIQUE NOT NULL
);


-- Cadastro/login funcionário
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE, -- CPF único
    telefone CHAR(11),
    email VARCHAR(100) NOT NULL UNIQUE, -- EMAIL único
    senha VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    situacao_usuario BOOLEAN NOT NULL DEFAULT FALSE, -- ativo ou inativo
    fk_empresa INT NOT NULL,
    colocado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP(), CONSTRAINT check_cargo CHECK (cargo IN ('gestor ambiental', 'coordenador', 'motorista')),
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

INSERT INTO usuario (nome, cpf, telefone, email, senha, cargo, situacao_usuario) VALUES
('Alan Crivellaro Hyppolito', '11111111111', '11911111111', 'alan@gmail.com', '293i2e', 'coordenador', TRUE),
('Júlia Sampaio Macêdo', '22222222222', '11922222222', 'julia@gmail.com', '28u2e82', 'gestor ambiental', TRUE),
('Lucas Nogueira Buono de Albuquerque', '33333333333', '11933333333', 'lucas@gmail.com', '93iend', 'coordenador', TRUE),
('Milena Maria de Amorim Silva', '44444444444', '11944444444', 'milena@gmail.com', '1dkdn2', 'motorista', TRUE),
('Sophie de Souza Ferraz', '55555555555', '11955555555', 'sophie@gmail.com', '92n292', 'motorista', TRUE),
('Thabata Vitoria Daniel de Sousa', '66666666666', '11966666666', 'thabata@gmail.com', '212un21', 'gestor ambiental', TRUE);

-- endereco do ecoponto
CREATE TABLE ecoponto (
    id_ecoponto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    subprefeitura VARCHAR(100),
    nome_ecoponto VARCHAR(200),
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cep CHAR(8) NOT NULL,
    estado CHAR(2) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    fk_empresa INT NOT NULL,
    colocado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

INSERT INTO ecoponto (subprefeitura, nome_ecoponto, rua, numero, bairro, cep, estado, municipio, recebe_gesso) VALUES
('Carrão', 'Viaduto Engenheiro Alberto Badra', 'Avenida Aricanduva', 200, 'Aricanduva', '03501010', 'SP', 'São Paulo', 1),
('Butantã', 'Jardim Maria do Carmo', 'Rua Caminho do Engenho', 800, 'Ferreira', '05524000', 'SP', 'São Paulo', 0),
('Butantã', 'Giovani Gronchi', 'Avenida Giovani Gronchi', 3413,'Morumbi', '05651002', 'SP', 'São Paulo', 0),
('Guaianases', 'Jardim São Paulo','Rua Utaro Kanai', 374,'Conjunto Habitacional Juscelino Kubitschek', '08465000', 'SP', 'São Paulo', 0),
('Jabaquara', 'Imigrantes', 'Rua Opixe', 232, 'Vila Guarani', '04312080', 'SP', 'São Paulo', 1);

-- lixeira
CREATE TABLE lixeira (
    id_lixeira INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    comprimento INT NOT NULL, -- em cm
    largura INT NOT NULL, -- em cm
    altura INT NOT NULL, -- em cm
    capacidade INT NOT NULL, -- volume em cm
    fk_ecoponto INT NOT NULL,
    colocado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (fk_ecoponto) REFERENCES ecoponto(id_ecoponto)
);

INSERT INTO lixeira (comprimento, largura, altura, capacidade, fk_ecoponto, fk_sensor, fk_tipo_descarte) VALUES
(190, 95, 190, 115, 1, 1, 1),
(190, 95, 190, 115, 2, 2,2),
(190, 95, 190, 115, 3, 3,3),
(190, 95, 190, 115, 4, 4,4),
(190, 95, 190, 115, 5, 5,5);

-- sensor (em caso de queima, dará para saber qual sensor queimou)
CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    situacao_sensor BOOLEAN NOT NULL DEFAULT FALSE, -- ativo 1 ou inativo 0
    fk_lixeira INT NOT NULL,
    colocado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (fk_lixeira) REFERENCES lixeira(id_lixeira)
);

INSERT INTO sensor (situacao_sensor) VALUES
(TRUE),
(FALSE),
(TRUE),
(TRUE);
        
-- leitura do sensor
CREATE TABLE leitura_sensor (
    id_leitura INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nivel_cheia DECIMAL(3,2) NOT NULL,
    fk_sensor INT NOT NULL,
    colocado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor)
);

INSERT INTO empresa (cnpj, telefone, email, senha, situacao_usuario, codigo_ativacao) VALUES
('11111111000101', '11911111111', 'corp1@tech.com', 'pass123', true, 'AB123'),
('22222222000102', '11922222222', 'corp2@tech.com', 'pass123', true, 'CD456'),
('33333333000103', '11933333333', 'corp3@tech.com', 'pass123', true, 'EF789'),
('44444444000104', '11944444444', 'corp4@tech.com', 'pass123', true, 'GH101'),
('55555555000105', '11955555555', 'corp5@tech.com', 'pass123', true, 'IJ112'),
('66666666000106', '11966666666', 'corp6@tech.com', 'pass123', true, 'KL131'),
('77777777000107', '11977777777', 'corp7@tech.com', 'pass123', true, 'MN415'),
('88888888000108', '11988888888', 'corp8@tech.com', 'pass123', true, 'OP161'),
('99999999000109', '11999999999', 'corp9@tech.com', 'pass123', true, 'QR718'),
('00000000000100', '11900000000', 'corp10@tech.com', 'pass123', true, 'ST191');


SELECT u.nome, e.cnpj FROM usuario u INNER JOIN empresa e ON u.fk_empresa = e.id_empresa;

SELECT u.nome, e.email FROM usuario u INNER JOIN empresa e ON u.fk_empresa = e.id_empresa WHERE u.cargo = 'motorista';

SELECT ec.nome_ecoponto, l.id_lixeira FROM ecoponto ec INNER JOIN lixeira l ON ec.id_ecoponto = l.fk_ecoponto;

SELECT ec.bairro, s.id_sensor FROM ecoponto ec INNER JOIN lixeira l ON ec.id_ecoponto = l.fk_ecoponto INNER JOIN sensor s ON l.id_lixeira = s.fk_lixeira;

SELECT * FROM usuario ORDER BY colocado_em DESC;


UPDATE usuario SET situacao_usuario = false WHERE id_usuario = 1;

UPDATE usuario SET cargo = 'gestor ambiental' WHERE id_usuario = 3;

UPDATE usuario SET telefone = '11900000000' WHERE id_usuario = 5;

UPDATE usuario SET atualizado_em = NOW() WHERE fk_empresa = 1;

UPDATE usuario SET nome = 'Alan C. Hyppolito' WHERE id_usuario = 1;

UPDATE ecoponto SET municipio = 'S. Paulo' WHERE estado = 'SP';

UPDATE lixeira SET capacidade = 500 WHERE id_lixeira > 8;

UPDATE leitura_sensor SET nivel_cheia = 0.0 WHERE fk_sensor = 4;

UPDATE leitura_sensor SET colocado_em = NOW() WHERE id_leitura = 50;

DELETE FROM leitura_sensor WHERE colocado_em < '2023-01-01'
