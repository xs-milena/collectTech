var ecopontosModel = require("../models/ecopontosModel");

function buscarEcopontosPorEmpresa(req, res) {
  // var idUsuario = req.params.idUsuario;
  var id_empresa = req.params.id_empresa;

  ecopontosModel.buscarEcopontosPorEmpresa(id_empresa).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os ecopontos: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


function cadastrar(req, res) {
  var idUsuario = req.body.idUsuario;

  if (idUsuario == undefined) {
    res.status(400).send("idUsuario está undefined!");
  } else {


    ecopontosModel.cadastrar(idUsuario)
      .then((resultado) => {
        res.status(201).json(resultado);
      }
      ).catch((erro) => {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

function listarEcoponto(req, res) {
    var id_empresa = req.params.id_empresa;

    ecopontosModel.listarEcoponto(id_empresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
  buscarEcopontosPorEmpresa,
  listarEcoponto,
  cadastrar,
}