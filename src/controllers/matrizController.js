var matrizModel = require("../models/matrizModel");

function verMatriz(req, res) {

    var idEmpresa = req.params.idEmpresa;

    matrizModel.verMatriz(idEmpresa)

        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        })

        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}


function cadEmpresa(req, res) {
    var nome = req.body.nomeServer;
    var cnpj = req.body.cnpjServer;
    var cep = req.body.cepServer;
    var numero = req.body.numeroServer;
    var codEmpresa = req.body.codEmpresaServer;

    if (nome == undefined) {
        res.status(400).send("O nome está undefined!");
    } else if (cnpj == undefined) {
        res.status(400).send("O CNPJ está undefined!");
    } else if (cep == undefined) {
        res.status(400).send("O CEP está undefined!");
    } else if (numero == undefined) {
        res.status(400).send("O número está undefined!");
    } else if (codEmpresa == undefined) {
        res.status(400).send("O código da empresa está undefined!");
    } else {
        matrizModel.cadEmpresa(cnpj, nome, codEmpresa, cep, numero)
            .then(function (resultado) {
                res.status(201).json(resultado);
            })
            .catch(function (erro) {
                console.log(erro);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

module.exports = {
    verMatriz,
    cadEmpresa
}
