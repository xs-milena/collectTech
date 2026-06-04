var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:id_empresa", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:id_ecoponto", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/ultimosBairros/:id_empresa/:numero", function (req, res) {
    medidaController.ultimosBairros(req, res);
});

router.get("/tempo-realBairros/:id_empresa", function (req, res) {
    medidaController.realBairros(req, res);
})

router.get("/bairroEspecifico/:id_empresa/:bairroEscolhido", function (req, res) {
    medidaController.bairroEspecifico(req, res);
});

module.exports = router;