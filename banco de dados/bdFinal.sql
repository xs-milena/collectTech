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
    colocado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp()
);

alter table empresa add column codigo_ativacao varchar(50);

-- Cadastro/login funcionário
create table usuario (
    id_usuario int primary key auto_increment not null,
    nome varchar(50) not null,
    cpf varchar(11) not null unique, -- CPF único
    telefone char(11),
    email varchar(100) not null unique, -- EMAIL único
    senha varchar(100) not null,
    cargo varchar(100) not null,
    situacao_usuario boolean not null default false, -- ativo ou inativo
    fk_empresa int not null,
    colocado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
      constraint check_cargo check (cargo in ('gestor ambiental', 'coordenador', 'motorista')),
    foreign key (fk_empresa) references empresa(id_empresa)
);

alter table empresa add col

insert into usuario (nome, cpf, telefone, email, senha, cargo, situacao_usuario) values
('Alan Crivellaro Hyppolito', '11111111111', '11911111111', 'alan@gmail.com', '293i2e', 'coordenador', true),
('Júlia Sampaio Macêdo', '22222222222', '11922222222', 'julia@gmail.com', '28u2e82', 'gestor ambiental', true),
('Lucas Nogueira Buono de Albuquerque', '33333333333', '11933333333', 'lucas@gmail.com', '93iend', 'coordenador', true),
('Milena Maria de Amorim Silva', '44444444444', '11944444444', 'milena@gmail.com', '1dkdn2', 'motorista', true),
('Sophie de Souza Ferraz', '55555555555', '11955555555', 'sophie@gmail.com', '92n292', 'motorista', true),
('Thabata Vitoria Daniel de Sousa', '66666666666', '11966666666', 'thabata@gmail.com', '212un21', 'gestor ambiental', true);

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
    fk_empresa int not null,
    colocado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    foreign key (fk_empresa) references empresa(id_empresa)
);

insert into ecoponto (subprefeitura, nome_ecoponto, rua, numero, bairro, cep, estado, municipio, recebe_gesso) values
('Carrão', 'Viaduto Engenheiro Alberto Badra', 'Avenida Aricanduva', 200, 'Aricanduva', '03501010', 'SP', 'São Paulo', 1),
('Butantã', 'Jardim Maria do Carmo', 'Rua Caminho do Engenho', 800, 'Ferreira', '05524000', 'SP', 'São Paulo', 0),
('Butantã', 'Giovani Gronchi', 'Avenida Giovani Gronchi', 3413,'Morumbi', '05651002', 'SP', 'São Paulo', 0),
('Guaianases', 'Jardim São Paulo','Rua Utaro Kanai', 374,'Conjunto Habitacional Juscelino Kubitschek', '08465000', 'SP', 'São Paulo', 0),
('Jabaquara', 'Imigrantes', 'Rua Opixe', 232, 'Vila Guarani', '04312080', 'SP', 'São Paulo', 1);

-- lixeira
create table lixeira (
    id_lixeira int primary key auto_increment not null,
    comprimento int not null, -- em cm
    largura int not null, -- em cm
    altura int not null, -- em cm
    capacidade int not null, -- volume em cm
    fk_ecoponto int not null,
    colocado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    foreign key (fk_ecoponto) references ecoponto(id_ecoponto)
);

insert into lixeira (comprimento, largura, altura, capacidade, fk_ecoponto, fk_sensor, fk_tipo_descarte) values
(190, 95, 190, 115, 1, 1, 1),
(190, 95, 190, 115, 2, 2,2),
(190, 95, 190, 115, 3, 3,3),
(190, 95, 190, 115, 4, 4,4),
(190, 95, 190, 115, 5, 5,5);

-- sensor (em caso de queima, dará para saber qual sensor queimou)
create table sensor (
    id_sensor int primary key auto_increment not null,
    situacao_sensor boolean not null default false, -- ativo 1 ou inativo 0
    fk_lixeira int not null,
    colocado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    foreign key (fk_lixeira) references lixeira(id_lixeira)
);

insert into sensor (situacao_sensor) values
(true),
(false),
(true),
(true);
        
-- leitura do sensor
create table leitura_sensor (
    id_leitura int primary key auto_increment not null,
    nivel_cheia decimal(3,2) not null,
    fk_sensor int not null,
    colocado_em datetime default current_timestamp(),
    foreign key (fk_sensor) references sensor(id_sensor)
);

insert into leitura_sensor (nivel_cheia, fkSensor) values
(50, 1),
(60, 2),
(70, 3),
(80, 4),
(90, 5);