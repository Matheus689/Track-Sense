var database = require("../database/config");

function buscarUltimasMedidas(idSensor) {

    var instrucaoSql = `SELECT 
        valorRegistro as registro, 
                        hrRegistro as momento_grafico
                    FROM registroSensor
                    WHERE fkSensor = ${idSensor}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idSensor) {

    var instrucaoSql = `SELECT 
        valorRegistro as registro, 
                        hrRegistro as momento_grafico
                    FROM registroSensor
                    WHERE fkSensor = ${idSensor} 
                    ORDER BY idSensor DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
