var database = require("../database/config");

function buscarEcopontosPorEmpresa(id_empresa) {

  var instrucaoSql = `SELECT * 
  FROM ecoponto e
  join subprefeitura on e.fk_subprefeitura = id_subprefeitura
  join empresa on id_empresa = fk_empresa
  WHERE fk_empresa = id_empresa`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listarEcoponto(id_empresa) {

  var instrucaoSql = `
    SELECT 
        e.nome_ecoponto AS ecoponto,
        id_sensor AS codigo,
        l.nivel_preenchimento AS nivel,
        DATE_FORMAT(l.cadastrado_em, '%H:%i:%s') AS captura,
        DATE_FORMAT(l.cadastrado_em, '%d/%m/%Y') AS data
    FROM leitura_sensor AS l
    JOIN sensor se ON l.fk_sensor = se.id_sensor
    JOIN lixeira li ON se.fk_lixeira = li.id_lixeira
    JOIN ecoponto e ON li.fk_ecoponto = e.id_ecoponto
    JOIN subprefeitura ON e.fk_subprefeitura = id_subprefeitura
    JOIN empresa emp ON e.fk_empresa = emp.id_empresa 
    WHERE e.fk_empresa = ${id_empresa}
    ORDER BY l.cadastrado_em DESC LIMIT 7;`

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(id_empresa) {
  
  var instrucaoSql = `INSERT INTO (fk_empresa) ecoponto VALUES (${id_empresa})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarEcopontosPorEmpresa,
  listarEcoponto,
  cadastrar
}
