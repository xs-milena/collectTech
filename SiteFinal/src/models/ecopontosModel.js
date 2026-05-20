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
    where id_empresa = ${id_empresa}
    ORDER BY l.cadastrado_em DESC;`

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listarBairro(id_empresa) {
  var instrucaoSql = `
  select * from vw_bairros_empresa
where id_empresa = 1;
  `;

//   create view vw_bairros_empresa
// as
// select e.id_empresa, s.nome as nome_subprefeitura, eco.bairro,
// (sum(case
// when v.nivel_preenchimento > 80 then v.nivel_preenchimento
// else 0
// end) / count(case
// when v.nivel_preenchimento > 80 then v.nivel_preenchimento
// else 0
// end)) 
// as soma_nivel_cheia,
// (sum(case
// when v.nivel_preenchimento > 50 and v.nivel_preenchimento <= 80 then v.nivel_preenchimento
// else 0
// end) / count( case
// when v.nivel_preenchimento > 50 and v.nivel_preenchimento <= 80 then v.nivel_preenchimento
// else 0
// end))
// as soma_nivel_medio,
// (sum(case
// when v.nivel_preenchimento <= 50 then v.nivel_preenchimento
// else 0
// end) / count(case
// when v.nivel_preenchimento <= 50 then v.nivel_preenchimento
// else 0
// end))
// as soma_nivel_baixo
// from vw_nivel_lixeiras_empresa v
// join empresa e on e.id_empresa = v.id_empresa 
// join ecoponto eco on v.id_ecoponto = eco.id_ecoponto
// join subprefeitura s on eco.fk_subprefeitura = s.id_subprefeitura 
// GROUP BY e.id_empresa, s.nome, eco.bairro;

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
  cadastrar
}
