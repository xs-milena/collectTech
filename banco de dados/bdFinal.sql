-- criação do banco de dados
CREATE DATABASE collect_tech;

USE collect_tech;

-- EMPRESA

CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    codigo_ativacao CHAR(5) UNIQUE NOT NULL
);

INSERT INTO empresa (cnpj, codigo_ativacao)
VALUES
('11111111000101', 'AB123'),
('22222222000102', 'CD456');

-- FUNCIONÁRIO
CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    telefone CHAR(11),
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    fk_empresa INT NOT NULL,
    cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT check_cargo CHECK (
        cargo IN ('gestor ambiental', 'coordenador', 'motorista')
    ),

    FOREIGN KEY (fk_empresa)
        REFERENCES empresa(id_empresa)
);

INSERT INTO funcionario (
    nome,
    telefone,
    email,
    senha,
    cargo,
    ativo,
    fk_empresa
)
VALUES
(
    'Alan Crivellaro Hyppolito',
    '11911111111',
    'alan@gmail.com',
    SHA2('293i2e', 256),
    'coordenador',
    TRUE,
    1
),
(
    'Júlia Sampaio Macêdo',
    '11922222222',
    'julia@gmail.com',
    SHA2('28u2e82', 256),
    'motorista',
    TRUE,
    1
),
(
    'Lucas Nogueira Buono de Albuquerque',
    '11933333333',
    'lucas@gmail.com',
    SHA2('93iend', 256),
    'motorista',
    TRUE,
    1
),
(
    'Milena Maria de Amorim Silva',
    '11944444444',
    'milena@gmail.com',
    SHA2('1dkdn2', 256),
    'coordenador',
    TRUE,
    2
),
(
    'Sophie de Souza Ferraz',
    '11955555555',
    'sophie@gmail.com',
    SHA2('92n292', 256),
    'motorista',
    TRUE,
    2
),
(
    'Thabata Vitoria Daniel de Sousa',
    '11966666666',
    'thabata@gmail.com',
    SHA2('212un21', 256),
    'coordenador',
    TRUE,
    2
);

-- SUBPREFEITURA

CREATE TABLE subprefeitura (
    id_subprefeitura INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(225) NOT NULL
);

INSERT INTO subprefeitura (nome)
VALUES
('Sé'),
('Pinheiros');


CREATE TABLE empresa_subprefeitura(
	fk_empresa INT NOT NULL,
    fk_subprefeitura INT NOT NULL,
    PRIMARY KEY(fk_empresa, fk_subprefeitura),
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
    FOREIGN KEY (fk_subprefeitura) REFERENCES subprefeitura(id_subprefeitura)
);

INSERT INTO empresa_subprefeitura (fk_empresa, fk_subprefeitura)
VALUES
(1,1),
(1,2),
(2,2);

-- ECOPONTO
CREATE TABLE ecoponto (
    id_ecoponto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_ecoponto VARCHAR(200) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cep CHAR(9) NOT NULL,
    latitude DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,
    estado CHAR(2) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fk_subprefeitura INT NOT NULL,
    fk_empresa INT NOT NULL,
    
    CONSTRAINT fk_ecoponto_empresa_subprefeitura
        FOREIGN KEY (fk_empresa ,fk_subprefeitura)
        REFERENCES empresa_subprefeitura(fk_empresa, fk_subprefeitura)
);

INSERT INTO ecoponto (
    nome_ecoponto,
    rua,
    numero,
    bairro,
    cep,
    latitude,
    longitude,
    estado,
    municipio,
    fk_subprefeitura,
    fk_empresa
)
VALUES
('Ecoponto Liberdade Norte','Rua Conselheiro Furtado','1200','Liberdade','01508-000',-23.5635,-46.6324,'SP','São Paulo',1,1),
('Ecoponto Liberdade Sul','Rua Galvão Bueno','850','Liberdade','01506-000',-23.5618,-46.6352,'SP','São Paulo',1,1),
('Ecoponto Liberdade Leste','Rua da Glória','430','Liberdade','01510-000',-23.5661,-46.6295,'SP','São Paulo',1,1),

('Ecoponto Sé Central','Rua da Figueira','500','Sé','01007-000',-23.5484,-46.6264,'SP','São Paulo',1,1),
('Ecoponto Sé Leste','Rua Florêncio de Abreu','320','Sé','01030-000',-23.5449,-46.6331,'SP','São Paulo',1,1),
('Ecoponto Sé Norte','Rua Boa Vista','710','Sé','01014-000',-23.5470,-46.6355,'SP','São Paulo',1,1),

('Ecoponto Cambuci','Av. Lins de Vasconcelos','1800','Cambuci','01538-001',-23.5684,-46.6231,'SP','São Paulo',1,1),
('Ecoponto Cambuci Sul','Rua Clímaco Barbosa','420','Cambuci','01523-001',-23.5731,-46.6205,'SP','São Paulo',1,1),
('Ecoponto Cambuci Norte','Rua do Lavapés','1500','Cambuci','01519-000',-23.5659,-46.6202,'SP','São Paulo',1,1),

('Ecoponto Bela Vista','Rua Treze de Maio','1500','Bela Vista','01327-000',-23.5663,-46.6445,'SP','São Paulo',1,1),
('Ecoponto Bela Vista Oeste','Rua Rui Barbosa','700','Bela Vista','01326-010',-23.5609,-46.6461,'SP','São Paulo',1,1),
('Ecoponto Bela Vista Norte','Rua Santo Antônio','520','Bela Vista','01314-000',-23.5537,-46.6417,'SP','São Paulo',1,1),

('Ecoponto Alto de Pinheiros','Praça Arcipreste Anselmo','15','Alto de Pinheiros','05463-080',-23.5571,-46.7112,'SP','São Paulo',2,1),
('Ecoponto Alto de Pinheiros Norte','Rua Pio XI','980','Alto de Pinheiros','05468-000',-23.5524,-46.7075,'SP','São Paulo',2,1),
('Ecoponto Alto de Pinheiros Sul','Av. Diógenes Ribeiro','1400','Alto de Pinheiros','05458-001',-23.5541,-46.7180,'SP','São Paulo',2,1),

('Ecoponto Vila Madalena','Rua Girassol','15','Vila Madalena','05433-000',-23.5507,-46.6894,'SP','São Paulo',2,2),
('Ecoponto Vila Madalena Oeste','Rua Harmonia','400','Vila Madalena','05435-000',-23.5528,-46.6915,'SP','São Paulo',2,2),
('Ecoponto Vila Madalena Norte','Rua Wisard','220','Vila Madalena','05434-080',-23.5481,-46.6877,'SP','São Paulo',2,2),

('Ecoponto Pinheiros','Praça do Cancioneiro','15','Pinheiros','05422-000',-23.5672,-46.6921,'SP','São Paulo',2,2),
('Ecoponto Pinheiros Oeste','Rua dos Pinheiros','1200','Pinheiros','05422-002',-23.5615,-46.6824,'SP','São Paulo',2,2),
('Ecoponto Pinheiros Norte','Rua Teodoro Sampaio','2100','Pinheiros','05406-150',-23.5569,-46.6840,'SP','São Paulo',2,2);


-- LIXEIRA

CREATE TABLE lixeira (
    id_lixeira INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    comprimento DECIMAL(5,2) NOT NULL,
    largura DECIMAL(5,2) NOT NULL,
    altura DECIMAL(5,2) NOT NULL,
    capacidade DECIMAL(7,2) NOT NULL,
    fk_ecoponto INT NOT NULL,
    cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_lixeira_ecoponto
        FOREIGN KEY (fk_ecoponto)
        REFERENCES ecoponto(id_ecoponto)
);

INSERT INTO lixeira (
    comprimento,
    largura,
    altura,
    capacidade,
    fk_ecoponto
)
VALUES
(190.5,95.5,190.5,115.5,1),
(190.5,95.5,190.5,115.5,1),
(190.5,95.5,190.5,115.5,1),
(190.5,95.5,190.5,115.5,2),
(190.5,95.5,190.5,115.5,2),
(190.5,95.5,190.5,115.5,2),
(190.5,95.5,190.5,115.5,3),
(190.5,95.5,190.5,115.5,3),
(190.5,95.5,190.5,115.5,3),
(190.5,95.5,190.5,115.5,4),
(190.5,95.5,190.5,115.5,4),
(190.5,95.5,190.5,115.5,4),
(190.5,95.5,190.5,115.5,5),
(190.5,95.5,190.5,115.5,5),
(190.5,95.5,190.5,115.5,5),
(190.5,95.5,190.5,115.5,6),
(190.5,95.5,190.5,115.5,6),
(190.5,95.5,190.5,115.5,6),
(190.5,95.5,190.5,115.5,7),
(190.5,95.5,190.5,115.5,7),
(190.5,95.5,190.5,115.5,7),
(190.5,95.5,190.5,115.5,8),
(190.5,95.5,190.5,115.5,8),
(190.5,95.5,190.5,115.5,8),
(190.5,95.5,190.5,115.5,9),
(190.5,95.5,190.5,115.5,9),
(190.5,95.5,190.5,115.5,9),
(190.5,95.5,190.5,115.5,10),
(190.5,95.5,190.5,115.5,10),
(190.5,95.5,190.5,115.5,10),
(190.5,95.5,190.5,115.5,11),
(190.5,95.5,190.5,115.5,11),
(190.5,95.5,190.5,115.5,11),
(190.5,95.5,190.5,115.5,12),
(190.5,95.5,190.5,115.5,12),
(190.5,95.5,190.5,115.5,12),
(190.5,95.5,190.5,115.5,13),
(190.5,95.5,190.5,115.5,13),
(190.5,95.5,190.5,115.5,13),
(190.5,95.5,190.5,115.5,14),
(190.5,95.5,190.5,115.5,14),
(190.5,95.5,190.5,115.5,14),
(190.5,95.5,190.5,115.5,15),
(190.5,95.5,190.5,115.5,15),
(190.5,95.5,190.5,115.5,15),
(190.5,95.5,190.5,115.5,16),
(190.5,95.5,190.5,115.5,16),
(190.5,95.5,190.5,115.5,16),
(190.5,95.5,190.5,115.5,17),
(190.5,95.5,190.5,115.5,17),
(190.5,95.5,190.5,115.5,17),
(190.5,95.5,190.5,115.5,18),
(190.5,95.5,190.5,115.5,18),
(190.5,95.5,190.5,115.5,18),
(190.5,95.5,190.5,115.5,19),
(190.5,95.5,190.5,115.5,19),
(190.5,95.5,190.5,115.5,19),
(190.5,95.5,190.5,115.5,20),
(190.5,95.5,190.5,115.5,20),
(190.5,95.5,190.5,115.5,20),
(190.5,95.5,190.5,115.5,21),
(190.5,95.5,190.5,115.5,21),
(190.5,95.5,190.5,115.5,21);

-- SENSOR
-- 2 sensores por lixeira
CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    status_sensor BOOLEAN DEFAULT TRUE,
    fk_lixeira INT NOT NULL,
    cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_sensor_lixeira
        FOREIGN KEY (fk_lixeira)
        REFERENCES lixeira(id_lixeira)
);

INSERT INTO sensor (
    modelo,
    status_sensor,
    fk_lixeira
)
VALUES
('HC-SR04', TRUE, 1),('HC-SR04', TRUE, 1),
('HC-SR04', TRUE, 2),('HC-SR04', TRUE, 2),
('HC-SR04', TRUE, 3),('HC-SR04', TRUE, 3),
('HC-SR04', TRUE, 4),('HC-SR04', TRUE, 4),
('HC-SR04', TRUE, 5),('HC-SR04', TRUE, 5),
('HC-SR04', TRUE, 6),('HC-SR04', TRUE, 6),
('HC-SR04', TRUE, 7),('HC-SR04', TRUE, 7),
('HC-SR04', TRUE, 8),('HC-SR04', TRUE, 8),
('HC-SR04', TRUE, 9),('HC-SR04', TRUE, 9),
('HC-SR04', TRUE, 10),('HC-SR04', TRUE, 10),
('HC-SR04', TRUE, 11),('HC-SR04', TRUE, 11),
('HC-SR04', TRUE, 12),('HC-SR04', TRUE, 12),
('HC-SR04', TRUE, 13),('HC-SR04', TRUE, 13),
('HC-SR04', TRUE, 14),('HC-SR04', TRUE, 14),
('HC-SR04', TRUE, 15),('HC-SR04', TRUE, 15),
('HC-SR04', TRUE, 16),('HC-SR04', TRUE, 16),
('HC-SR04', TRUE, 17),('HC-SR04', TRUE, 17),
('HC-SR04', TRUE, 18),('HC-SR04', TRUE, 18),
('HC-SR04', TRUE, 19),('HC-SR04', TRUE, 19),
('HC-SR04', TRUE, 20),('HC-SR04', TRUE, 20),
('HC-SR04', TRUE, 21),('HC-SR04', TRUE, 21),
('HC-SR04', TRUE, 22),('HC-SR04', TRUE, 22),
('HC-SR04', TRUE, 23),('HC-SR04', TRUE, 23),
('HC-SR04', TRUE, 24),('HC-SR04', TRUE, 24),
('HC-SR04', TRUE, 25),('HC-SR04', TRUE, 25),
('HC-SR04', TRUE, 26),('HC-SR04', TRUE, 26),
('HC-SR04', TRUE, 27),('HC-SR04', TRUE, 27),
('HC-SR04', TRUE, 28),('HC-SR04', TRUE, 28),
('HC-SR04', TRUE, 29),('HC-SR04', TRUE, 29),
('HC-SR04', TRUE, 30),('HC-SR04', TRUE, 30),
('HC-SR04', TRUE, 31),('HC-SR04', TRUE, 31),
('HC-SR04', TRUE, 32),('HC-SR04', TRUE, 32),
('HC-SR04', TRUE, 33),('HC-SR04', TRUE, 33),
('HC-SR04', TRUE, 34),('HC-SR04', TRUE, 34),
('HC-SR04', TRUE, 35),('HC-SR04', TRUE, 35),
('HC-SR04', TRUE, 36),('HC-SR04', TRUE, 36),
('HC-SR04', TRUE, 37),('HC-SR04', TRUE, 37),
('HC-SR04', TRUE, 38),('HC-SR04', TRUE, 38),
('HC-SR04', TRUE, 39),('HC-SR04', TRUE, 39),
('HC-SR04', TRUE, 40),('HC-SR04', TRUE, 40),
('HC-SR04', TRUE, 41),('HC-SR04', TRUE, 41),
('HC-SR04', TRUE, 42),('HC-SR04', TRUE, 42),
('HC-SR04', TRUE, 43),('HC-SR04', TRUE, 43),
('HC-SR04', TRUE, 44),('HC-SR04', TRUE, 44),
('HC-SR04', TRUE, 45),('HC-SR04', TRUE, 45),
('HC-SR04', TRUE, 46),('HC-SR04', TRUE, 46),
('HC-SR04', TRUE, 47),('HC-SR04', TRUE, 47),
('HC-SR04', TRUE, 48),('HC-SR04', TRUE, 48),
('HC-SR04', TRUE, 49),('HC-SR04', TRUE, 49),
('HC-SR04', TRUE, 50),('HC-SR04', TRUE, 50),
('HC-SR04', TRUE, 51),('HC-SR04', TRUE, 51),
('HC-SR04', TRUE, 52),('HC-SR04', TRUE, 52),
('HC-SR04', TRUE, 53),('HC-SR04', TRUE, 53),
('HC-SR04', TRUE, 54),('HC-SR04', TRUE, 54),
('HC-SR04', TRUE, 55),('HC-SR04', TRUE, 55),
('HC-SR04', TRUE, 56),('HC-SR04', TRUE, 56),
('HC-SR04', TRUE, 57),('HC-SR04', TRUE, 57),
('HC-SR04', TRUE, 58),('HC-SR04', TRUE, 58),
('HC-SR04', TRUE, 59),('HC-SR04', TRUE, 59),
('HC-SR04', TRUE, 60),('HC-SR04', TRUE, 60),
('HC-SR04', TRUE, 61),('HC-SR04', TRUE, 61),
('HC-SR04', TRUE, 62),('HC-SR04', TRUE, 62),
('HC-SR04', TRUE, 63),('HC-SR04', TRUE, 63);

-- LEITURA SENSOR

CREATE TABLE leitura_sensor (
    id_leitura INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nivel_preenchimento DECIMAL(5,2) NOT NULL,
    fk_sensor INT NOT NULL,
    cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (fk_sensor)
        REFERENCES sensor(id_sensor)
);

INSERT INTO leitura_sensor (
    nivel_preenchimento,
    fk_sensor
)
VALUES
(15,1),(32,1),(48,1),
(22,2),(37,2),(59,2),
(41,3),(55,3),(67,3),
(12,4),(26,4),(38,4),
(73,5),(81,5),(95,5),
(17,6),(29,6),(44,6),
(64,7),(78,7),(88,7),
(11,8),(19,8),(25,8),
(49,9),(58,9),(69,9),
(35,10),(47,10),(53,10),
(27,11),(34,11),(45,11),
(52,12),(61,12),(70,12),
(18,13),(23,13),(39,13),
(76,14),(84,14),(92,14),
(14,15),(21,15),(33,15),
(46,16),(57,16),(68,16),
(71,17),(82,17),(94,17),
(13,18),(28,18),(40,18),
(51,19),(63,19),(74,19),
(16,20),(24,20),(36,20),
(43,21),(54,21),(66,21),
(79,22),(87,22),(96,22),
(10,23),(20,23),(31,23),
(42,24),(56,24),(65,24),
(72,25),(83,25),(91,25),
(15,26),(27,26),(35,26),
(48,27),(62,27),(77,27),
(18,28),(30,28),(41,28),
(53,29),(64,29),(75,29),
(12,30),(22,30),(37,30),
(47,31),(59,31),(71,31),
(80,32),(89,32),(97,32),
(14,33),(25,33),(36,33),
(45,34),(58,34),(69,34),
(73,35),(85,35),(93,35),
(11,36),(19,36),(28,36),
(44,37),(57,37),(68,37),
(74,38),(86,38),(95,38),
(13,39),(26,39),(38,39),
(49,40),(60,40),(72,40),
(17,41),(29,41),(43,41),
(55,42),(67,42),(78,42),
(21,43),(33,43),(46,43),
(58,44),(70,44),(82,44),
(24,45),(39,45),(51,45),
(63,46),(75,46),(88,46),
(16,47),(28,47),(40,47),
(52,48),(64,48),(76,48),
(18,49),(31,49),(45,49),
(57,50),(69,50),(81,50),
(23,51),(35,51),(47,51),
(59,52),(71,52),(84,52),
(26,53),(38,53),(50,53),
(62,54),(74,54),(86,54),
(19,55),(32,55),(44,55),
(56,56),(68,56),(79,56),
(22,57),(34,57),(48,57),
(60,58),(73,58),(85,58),
(25,59),(37,59),(49,59),
(61,60),(72,60),(83,60),
(27,61),(41,61),(53,61),
(65,62),(77,62),(89,62),
(30,63),(42,63),(54,63),
(66,64),(78,64),(90,64),
(15,65),(27,65),(39,65),
(51,66),(63,66),(75,66),
(18,67),(30,67),(42,67),
(54,68),(66,68),(78,68),
(21,69),(33,69),(45,69),
(57,70),(69,70),(81,70),
(24,71),(36,71),(48,71),
(60,72),(72,72),(84,72),
(27,73),(39,73),(51,73),
(63,74),(75,74),(87,74),
(30,75),(42,75),(54,75),
(66,76),(78,76),(90,76),
(14,77),(26,77),(38,77),
(50,78),(62,78),(74,78),
(17,79),(29,79),(41,79),
(53,80),(65,80),(77,80),
(20,81),(32,81),(44,81),
(56,82),(68,82),(80,82),
(23,83),(35,83),(47,83),
(59,84),(71,84),(83,84),
(26,85),(38,85),(50,85),
(62,86),(74,86),(86,86),
(29,87),(41,87),(53,87),
(65,88),(77,88),(89,88),
(12,89),(24,89),(36,89),
(48,90),(60,90),(72,90),
(15,91),(27,91),(39,91),
(51,92),(63,92),(75,92),
(18,93),(30,93),(42,93),
(54,94),(66,94),(78,94),
(21,95),(33,95),(45,95),
(57,96),(69,96),(81,96),
(24,97),(36,97),(48,97),
(60,98),(72,98),(84,98),
(27,99),(39,99),(51,99),
(63,100),(75,100),(87,100),
(30,101),(42,101),(54,101),
(66,102),(78,102),(90,102),
(16,103),(28,103),(40,103),
(52,104),(64,104),(76,104),
(19,105),(31,105),(43,105),
(55,106),(67,106),(79,106),
(22,107),(34,107),(46,107),
(58,108),(70,108),(82,108),
(25,109),(37,109),(49,109),
(61,110),(73,110),(85,110),
(28,111),(40,111),(52,111),
(64,112),(76,112),(88,112),
(13,113),(25,113),(37,113),
(49,114),(61,114),(73,114),
(16,115),(28,115),(40,115),
(52,116),(64,116),(76,116),
(19,117),(31,117),(43,117),
(55,118),(67,118),(79,118),
(22,119),(34,119),(46,119),
(58,120),(70,120),(82,120),
(25,121),(37,121),(49,121),
(61,122),(73,122),(85,122),
(28,123),(40,123),(52,123),
(64,124),(76,124),(88,124),
(31,125),(43,125),(55,125),
(67,126),(79,126),(91,126);




-- -- select que mostra o nível de preenchimento da lixeira de acordo com o id do sensor
-- CREATE VIEW
--     captura_ultimos_dados_sensor AS
-- SELECT
--     id_sensor,
--     l.nivel_preenchimento,
--     l.cadastrado_em,
--     DATE_FORMAT (l.cadastrado_em, '%H:%i:%s')
-- FROM
--     leitura_sensor as l
--     join sensor on l.fk_sensor = id_sensor
--     join lixeira on fk_lixeira = id_lixeira
--     join ecoponto on fk_ecoponto = id_ecoponto
-- WHERE
--     fk_ecoponto = 1
-- ORDER BY
--     id_ecoponto DESC
-- LIMIT
--     7;

-- select
--     *
-- from
--     captura_ultimos_dados_sensor;

-- CREATE VIEW
--     captura_nivel_sensor AS
-- SELECT
--     l.nivel_preenchimento,
--     l.cadastrado_em,
--     DATE_FORMAT (l.cadastrado_em, '%H:%i:%s')
-- FROM
--     leitura_sensor as l
--     join sensor on l.fk_sensor = id_sensor
--     join lixeira on fk_lixeira = id_lixeira
--     join ecoponto on fk_ecoponto = id_ecoponto
-- WHERE
--     fk_ecoponto = id_ecoponto
-- ORDER BY
--     l.cadastrado_em DESC
-- LIMIT
--     1;

-- select
--     *
-- from
--     captura_nivel_sensor;

-- SELECT
--     ec.bairro,
--     s.id_sensor
-- FROM
--     ecoponto ec
--     INNER JOIN lixeira l ON ec.id_ecoponto = l.fk_ecoponto
--     INNER JOIN sensor s ON l.id_lixeira = s.fk_lixeira;

-- -- sensor e bairro
-- CREATE VIEW
--     captura_ultimos_dados_sensor_tabela AS
-- SELECT
--     e.nome_ecoponto ecoponto,
--     id_sensor codigo,
--     l.nivel_preenchimento nivel,
--     DATE_FORMAT (l.cadastrado_em, '%H:%i:%s') captura,
--     DATE_FORMAT (l.cadastrado_em, '%d/%m/%Y') data
-- FROM
--     leitura_sensor as l
--     join sensor on l.fk_sensor = id_sensor
--     join lixeira on fk_lixeira = id_lixeira
--     join ecoponto e on fk_ecoponto = e.id_ecoponto
-- ORDER BY
--     e.id_ecoponto DESC
-- LIMIT
--     7;

-- select
--     *
-- from
--     captura_ultimos_dados_sensor_tabela;

    
CREATE VIEW captura_ultimos_dados_sensor
AS
  SELECT id_sensor,
        l.nivel_preenchimento,
        l.cadastrado_em, DATE_FORMAT(l.cadastrado_em,'%H:%i:%s')
	    FROM leitura_sensor as l
        join sensor on l.fk_sensor = id_sensor
        join lixeira on fk_lixeira = id_lixeira
        join ecoponto on fk_ecoponto = id_ecoponto
	    ORDER BY id_ecoponto DESC LIMIT 7;

select * from captura_ultimos_dados_sensor;



CREATE VIEW captura_nivel_sensor
AS
SELECT 
        l.nivel_preenchimento,
        l.cadastrado_em, DATE_FORMAT(l.cadastrado_em,'%H:%i:%s')
	    FROM leitura_sensor as l
        join sensor on l.fk_sensor = id_sensor
        join lixeira on fk_lixeira = id_lixeira
        join ecoponto on fk_ecoponto = id_ecoponto
	    WHERE fk_ecoponto = id_ecoponto
	    ORDER BY l.cadastrado_em DESC LIMIT 1;

select * from captura_nivel_sensor;



create view vw_nivel_lixeiras_empresa
as
SELECT 
    li.id_lixeira,
    emp.id_empresa,
    SUBSTRING_INDEX( GROUP_CONCAT(l.nivel_preenchimento ORDER BY l.cadastrado_em DESC), ',', 1 ) AS nivel_preenchimento,
    MAX(l.cadastrado_em) AS cadastrado_em,
    nome_ecoponto, id_ecoponto
FROM leitura_sensor AS l 
JOIN sensor AS s ON l.fk_sensor = s.id_sensor 
JOIN lixeira AS li ON s.fk_lixeira = li.id_lixeira 
JOIN ecoponto AS e ON li.fk_ecoponto = e.id_ecoponto 
JOIN empresa AS emp ON e.fk_empresa = emp.id_empresa 
GROUP BY li.id_lixeira
order by nivel_preenchimento desc;

select * from vw_nivel_lixeiras_empresa;

update leitura_sensor
set nivel_preenchimento = 60
where nivel_preenchimento = 95;

update leitura_sensor
set nivel_preenchimento = 49
where nivel_preenchimento = 77;

create view vw_bairros_empresa
as
select e.id_empresa, eco.bairro,
(sum(case
when v.nivel_preenchimento > 80 then 1
else 0
end))
as soma_nivel_cheia,
(sum(case
when v.nivel_preenchimento > 50 and v.nivel_preenchimento <= 80 then 1
else 0
end))
as soma_nivel_medio,
(sum(case
when v.nivel_preenchimento <= 50 then 1
else 0
end))
as soma_nivel_baixo
from vw_nivel_lixeiras_empresa v
join empresa e on e.id_empresa = v.id_empresa 
join ecoponto eco on v.id_ecoponto = eco.id_ecoponto
join subprefeitura s on eco.fk_subprefeitura = s.id_subprefeitura 
GROUP BY e.id_empresa, eco.bairro;

select * from vw_bairros_empresa
where bairro = "Bela Vista" and id_empresa = 1;


select * from funcionario;
update funcionario
set cargo = "gestor ambiental"
where cargo = "motorista";

create view vw_nivel_ecoponto
as
SELECT 
    vw.nome_ecoponto ecoponto,
    e.bairro,
    vw.id_empresa,
    MAX(DATE_FORMAT(vw.cadastrado_em, '%H:%i:%s')) AS captura,
    MAX(DATE_FORMAT(vw.cadastrado_em, '%d/%m/%Y')) AS data,
    AVG(vw.nivel_preenchimento) AS nivel
FROM 
    vw_nivel_lixeiras_empresa vw
join ecoponto e on e.id_ecoponto = vw.id_ecoponto 
GROUP BY 
    vw.id_ecoponto, 
    vw.nome_ecoponto;

select * from vw_nivel_ecoponto;



create view vw_total_lixeiras
as
select e.id_empresa, count(v.id_lixeira) as total,
sum(case
when v.nivel_preenchimento > 80 then 1
else 0
end)
as total_nivel_cheia,
sum( case
when v.nivel_preenchimento > 50 and v.nivel_preenchimento <= 80 then 1
else 0
end)
as total_nivel_medio,
sum(case
when v.nivel_preenchimento <= 50 then 1
else 0
end)
as total_nivel_baixo
from vw_nivel_lixeiras_empresa v
join empresa e on e.id_empresa = v.id_empresa 
join ecoponto eco on v.id_ecoponto = eco.id_ecoponto
join subprefeitura s on eco.fk_subprefeitura = s.id_subprefeitura 
GROUP BY e.id_empresa;