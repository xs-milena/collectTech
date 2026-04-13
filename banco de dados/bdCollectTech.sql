CREATE DATABASE IF NOT EXISTS collectTech2;

USE collectTech2;


CREATE TABLE IF NOT EXISTS usuario(
id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
senha VARCHAR(255) NOT NULL,
tel CHAR(11) NOT NULL,
cargo VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS lixeiras(
id_lixeira INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
lotacao TINYINT (2), -- 0 vazio, 1 lotado
logradouro VARCHAR(255) NOT NULL,
numero VARCHAR(4) NOT NULL,
cep VARCHAR(8) NOT NULL
);

CREATE TABLE IF NOT EXISTS caminhoes(
id_caminhao INT PRIMARY KEY NOT NULL,
disponivel TINYINT(2) NOT NULL, -- 0 Disponivel, 1 Indisponivel
placa VARCHAR(7)
);

CREATE TABLE IF NOT EXISTS sensor(
id_sensor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
funcionando TINYINT(2) NOT NULL, -- 0 Ativo, 1 Inativo
dados int, 
data_instalado DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
tempo_evento datetime, 
);

INSERT INTO usuario (id_usuario, nome, email, senha, tel, cargo) 
VALUES (1,'Leticia', 'leticia.bastos@sptechschool.com', '12345', '11991476333', 'Analista de dados'), 
(2,'Andre', 'andrezinho@email.com', '1234565', '11991476334', 'Gestor'), 
(3,'Samuel', 'santos@email.com', '123123', '11991472222', 'Motorista'), 
(4, 'Luis', 'luis.sptech@email.com', '3821', '11997382867', 'Administrador');

SELECT * FROM usuario;

SELECT * FROM usuario WHERE cargo = 'Motorista';

INSERT INTO lixeiras (id_lixeira, lotacao, logradouro, numero, cep) 
VALUES (1, 0,'Avenida Paulista', '1578', '01310200'),
(2, 1, 'Rua Augusta', '1500', '01304001'),
(3, 0, 'Rua da Consolação', '2300', '01302000'),
(4, 0, 'Avenida Brigadeiro Faria Lima', '3477', '04538133'),
(5, 1, 'Avenida Rebouças', '3970', '05402600'),
(6, 1, 'Rua Vergueiro', '3185', '04101300'),
(7, 0, 'Avenida Ibirapuera', '3103', '04029902'),
(8, 1, 'Rua Oscar Freire', '379', '01426001'),
(9, 1, 'Rua Haddock Lobo', '595', '01414001'),
(10, 1, 'Rua Teodoro Sampaio', '1020', '05406050'),
(11, 1, 'Avenida São João', '439', '01035000'),
(12, 0, 'Rua 25 de Março', '726', '01021000'),
(13, 0, 'Rua Líbero Badaró', '425', '01009000'),
(14, 1, 'Avenida Tiradentes', '615', '01102000'),
(15, 1, 'Rua Santa Ifigênia', '266', '01207000'),
(16, 0, 'Avenida Cruzeiro do Sul', '1100', '02030000'),
(17, 0, 'Rua Voluntários da Pátria', '2180', '02010300'),
(18, 1, 'Avenida Engenheiro Luís Carlos Berrini', '105', '04571010'),
(19, 1, 'Rua Doutor Arnaldo', '715', '01246000');

SELECT * FROM lixeiras;

SELECT * FROM lixeiras WHERE lotacao = 0;

INSERT INTO caminhoes (id_caminhao, disponivel, placa)
VALUES (1, 1, 'ALC1D83'), (2, 0, 'RTS5F02'), (3, 1, 'BVE2A77'),
(4, 0, 'JXM0B39'), (5, 1, 'KMP9E84');

SELECT * FROM caminhoes;

SELECT * FROM caminhoes WHERE disponivel = 1;

INSERT  INTO sensor VALUES 
(1, 0,'Avenida Paulista', DEFAULT),
(2, 0,'Rua Augusta',  DEFAULT),
(3, 0,'Rua da Consolação', DEFAULT),
(4, 1,'Avenida Brigadeiro Faria Lima', DEFAULT),
(5, 1,'Avenida Rebouças', DEFAULT),
(6, 1,'Rua Vergueiro', DEFAULT),
(7, 0,'Avenida Ibirapuera', DEFAULT),
(8, 0,'Rua Oscar Freire',  DEFAULT),
(9, 0,'Rua Haddock Lobo', DEFAULT),
(10, 1,'Rua Teodoro Sampaio',  DEFAULT),
(11, 0,'Avenida São João', DEFAULT),
(12, 1,'Rua 25 de Março', DEFAULT),
(13, 0,'Rua Líbero Badaró', DEFAULT),
(14, 1,'Avenida Tiradentes', DEFAULT),
(15, 1,'Rua Santa Ifigênia', DEFAULT),
(16, 1,'Avenida Cruzeiro do Sul', DEFAULT),
(17, 1,'Rua Voluntários da Pátria',  DEFAULT),
(18, 0,'Avenida Engenheiro Luís Carlos Berrini', DEFAULT),
(19, 0,'Rua Doutor Arnaldo', DEFAULT);

SELECT * FROM sensor WHERE funcionando = 0;

SELECT id_sensor ,local_instalado FROM sensor WHERE funcionando = 1;
