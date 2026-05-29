var suporteModel = require("../models/suporteModel");

async function perguntar(req, res) {
    const pergunta = req.body.pergunta;
    try {
        const resposta = await suporteModel.gerarResposta(pergunta);
        res.json({
            resultado: resposta
        });
    } catch (erro) {
        console.log(erro);
        res.status(500).json({
            erro: "Erro ao gerar resposta"
        });
    }
}

module.exports = {
    perguntar
};