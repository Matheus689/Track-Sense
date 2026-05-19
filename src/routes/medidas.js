var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

// router.get("/ultimas/:idAquario", function (req, res) {
//     medidaController.buscarUltimasMedidas(req, res);
// });

router.get("/tempo-real/:idSensor", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/producao-real/:idSensor", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

// dashboard
router.get("/maquinas/:idEmpresa", function (req, res) {
    medidaController.buscarTodasMaquinas(req, res);
});

router.get("/producao-geral/:idEmpresa", function(req, res){
    medidaController.buscarProducaoGeral(req, res);
});

router.get("/producao-diaria/:idEmpresa", function(req, res){
    medidaController.buscarProducaoDiariaMaquina(req, res);
});

module.exports = router;