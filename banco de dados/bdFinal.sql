-- criação do banco de dados
create database collect_tech;
use collect_tech;

-- Cadastro empresa
create table empresa (
    id_empresa int primary key auto_increment not null,
    cnpj varchar(14) not null unique,
    telefone char(11),
    email varchar(100) not null unique, -- EMAIL único
    senha varchar(100) not null,
    situacao_usuario boolean not null default false, -- ativo ou inativo
    cadastrado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp()
);

-- Cadastro/login do funcionário
create table usuario (
    id_usuario int primary key auto_increment not null,
    nome varchar(50) not null,
    cpf varchar(11) not null unique, -- CPF único
    telefone char(11),
    email varchar(100) not null unique, -- EMAIL único
    senha varchar(100) not null,
    cargo varchar(100) not null,
	constraint check_cargo check (cargo in ('gestor ambiental', 'coordenador', 'motorista')),
    situacao_usuario boolean not null default false, -- ativo ou inativo
    cadastrado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    fk_empresa int not null,
	foreign key (fk_empresa) references empresa(id_empresa)
);

insert into usuario (nome, cpf, telefone, email, senha, cargo, situacao_usuario, fk_empresa) values
('Alan Crivellaro Hyppolito', '11111111111', '11911111111', 'alan@gmail.com', '293i2e', 'coordenador', true, 1),
('Júlia Sampaio Macêdo', '22222222222', '11922222222', 'julia@gmail.com', '28u2e82', 'gestor ambiental', true, 2),
('Lucas Nogueira Buono de Albuquerque', '33333333333', '11933333333', 'lucas@gmail.com', '93iend', 'coordenador', true, 3),
('Milena Maria de Amorim Silva', '44444444444', '11944444444', 'milena@gmail.com', '1dkdn2', 'motorista', true, 4),
('Sophie de Souza Ferraz', '55555555555', '11955555555', 'sophie@gmail.com', '92n292', 'motorista', true, 5),
('Thabata Vitoria Daniel de Sousa', '66666666666', '11966666666', 'thabata@gmail.com', '212un21', 'gestor ambiental', true, 6);

-- endereco do ecoponto
create table ecoponto (
    id_ecoponto int primary key auto_increment not null,
    subprefeitura varchar(100),
    nome_ecoponto varchar(200),
    rua varchar(100) not null,
    numero varchar(10) not null,
    bairro varchar(100) not null,
    cep char(8) not null,
    estado char(2) not null,
    municipio varchar(50) not null,
    cadastrado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    fk_empresa int not null,
	foreign key (fk_empresa) references empresa(id_empresa)
);

insert into ecoponto (subprefeitura, nome_ecoponto, rua, numero, bairro, cep, estado, municipio, fk_empresa) values
('Carrão', 'Viaduto Engenheiro Alberto Badra', 'Avenida Aricanduva', 200, 'Aricanduva', '03501010', 'SP', 'São Paulo', 1),
('Butantã', 'Jardim Maria do Carmo', 'Rua Caminho do Engenho', 800, 'Ferreira', '05524000', 'SP', 'São Paulo', 2),
('Butantã', 'Giovani Gronchi', 'Avenida Giovani Gronchi', 3413,'Morumbi', '05651002', 'SP', 'São Paulo', 3),
('Guaianases', 'Jardim São Paulo','Rua Utaro Kanai', 374,'Conjunto Habitacional Juscelino Kubitschek', '08465000', 'SP', 'São Paulo', 4),
('Jabaquara', 'Imigrantes', 'Rua Opixe', 232, 'Vila Guarani', '04312080', 'SP', 'São Paulo', 5);

-- lixeira
create table lixeira (
    id_lixeira int primary key auto_increment not null,
    comprimento int not null, -- em cm
    largura int not null, -- em cm
    altura int not null, -- em cm
    capacidade int not null,
    cadastrado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    fk_ecoponto int not null,
    foreign key (fk_ecoponto) references ecoponto(id_ecoponto)
);

insert into lixeira (comprimento, largura, altura, capacidade, fk_ecoponto) values
(190, 95, 190, 115, 1),
(190, 95, 190, 115, 2),
(190, 95, 190, 115, 3),
(190, 95, 190, 115, 4),
(190, 95, 190, 115, 5);

-- sensor (em caso de queima, dará para saber qual sensor queimou)
create table sensor (
    id_sensor int primary key auto_increment not null,
    situacao_sensor boolean not null default false, -- ativo 1 ou inativo 0
    instalado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    fk_lixeira int not null,
	foreign key (fk_lixeira) references lixeira(id_lixeira)
);

insert into sensor (situacao_sensor, fk_lixeira) values
(true, 1),
(false, 2),
(true, 3),
(true, 4);
        
-- leitura do sensor	
create table leitura_sensor (
    id_leitura int primary key auto_increment not null,
    nivel_cheia decimal(5,2) not null,
    fk_sensor int not null,
    foreign key (fk_sensor) references sensor(id_sensor),
    leitura_em datetime default current_timestamp()
);

insert into leitura_sensor (nivel_cheia, fk_sensor) values
(50, 1),
(60, 2),
(70, 3),
(80, 4);