var database = require("../database/config");

function buscarUltimasMedidas(id_empresa) {

    var instrucaoSql = `SELECT 
    li.id_lixeira, 
    SUBSTRING_INDEX( GROUP_CONCAT(l.nivel_preenchimento ORDER BY l.cadastrado_em DESC), ',', 1 ) AS nivel_preenchimento,
    MAX(l.cadastrado_em) AS cadastrado_em
FROM leitura_sensor AS l 
JOIN sensor AS s ON l.fk_sensor = s.id_sensor 
JOIN lixeira AS li ON s.fk_lixeira = li.id_lixeira 
JOIN ecoponto AS e ON li.fk_ecoponto = e.id_ecoponto 
JOIN subprefeitura AS sub ON e.fk_subprefeitura = sub.id_subprefeitura 
JOIN empresa AS emp ON sub.fk_empresa = emp.id_empresa 
WHERE emp.id_empresa = ${id_empresa} 
GROUP BY li.id_lixeira;`;

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
