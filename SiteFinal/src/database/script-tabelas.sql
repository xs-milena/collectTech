-- criação do banco de dados
CREATE DATABASE collect_tech;
USE collect_tech;

-- Cadastro empresa
CREATE TABLE empresa (
id_empresa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cnpj CHAR(14) NOT NULL UNIQUE,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
codigo_ativacao CHAR(5) UNIQUE NOT NULL
);

INSERT INTO empresa (cnpj, codigo_ativacao) VALUES
('11111111000101', 'AB123'),
('22222222000102', 'CD456'),
('33333333000103', 'EF789'),
('44444444000104', 'GH101'),
('55555555000105', 'IJ112'),
('66666666000106', 'KL131'),
('77777777000107', 'MN415'),
('88888888000108', 'OP161'),
('99999999000109', 'QR718'),
('00000000000100', 'ST191');


-- Cadastro/login funcionário
CREATE TABLE funcionario (
id_funcionario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome VARCHAR(50) NOT NULL,
telefone CHAR(11),
email VARCHAR(100) NOT NULL UNIQUE, -- EMAIL único
senha VARCHAR(100) NOT NULL,
cargo VARCHAR(100) NOT NULL,
situacao_funcionario BOOLEAN NOT NULL DEFAULT TRUE, -- ativo ou inativo
fk_empresa INT NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP, 
CONSTRAINT check_cargo CHECK (cargo IN ('gestor ambiental', 'coordenador', 'motorista')),
FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

INSERT INTO funcionario (nome, telefone, email, senha, cargo, situacao_funcionario, fk_empresa) VALUES
('Alan Crivellaro Hyppolito', '11911111111', 'alan@gmail.com', '293i2e', 'coordenador', TRUE, 1),
('Júlia Sampaio Macêdo', '11922222222', 'julia@gmail.com', '28u2e82', 'gestor ambiental', TRUE, 2),
('Lucas Nogueira Buono de Albuquerque', '11933333333', 'lucas@gmail.com', '93iend', 'coordenador', TRUE, 3),
('Milena Maria de Amorim Silva', '11944444444', 'milena@gmail.com', '1dkdn2', 'motorista', TRUE, 4),
('Sophie de Souza Ferraz', '11955555555', 'sophie@gmail.com', '92n292', 'motorista', TRUE, 5),
('Thabata Vitoria Daniel de Sousa', '11966666666', 'thabata@gmail.com', '212un21', 'gestor ambiental', TRUE, 6);

-- subprefeitura
CREATE TABLE subprefeitura(
  id_subprefeitura INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(225) NULL,
  fk_empresa INT NOT NULL,
  CONSTRAINT fk_subprefeitura_empresa
FOREIGN KEY (fk_empresa)
    REFERENCES empresa(id_empresa)
);

INSERT INTO subprefeitura(nome, fk_empresa) VALUES
('Sé', 1),
('Liberdade', 2),
('Cambuci', 3), 
('Bela Vista', 4);


-- endereco do ecoponto
CREATE TABLE ecoponto (
  id_ecoponto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome_ecoponto VARCHAR(200) NULL DEFAULT NULL,
  rua VARCHAR(100) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  bairro VARCHAR(100) NOT NULL,
  cep CHAR(8) NOT NULL,
  estado CHAR(2) NOT NULL,
  municipio VARCHAR(50) NOT NULL,
  cadastrado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  atualizado_em DATETIME NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
  fk_subprefeitura INT NOT NULL,
  CONSTRAINT fk_ecoponto_subprefeitura
    FOREIGN KEY (fk_subprefeitura)
    REFERENCES subprefeitura (id_subprefeitura)
    );
    
INSERT INTO ecoponto (nome_ecoponto, rua, numero, bairro, cep, estado, municipio, fk_subprefeitura) VALUES
('Ecoponto Liberdade', 'Rua Conselheiro Furtado', 1200, 'Liberdade', '01511000', 'SP', 'São Paulo', 1),
('Ecoponto Sé', 'Rua da Figueira', 500, 'Sé', '01007000', 'SP', 'São Paulo', 2),
('Ecoponto Cambuci', 'Avenida Lins de Vasconcelos', 1800, 'Cambuci', '01538000', 'SP', 'São Paulo', 3),
('Ecoponto Bela Vista', 'Rua Treze de Maio', 1500, 'Bela Vista', '01327000', 'SP', 'São Paulo', 4);

-- lixeira
CREATE TABLE lixeira (
    id_lixeira INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    comprimento DECIMAL(5, 2) NOT NULL, 
    largura DECIMAL(5, 2) NOT NULL,
    altura DECIMAL(5, 2) NOT NULL,
    capacidade DECIMAL(7, 2) NOT NULL, 
    fk_ecoponto INT NOT NULL,
    cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
    atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    CONSTRAINT fk_lixeira_ecoponto FOREIGN KEY (fk_ecoponto) REFERENCES ecoponto(id_ecoponto)
);

INSERT INTO lixeira (comprimento, largura, altura, capacidade, fk_ecoponto) VALUES
(190.5, 95.5, 190.5, 115.5, 1),
(190.5, 95.5, 190.5, 115.5, 2),
(190.5, 95.5, 190.5, 115.5, 3),
(190.5, 95.5, 190.5, 115.5, 4),
(190.5, 95.5, 190.5, 115.5, 4),
(190.5, 95.5, 190.5, 115.5, 1);


-- sensor (em caso de queima, dará para saber qual sensor queimou)
CREATE TABLE sensor (
id_sensor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
situacao_sensor BOOLEAN NOT NULL DEFAULT FALSE, -- ativo 1 ou inativo 0
fk_lixeira INT NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (fk_lixeira) REFERENCES lixeira(id_lixeira)
);

INSERT INTO sensor (situacao_sensor, fk_lixeira) VALUES
(TRUE, 1),
(FALSE, 2),
(TRUE, 3),
(TRUE, 4);
        
-- leitura do sensor
CREATE TABLE leitura_sensor (
id_leitura INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nivel_preenchimento DECIMAL(5, 2) NOT NULL,
fk_sensor INT NOT NULL,
cadastrado_em DATETIME DEFAULT CURRENT_TIMESTAMP(),
FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor)
);

insert into leitura_sensor(nivel_preenchimento, fk_sensor) value
(67, 1);

insert into leitura_sensor(nivel_preenchimento, fk_sensor) values
(68, 1),
(54, 2),
(18, 3),
(38, 4),
(98, 1),
(11, 1),
(60, 1);

SELECT u.nome, e.cnpj FROM funcionario u INNER JOIN empresa e ON u.fk_empresa = e.id_empresa; -- nome e cnpj

SELECT ec.nome_ecoponto, l.id_lixeira FROM ecoponto ec INNER JOIN lixeira l ON ec.id_ecoponto = l.fk_ecoponto; -- ecoponto e lixeiras

SELECT * FROM funcionario ORDER BY cadastrado_em DESC; -- informações sobre o usuário


UPDATE funcionario SET situacao_funcionario = false WHERE id_funcionario = 1;

UPDATE funcionario SET cargo = 'gestor ambiental' WHERE id_funcionario = 3;

UPDATE funcionario SET telefone = '11900000000' WHERE id_funcionario = 5;

UPDATE funcionario SET atualizado_em = NOW() WHERE fk_empresa = 1;

UPDATE funcionario SET nome = 'Alan C. Hyppolito' WHERE id_funcionario = 1;

UPDATE lixeira SET capacidade = 500 WHERE id_lixeira > 8;

UPDATE leitura_sensor SET nivel_preenchimento = 0.0 WHERE fk_sensor = 4;

select * from funcionario where nome like "%alan%";

-- select que mostra o nível de preenchimento da lixeira de acordo com o id do sensor


CREATE VIEW captura_ultimos_dados_sensor
AS
  SELECT id_sensor,
        l.nivel_preenchimento,
        l.cadastrado_em, DATE_FORMAT(l.cadastrado_em,'%H:%i:%s')
	    FROM leitura_sensor as l
        join sensor on l.fk_sensor = id_sensor
        join lixeira on fk_lixeira = id_lixeira
        join ecoponto on fk_ecoponto = id_ecoponto
	    WHERE fk_ecoponto = 1
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

SELECT ec.bairro, s.id_sensor FROM ecoponto ec INNER JOIN lixeira l ON ec.id_ecoponto = l.fk_ecoponto INNER JOIN sensor s ON l.id_lixeira = s.fk_lixeira; -- sensor e bairro

create view vw_nivel_lixeiras_empresa
as
SELECT 
	nome_ecoponto,
	id_ecoponto,
    bairro as bairro_ecoponto,
	id_empresa,
    li.id_lixeira, 
    SUBSTRING_INDEX(GROUP_CONCAT(l.nivel_preenchimento ORDER BY l.cadastrado_em DESC), ',', 1) AS nivel_preenchimento,
    MAX(l.cadastrado_em) AS cadastrado_em
FROM leitura_sensor AS l 
JOIN sensor AS s ON l.fk_sensor = s.id_sensor 
JOIN lixeira AS li ON s.fk_lixeira = li.id_lixeira 
JOIN ecoponto AS e ON li.fk_ecoponto = e.id_ecoponto 
JOIN subprefeitura AS sub ON e.fk_subprefeitura = sub.id_subprefeitura 
JOIN empresa AS emp ON sub.fk_empresa = emp.id_empresa 
GROUP BY li.id_lixeira;

select * from leitura_sensor;
select * from subprefeitura;
update subprefeitura
set fk_empresa = 1
where fk_empresa = 2;

select id_lixeira, nome_ecoponto, id_empresa
from lixeira
join ecoponto on id_ecoponto = fk_ecoponto
join subprefeitura on id_subprefeitura = fk_subprefeitura
join empresa on id_empresa = fk_empresa;

SELECT 
        e.nome_ecoponto ecoponto,
        id_sensor codigo,
        l.nivel_preenchimento nivel,
        DATE_FORMAT(l.cadastrado_em, '%H:%i:%s') captura,
        DATE_FORMAT(l.cadastrado_em, '%d/%m/%Y') data
    FROM leitura_sensor l
    JOIN sensor ON l.fk_sensor = id_sensor
    JOIN lixeira ON fk_lixeira = id_lixeira
    JOIN ecoponto e ON fk_ecoponto = e.id_ecoponto
    JOIN subprefeitura ON e.fk_subprefeitura = id_subprefeitura
    JOIN empresa ON fk_empresa = id_empresa 
    where id_empresa = 1
    ORDER BY l.cadastrado_em;
    
select * from vw_nivel_lixeiras_empresa;

select * from vw_bairros_empresa
where id_empresa = 1;

SELECT * 
  FROM ecoponto e
  join subprefeitura on e.fk_subprefeitura = id_subprefeitura
  join empresa on id_empresa = fk_empresa
  WHERE fk_empresa = 1;


drop view vw_bairros_empresa;

create view vw_bairros_empresa
as
select e.id_empresa, s.nome as nome_subprefeitura, eco.bairro,
(sum(case
when v.nivel_preenchimento > 80 then v.nivel_preenchimento
else 0
end) / count(case
when v.nivel_preenchimento > 80 then v.nivel_preenchimento
else 0
end)) 
as soma_nivel_cheia,
(sum(case
when v.nivel_preenchimento > 50 and v.nivel_preenchimento <= 80 then v.nivel_preenchimento
else 0
end) / count( case
when v.nivel_preenchimento > 50 and v.nivel_preenchimento <= 80 then v.nivel_preenchimento
else 0
end))
as soma_nivel_medio,
(sum(case
when v.nivel_preenchimento <= 50 then v.nivel_preenchimento
else 0
end) / count(case
when v.nivel_preenchimento <= 50 then v.nivel_preenchimento
else 0
end))
as soma_nivel_baixo
from vw_nivel_lixeiras_empresa v
join empresa e on e.id_empresa = v.id_empresa 
join ecoponto eco on v.id_ecoponto = eco.id_ecoponto
join subprefeitura s on eco.fk_subprefeitura = s.id_subprefeitura 
GROUP BY e.id_empresa, s.nome, eco.bairro;