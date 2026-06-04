var database = require("../database/config");

function buscarUltimasMedidas(id_empresa) {

    var instrucaoSql = `select *, DATE_FORMAT(cadastrado_em, '%d/%m/%Y %H:%i:%s') as cadastrado_em from vw_nivel_lixeiras_empresa
    where id_empresa = ${id_empresa};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(id_ecoponto) {

    var instrucaoSql = `SELECT 
        l.nivel_preenchimento, 
        l.cadastrado_em, DATE_FORMAT(l.cadastrado_em,'%H:%i:%s')
	    FROM leitura_sensor as l
        join sensor on l.fk_sensor = id_sensor
        join lixeira on fk_lixeira = id_lixeira
        join ecoponto on fk_ecoponto = id_ecoponto
	    WHERE fk_ecoponto = ${id_ecoponto}
	    ORDER BY id_ecoponto DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function ultimosBairros(id_empresa,numero) {

    var instrucaoSql = `select * from vw_bairros_empresa
where id_empresa = ${id_empresa}
order by soma_nivel_cheia desc, soma_nivel_medio desc
limit ${numero};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function realBairros(id_empresa) {

    var instrucaoSql = `select * from vw_bairros_empresa
where id_empresa = ${id_empresa}
order by soma_nivel_cheia;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function bairroEspecifico(id_empresa,bairroEscolhido) {

    var instrucaoSql = `select * from vw_bairros_empresa
where bairro = ${bairroEscolhido} and id_empresa = ${id_empresa};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    ultimosBairros,
    realBairros,
    bairroEspecifico
}
