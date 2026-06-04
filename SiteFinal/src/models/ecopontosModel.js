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
    * from vw_nivel_ecoponto
   where id_empresa = ${id_empresa}
   order by nivel desc`

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listarBairro(id_empresa) {
  var instrucaoSql = `
  select * from vw_bairros_empresa
where id_empresa = ${id_empresa}
order by soma_nivel_cheia desc, soma_nivel_medio desc;
  `;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function totalLixeiras(id_empresa) {
  var instrucaoSql = `
  select * from vw_total_lixeiras
where id_empresa = ${id_empresa};
  `;

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
  listarBairro,
  cadastrar,
  totalLixeiras
}
