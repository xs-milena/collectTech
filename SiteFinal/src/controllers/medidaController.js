var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {

    const limite_linhas = 7;

    var id_empresa = req.params.id_empresa;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    medidaModel.buscarUltimasMedidas(id_empresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function buscarMedidasEmTempoReal(req, res) {

    var id_empresa = req.params.id_empresa;

    console.log(`Recuperando medidas em tempo real`);

    medidaModel.buscarMedidasEmTempoReal(id_empresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function ultimosBairros(req, res) {

    var limite_linhas = req.params.numero;

    var id_empresa = req.params.id_empresa;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    medidaModel.ultimosBairros(id_empresa,limite_linhas).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function realBairros(req, res) {

    var id_empresa = req.params.id_empresa;

    console.log(`Recuperando medidas em tempo real`);

    medidaModel.realBairros(id_empresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function bairroEspecifico(req, res) {

    var bairroEscolhido = req.params.bairroEscolhido;

    var id_empresa = req.params.id_empresa;

    console.log(`Recuperando medidas em tempo real`);

    medidaModel.bairroEspecifico(id_empresa,bairroEscolhido).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    ultimosBairros,
    realBairros,
    bairroEspecifico
}