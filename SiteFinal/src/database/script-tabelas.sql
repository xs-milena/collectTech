-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

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

INSERT INTO empresa (cnpj, telefone, email, senha, codigo_ativacao, situacao_usuario)
VALUES 
('12345678000195', '11987654321', 'empresa1@email.com', 'senha123', 'ABC123', true),
('98765432000188', '11912345678', 'empresa2@email.com', 'senha456', 'XYZ789', true);

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

-- sensor (em caso de queima, dará para saber qual sensor queimou)
create table sensor (
	id_sensor int primary key auto_increment not null,
    situacao_sensor boolean not null default false, -- ativo 1 ou inativo 0
    fk_lixeira int not null,
    colocado_em datetime default current_timestamp(),
    atualizado_em datetime default current_timestamp(),
    foreign key (fk_lixeira) references lixeira(id_lixeira)
);
        
-- leitura do sensor
create table leitura_sensor (
    id_leitura int primary key auto_increment not null,
    nivel_cheia decimal(3,2) not null,
    fk_sensor int not null,
    colocado_em datetime default current_timestamp(),
	foreign key (fk_sensor) references sensor(id_sensor)
);