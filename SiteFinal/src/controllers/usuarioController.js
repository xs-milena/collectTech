var usuarioModel = require("../models/usuarioModel");
var ecopontosModel = require("../models/ecopontosModel");

function autenticar(req, res) {
    var codigo_ativacao = req.body.codigo_ativacaoServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (codigo_ativacao == undefined) {
        res.status(400).send("Sua empresa a vincular está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    }

    else {

        usuarioModel.autenticar(codigo_ativacao, email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        ecopontosModel.buscarEcopontosPorEmpresa(resultadoAutenticar[0].id_empresa)
                            .then((resultadoEcopontos) => {
                                if (resultadoEcopontos.length > 0) {
                                    ecopontosModel.listarBairro(resultadoAutenticar[0].id_empresa)
                                        .then((resultadoBairro) => {
                                            if (resultadoBairro.length > 0) {
                                                res.json({
                                                    id: resultadoAutenticar[0].id_funcionario,
                                                    email: resultadoAutenticar[0].email,
                                                    nome: resultadoAutenticar[0].nome,
                                                    senha: resultadoAutenticar[0].senha,
                                                    codigo_ativacao: resultadoAutenticar[0].codigo_ativacao,
                                                    id_empresa: resultadoAutenticar[0].id_empresa,
                                                    ecopontos: resultadoEcopontos,
                                                    vw_bairros_empresa: resultadoBairro
                                                });
                                            } else {
                                                res.status(204).json({ vw_bairros_empresa: [] });
                                            }
                                        })
                                } else {
                                    res.status(204).json({ ecopontos: [] });
                                }
                            })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }


                    // if (resultadoAutenticar.length == 1) {
                    //     console.log(resultadoAutenticar);

                    //     ecopontosModel.listarEcoponto(resultadoAutenticar[0].id_empresa)
                    //         .then((resultadoEcopontos) => {
                    //             if (resultadoEcopontos.length > 0) {
                    //                 res.json({
                    //                     id: resultadoAutenticar[0].id_funcionario,
                    //                     email: resultadoAutenticar[0].email,
                    //                     nome: resultadoAutenticar[0].nome,
                    //                     senha: resultadoAutenticar[0].senha,
                    //                     ecopontos: resultadoEcopontos
                    //                 });
                    //             } else {
                    //                 res.status(204).json({ ecopontos: [] });
                    //             }
                    //         })
                    //  } else if (resultadoAutenticar.length == 0) {
                    //      res.status(403).send("Email e/ou senha inválido(s)");
                    // } else {
                    //     res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    // }

                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var telefone = req.body.telefoneServer;
    var senha = req.body.senhaServer;
    var fkEmpresa = req.body.idEmpresaVincularServer;
    var cargo = req.body.cargoServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (telefone == undefined) {
        res.status(400).send("Seu cpf está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (fkEmpresa == undefined) {
        res.status(400).send("Sua empresa a vincular está undefined!");
    } else if (cargo == undefined) {
        res.status(400).send("Seu cargo está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, telefone, email, senha, cargo, fkEmpresa)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}