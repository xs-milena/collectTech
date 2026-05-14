var express = require("express");
var router = express.Router();
var ecopontosController = require("../controllers/ecopontosController");

router.get("/listarEcoponto", function (req, res) {
    ecopontosController.listar(req, res);
});

module.exports = { router };