var express = require("express");
var router = express.Router();

var matrizController = require("../controllers/matrizController");

router.get("/verMatriz/:idEmpresa", function (req, res) {
    matrizController.verMatriz(req, res);
})

router.post("/cadEmpresa", function (req, res) {
    matrizController.cadEmpresa(req, res);
});


module.exports = router;