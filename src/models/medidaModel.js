var database = require("../database/config");

function buscarUltimasMedidas(idEmpresa) {

    // var instrucaoSql = `
    // SELECT 
    //     valorRegistro as registro, 
    //     hrRegistro as momento_grafico
    // FROM registroSensor
    // WHERE fkSensor = ${idSensor};`;

    var instrucaoSql = `
            SELECT
                -- empresa.nome,
                -- maquina.idMaquina,
                -- sensor.idSensor,
                valorRegistro as registro, 
                hrRegistro as momento_grafico
            FROM registroSensor
            join sensor 
                on registroSensor.fkSensor = sensor.idSensor
            join maquina
                on sensor.fkMaquina = maquina.idMaquina
            join empresa 
                on maquina.fkEmpresaMaquina = empresa.idEmpresa
            where empresa.idEmpresa = ${idEmpresa}
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idEpresa) {
    // var instrucaoSql = `
    //     SELECT 
    //         DATE_FORMAT(hrRegistro, '%H:%i') AS momento_grafico,
    //         COUNT(*) AS registro
    //     FROM registroSensor
    //     WHERE fkSensor = ${idSensor}
    //     AND DATE(hrRegistro) = CURDATE()
    //     GROUP BY DATE_FORMAT(hrRegistro, '%H:%i')
    //     ORDER BY momento_grafico ASC
    // `;
    var instrucaoSql = `
        select 
			DATE_FORMAT(hrRegistro, '%H:%i') AS momento_grafico,
            COUNT(*) AS registro,
            empresa.idEmpresa
		from empresa
        join maquina 
			on empresa.idEmpresa = maquina.fkEmpresaMaquina
		join sensor 
			on maquina.idMaquina = sensor.fkMaquina
		join registroSensor
			on registroSensor.fkSensor = sensor.idSensor
		where empresa.idEmpresa = ${idEpresa}
        -- and DATE(hrRegistro) = CURDATE()
		GROUP BY DATE_FORMAT(hrRegistro, '%H:%i')
        ORDER BY momento_grafico ASC;
    `;

    console.log(`Buscar medidas em tempo real <br>${instrucaoSql}`);

    return database.executar(instrucaoSql);
}

// ranking de todas as maquinas
function buscarTodasMaquinas(idEmpresa, limite) {
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
        -- AND DATE(r.hrRegistro) = CURDATE()
        GROUP BY m.idMaquina, m.numMaquina, s.idSensor, s.estadoSensor
        ORDER BY eficiencia ASC;
    `
    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoGeral(idEmpresa) {
    var instrucaoSql = `
        SELECT 
            DATE_FORMAT(r.hrRegistro, '%H:00') AS horario,
            COUNT(r.idRegistro) AS producao
        FROM registroSensor r
        JOIN sensor s ON r.fkSensor = s.idSensor
        JOIN maquina m ON s.fkMaquina = m.idMaquina
        WHERE m.fkEmpresaMaquina = ${idEmpresa}
        AND DATE(r.hrRegistro) = CURDATE()
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
            COUNT(r.idRegistro) AS producao
        FROM maquina m
        JOIN sensor s ON s.fkMaquina = m.idMaquina
        LEFT JOIN registroSensor r
            ON r.fkSensor = s.idSensor
            -- AND DATE(r.hrRegistro) = CURDATE()
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
