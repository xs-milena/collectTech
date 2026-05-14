var express = require("express");
var router = express.Router();

var ecopontosController = require("../controllers/ecopontosController");

router.get("/:id_empresa", function (req, res) {
  ecopontosController.buscarEcopontosPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  ecopontosController.cadastrar(req, res);
})

router.post("/listarEcoponto", function (req, res) {
  ecopontosController.listarEcoponto(req, res);
})

module.exports = router;