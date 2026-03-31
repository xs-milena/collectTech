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

insert into usuario (nome, cpf, telefone, email, senha, situacao_usuario) 
	values
		('Alan Crivellaro Hyppolito', '11111111111', '11911111111', 'alan@gmail.com', '293i2e', 1),
		('Júlia Sampaio Macêdo', '22222222222', '11922222222', 'julia@gmail.com', '28u2e82', 1),
		('Lucas Nogueira Buono de Albuquerque', '33333333333', '11933333333', 'lucas@gmail.com', '93iend', 1),
		('Milena Maria de Amorim Silva', '44444444444', '11944444444', 'milena@gmail.com', '1dkdn2', 1),
		('Sophie de Souza Ferraz', '55555555555', '11955555555', 'sophie@gmail.com', '92n292', 1),
		('Thabata Vitoria Daniel de Sousa', '66666666666', '11966666666', 'thabata@gmail.com', '212un21', 1);

-- endereco do ecoponto
create table ecoponto (
	id int primary key auto_increment not null,
    subprefeitura varchar(100),
    nome_ecoponto varchar(200),
    endereco varchar(100) not null,
	logradouro int not null,
    bairro varchar(100) not null,
    cep char(8) not null,
    estado char(2) not null,
    municipio varchar(50) not null,
    recebe_gesso tinyint(1) not null default 0 -- recebe ou não gesso
);

insert into ecoponto (subprefeitura, nome_ecoponto, endereco, logradouro, bairro, cep, estado, municipio, recebe_gesso)
	values
		('Carrão', 'Viaduto Engenheiro Alberto Badra', 'Avenida Aricanduva', 200, 'Aricanduva', '03501010', 'SP', 'São Paulo', 1),
		('Butantã', 'Jardim Maria do Carmo', 'Rua Caminho do Engenho', 800, 'Ferreira', '05524000', 'SP', 'São Paulo', 0),
		('Butantã', 'Giovani Gronchi', 'Avenida Giovani Gronchi', 3413,'Morumbi', '05651002', 'SP', 'São Paulo', 0),
		('Guaianases', 'Jardim São Paulo','Rua Utaro Kanai', 374,'Conjunto Habitacional Juscelino Kubitschek', '08465000', 'SP', 'São Paulo', 0),
		('Jabaquara', 'Imigrantes', 'Rua Opixe', 232, 'Vila Guarani', '04312080', 'SP', 'São Paulo', 1);

-- tipo de descarte da lixeira
create table tipo_descarte (
	id int primary key auto_increment not null,
    nome varchar(50) not null
);

insert into tipo_descarte (nome) 
	values
		('Papel'),
		('Plástico'),
		('Vidro'),
		('Metal'),
		('Papelão');

-- sensor (em caso de queima, dará para saber qual sensor queimou)
create table sensor (
	id int primary key auto_increment not null,
    situacao_sensor tinyint(1) not null default 0 -- ativo 1 ou inativo 0
);

insert into sensor (situacao_sensor) 
	values
		(1),
		(1),
		(1),
		(0),
		(1);
        
-- sensor_registro
create table registro_sensor (
	id int primary key auto_increment not null,
    nivel_cheia int not null,
    data_registro datetime default current_timestamp() not null,
    fkSensor int,
		foreign key (fkSensor) references sensor(id)
);

insert into registro_sensor (nivel_cheia, fkSensor) 
	values
		(50, 1),
		(60, 2),
		(70, 3),
		(80, 4),
		(90, 5);

-- lixeira
create table lixeira (
	id int primary key auto_increment not null,
    comprimento int, -- em cm
    largura int not null, -- em cm
    altura int not null, -- em cm
    capacidade int not null,
	fk_ecoponto int not null,
		foreign key (fk_ecoponto) references ecoponto(id),
    fk_sensor int not null,
		foreign key (fk_sensor) references sensor(id),
	fk_tipo_descarte int not null,
		foreign key (fk_tipo_descarte) references tipo_descarte(id)
);

insert into lixeira (comprimento, largura, altura, capacidade, fk_ecoponto, fk_sensor, fk_tipo_descarte)
	values
		(190, 95, 190, 115, 1, 1, 1),
		(190, 95, 190, 115, 2, 2,2),
		(190, 95, 190, 115, 3, 3,3),
		(190, 95, 190, 115, 4, 4,4),
		(190, 95, 190, 115, 5, 5,5);

 --------------------------------------------------------------------------------------------------------------------
 
/*SELECTS - GERAL*/

select * from usuario;
select * from ecoponto;
select * from tipo_descarte;
select * from sensor;
select * from registro_sensor;
select * from lixeira;

