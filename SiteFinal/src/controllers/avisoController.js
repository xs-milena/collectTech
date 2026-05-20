var avisoModel = require("../models/avisoModel");

function listar(req, res) {
    avisoModel.listar().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listarPorUsuario(req, res) {
    var idUsuario = req.params.idUsuario;

    avisoModel.listarPorUsuario(idUsuario)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro ao buscar os avisos: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function pesquisarDescricao(req, res) {
    var descricao = req.params.descricao;

    avisoModel.pesquisarDescricao(descricao)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function publicar(req, res) {
    var titulo = req.body.titulo;
    var descricao = req.body.descricao;
    var idUsuario = req.params.idUsuario;

    if (titulo == undefined) {
        res.status(400).send("O título está indefinido!");
    } else if (descricao == undefined) {
        res.status(400).send("A descrição está indefinido!");
    } else if (idUsuario == undefined) {
        res.status(403).send("O id do usuário está indefinido!");
    } else {
        avisoModel.publicar(titulo, descricao, idUsuario)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            )
            .catch(
                function (erro) {
                    console.log(erro);
                    console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function buscarDados(req, res) {
    var nomeFuncionario = req.query.nome;
    var emailFuncionario = req.query.email;
    var fkEmpresa = req.query.fkEmpresa;

    if (nomeFuncionario == undefined || emailFuncionario == undefined) {
        res.status(400).send("Nome ou Email estão indefinidos!");
        return;
    }

    avisoModel.buscarDados(nomeFuncionario, emailFuncionario, fkEmpresa)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado[0]);
                } else {
                    res.status(204).send("Nenhum resultado encontrado no buscarDados!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro ao buscar os buscar o nome do funcionario: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function listarFuncionarios(req, res) {
    var fkEmpresa = req.query.fkEmpresa;

    if (fkEmpresa == undefined) {
        res.status(400).send("A fkEmpresa está indefinida!");
        return;
    }

    avisoModel.listarFuncionarios(fkEmpresa)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro ao buscar os avisos: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function editar(req, res) {
    var codigoFuncionario = req.params.id_funcionario;
    var nomeFuncionario = req.body.nome;
    var emailFuncionario = req.body.email;
    var telefoneFuncionario = req.body.telefone;
    var cargoFuncionario = req.body.cargo;
    var situacaoFuncionario = req.body.situacao_funcionario;
    var fkEmpresa = req.body.fkEmpresa;

    if (fkEmpresa == undefined) {
        res.status(400).send("A fkEmpresa está indefinida no corpo da requisição!");
        return;
    }

    avisoModel.editar(codigoFuncionario, nomeFuncionario, emailFuncionario, telefoneFuncionario, cargoFuncionario, situacaoFuncionario, fkEmpresa)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );

}

function desativar(req, res) {
    var codigoFuncionario = req.params.id_funcionario;
    var fkEmpresa = req.query.fkEmpresa;

    if (fkEmpresa == undefined) {
        res.status(400).send("A fkEmpresa está indefinida na URL da requisição!");
        return;
    }

    avisoModel.desativar(codigoFuncionario, fkEmpresa)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao deletar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

module.exports = {
    listar,
    listarPorUsuario,
    listarFuncionarios,
    pesquisarDescricao,
    publicar,
    editar,
    desativar,
    buscarDados
}