var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {

    const limite_linhas = 7;

    var idAquario = req.params.empresa;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    medidaModel.buscarUltimasMedidas(idAquario, limite_linhas)
    
    .then(function (resultado) {
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

    var idSensor = req.params.idEmpresa;

    console.log("Recuperando medidas em tempo real");

    medidaModel.buscarMedidasEmTempoReal(idSensor)
        .then(function (resultado) {

            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }

        }).catch(function (erro) {

            console.log(erro);
            console.log("Erro ao buscar medidas:", erro.sqlMessage);

            res.status(500).json(erro.sqlMessage);

        });
}

function buscarTodasMaquinas (req, res){
    var idEmpresa = req.params.idEmpresa;

    console.log(`Buscando máquinas da empresa:`, idEmpresa);

    medidaModel.buscarTodasMaquinas(idEmpresa).then(function (resultado) {
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

function buscarProducaoGeral(req, res) {

    var idEmpresa = req.params.idEmpresa;

    medidaModel.buscarProducaoGeral(idEmpresa)
        .then(function(resultado){

            res.status(200).json(resultado);

        }).catch(function(erro){

            console.log(erro);
            res.status(500).json(erro.sqlMessage);

        });
}

function buscarProducaoDiariaMaquina(req, res) {

    var idEmpresa = req.params.idEmpresa;

    medidaModel.buscarProducaoDiariaMaquina(idEmpresa)
        .then(function(resultado){

            res.status(200).json(resultado);

        }).catch(function(erro){

            console.log(erro);
            res.status(500).json(erro.sqlMessage);

        });
}

function buscarProducaoMensal(req, res) {
    var idSensor = req.params.idSensor;

    medidaModel.buscarProducaoMensal(idSensor).then(function (resultado) {
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
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarTodasMaquinas,
    buscarProducaoGeral,
    buscarProducaoDiariaMaquina,
    buscarProducaoMensal
}