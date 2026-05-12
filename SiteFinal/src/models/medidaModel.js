var database = require("../database/config");

function buscarUltimasMedidas(id_ecoponto, limite_linhas) {

    var instrucaoSql = `SELECT 
        l.nivel_preenchimento,
        l.cadastrado_em, DATE_FORMAT(l.cadastrado_em,'%H:%i:%s')
	    FROM leitura_sensor as l
        join sensor on l.fk_sensor = id_sensor
        join lixeira on fk_lixeira = id_lixeira
        join ecoponto on fk_ecoponto = id_ecoponto
	    WHERE fk_ecoponto = ${id_ecoponto}
	    ORDER BY id_ecoponto DESC LIMIT ${limite_linhas}`;

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

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
