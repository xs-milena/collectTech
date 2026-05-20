var express = require("express");
var router = express.Router();

var avisoController = require("../controllers/avisoController");

router.get("/listar", function (req, res) {
    avisoController.listar(req, res);
});

router.get("/listar/:idUsuario", function (req, res) {
    avisoController.listarPorUsuario(req, res);
});

router.get("/pesquisar/:descricao", function (req, res) {
    avisoController.pesquisarDescricao(req, res);
});

router.post("/publicar/:idUsuario", function (req, res) {
    avisoController.publicar(req, res);
});

router.put("/editar/:id_funcionario", function (req, res) {
    avisoController.editar(req, res);
});

router.put("/desativar/:id_funcionario", function (req, res) {
    avisoController.desativar(req, res);
});

router.get("/buscarDados", function (req, res) {
    avisoController.buscarDados(req, res);
});

router.get("/listarFuncionarios", function (req, res) {
    avisoController.listarFuncionarios(req, res);
});

module.exports = router;