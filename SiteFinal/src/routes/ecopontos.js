var express = require("express");
var router = express.Router();

var ecopontosController = require("../controllers/ecopontosController");

router.get("/:id_empresa", function (req, res) {
  ecopontosController.buscarEcopontosPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  ecopontosController.cadastrar(req, res);
})

router.get(`/listarEcoponto/:id_empresa`, function (req, res) {
  ecopontosController.listarEcoponto(req, res);
})

router.get(`/listarBairro/:id_empresa`, function (req, res) {
  ecopontosController.listarBairro(req, res);
})

module.exports = router;