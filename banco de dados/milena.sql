-- criação do banco de dados
create database CollectTech;
use CollectTech;

-- Cadastro/login
create table usuario (
	id int primary key auto_increment not null,
    nome varchar(50) not null,
    cpf varchar(11) not null unique, -- CPF único
    telefone char(11),
    email varchar(100) not null unique, -- EMAIL único
    senha varchar(100) not null,
    situacao_usuario tinyint(1) not null default 0 -- ativo ou inativo
);

-- endereco do ecoponto
create table ecoponto (
	id int primary key auto_increment not null,
    qnt_lixeira int not null,
    nome_ecoponto varchar(200),
    rua varchar(100) not null,
	logradouro varchar(100) not null,
    bairro varchar(100) not null,
    cep char(8) not null,
    estado char(2) not null,
    municipio varchar(50) not null,
    recebe_gesso tinyint(1) not null default 0 -- recebe ou não gesso
);

-- sensor
create table sensor (
	id int primary key auto_increment not null,
    nivel_cheia int not null,
    data_registro datetime default current_timestamp() not null,
	situacao_sensor tinyint(1) not null default 0 -- ativo 1 ou inativo 0
);

-- tipo de descarte da lixeira
create table tipo_descarte (
	id int primary key auto_increment not null,
    nome varchar(50) not null
);

-- lixeira
create table lixeira (
	id int primary key auto_increment not null,
    comprimento decimal (5,2), -- em cm
    largura decimal (5,2) not null, -- em cm
    altura decimal (5,2) not null, -- em cm
    capacidade decimal (7,2) not null,
	fk_ecoponto int not null,
		foreign key (fk_ecoponto) references ecoponto(id),
    fk_sensor int not null,
		foreign key (fk_sensor) references sensor(id),
	fk_descarte int not null,
		foreign key (fk_descarte) references tipo_descarte(id)
);
