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

function listarEcoponto() {

  var instrucaoSql = `SELECT  `;

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
  cadastrar
}
