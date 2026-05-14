var express = require("express");
var router = express.Router();
var ecopontoController = require("../controllers/ecopontosController");

router.get("/listarEcoponto", function (req, res) {
    ecopontosController.listar(req, res);
});

module.exports = { router };