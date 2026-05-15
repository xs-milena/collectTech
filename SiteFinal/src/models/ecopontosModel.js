var database = require("../database/config");

function buscarEcopontosPorEmpresa(id_empresa) {

  var instrucaoSql = `SELECT * 
  FROM ecoponto e
  join subprefeitura on e.fk_subprefeitura = id_subprefeitura
  join empresa on id_empresa = fk_empresa
  WHERE fk_empresa = ${id_empresa}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listarEcoponto(id_empresa) {

  var instrucaoSql = `
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
