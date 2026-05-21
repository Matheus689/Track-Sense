var database = require("../database/config");

function buscarUltimasMedidas(idSensor) {

    var instrucaoSql = `SELECT 
        valorRegistro as registro, 
                        hrRegistro as momento_grafico
                    FROM registroSensor
                    WHERE fkSensor = ${idSensor};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idSensor) {
    var instrucaoSql = `
        SELECT 
            valorRegistro as registro, 
            hrRegistro as momento_grafico
        FROM registroSensor
        WHERE fkSensor = ${idSensor}
        AND DATE(hrRegistro) = CURDATE()
        ORDER BY hrRegistro ASC;
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

// ranking de todas as maquinas
function buscarTodasMaquinas(idEmpresa) {
    var instrucaoSql = `
        SELECT 
            m.idMaquina,
            m.numMaquina AS maquina,
            s.idSensor,
            s.estadoSensor,
            COUNT(r.idRegistro) AS producao,
            ROUND((COUNT(r.idRegistro) / 30) * 100, 0) AS eficiencia
        FROM maquina m
        JOIN sensor s ON s.fkMaquina = m.idMaquina
        LEFT JOIN registroSensor r 
            ON r.fkSensor = s.idSensor
        WHERE m.fkEmpresaMaquina = ${idEmpresa}
        GROUP BY m.idMaquina, m.numMaquina, s.idSensor, s.estadoSensor
        ORDER BY eficiencia DESC;
    `
// AND DATE(r.hrRegistro) = CURDATE()
    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoGeral(idEmpresa) {

    var instrucaoSql = `
        SELECT 
            DATE_FORMAT(r.hrRegistro, '%H:00') AS horario,
            SUM(r.valorRegistro) AS producao
        FROM registroSensor r
        JOIN sensor s
            ON r.fkSensor = s.idSensor
        JOIN maquina m
            ON s.fkMaquina = m.idMaquina
        WHERE m.fkEmpresaMaquina = ${idEmpresa}
        GROUP BY horario
        ORDER BY horario;
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoDiariaMaquina (idEmpresa) {

    var instrucaoSql = `
    
        SELECT 
            m.numMaquina AS maquina,
            SUM(r.valorRegistro) AS producao
        FROM maquina m
        JOIN sensor s
            ON s.fkMaquina = m.idMaquina
        JOIN registroSensor r
            ON r.fkSensor = s.idSensor
        WHERE m.fkEmpresaMaquina = ${idEmpresa}
        GROUP BY m.idMaquina
        ORDER BY producao DESC;
    
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoMensal(idSensor) {
    var instrucaoSql = `
        SELECT 
            MONTH(hrRegistro) as mes,
            YEAR(hrRegistro) as ano,
            COUNT(*) as totalLatas
        FROM registroSensor
        WHERE fkSensor = ${idSensor}
        AND valorRegistro = 1
        GROUP BY YEAR(hrRegistro), MONTH(hrRegistro)
        ORDER BY ano, mes
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarTodasMaquinas,
    buscarProducaoGeral,
    buscarProducaoDiariaMaquina,
    buscarProducaoMensal
}
