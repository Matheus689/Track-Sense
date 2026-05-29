var express = require("express");
var router = express.Router();

var suporteController = require("../controllers/suporteController");

router.post("/perguntar", async function (req, res) {
    suporteController.perguntar(req, res);
});

module.exports = router;