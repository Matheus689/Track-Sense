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

    var instrucaoSql = `
        SELECT 
            DATE_FORMAT(hrRegistro, '%H:%i') AS momento_grafico,

            ROUND(AVG(valorRegistro),0) AS registro

        FROM empresa

        JOIN maquina
            ON empresa.idEmpresa = maquina.fkEmpresaMaquina

        JOIN sensor
            ON maquina.idMaquina = sensor.fkMaquina

        JOIN registroSensor
            ON registroSensor.fkSensor = sensor.idSensor

        WHERE empresa.idEmpresa = ${idEpresa}

        GROUP BY DATE_FORMAT(hrRegistro, '%H:%i')

        ORDER BY momento_grafico ASC;
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
            ROUND(AVG(r.valorRegistro), 0) AS producao,
            ROUND(AVG(r.valorRegistro), 0) AS eficiencia
        FROM maquina m
        JOIN sensor s ON s.fkMaquina = m.idMaquina
        LEFT JOIN registroSensor r 
            ON r.fkSensor = s.idSensor
            AND DATE(r.hrRegistro) = CURDATE()
        WHERE m.fkEmpresaMaquina = ${idEmpresa}
        GROUP BY m.idMaquina, m.numMaquina, s.idSensor, s.estadoSensor
        ORDER BY eficiencia DESC
    `;
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarProducaoGeral(idEmpresa) {

    var instrucaoSql = `
        SELECT 
            DATE_FORMAT(r.hrRegistro, '%H:00') AS horario,

            ROUND(AVG(r.valorRegistro),0) AS producao

        FROM registroSensor r

        JOIN sensor s
            ON r.fkSensor = s.idSensor

        JOIN maquina m
            ON s.fkMaquina = m.idMaquina

        WHERE m.fkEmpresaMaquina = ${idEmpresa}
        AND DATE(r.hrRegistro) = CURDATE()

        GROUP BY horario

        ORDER BY horario;
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoDiariaMaquina(idEmpresa) {

    var instrucaoSql = `
        SELECT 
            m.numMaquina AS maquina,

            ROUND(AVG(r.valorRegistro),0) AS producao

        FROM maquina m

        JOIN sensor s
            ON s.fkMaquina = m.idMaquina

        LEFT JOIN registroSensor r
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
            SUM(valorRegistro) as totalLatas
        FROM registroSensor
        WHERE fkSensor = ${idSensor}
        GROUP BY YEAR(hrRegistro), MONTH(hrRegistro)
        ORDER BY ano, mes
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function maquinaEspecifica(idMaquina) {

    var instrucaoSql = `
        select
            idMaquina,
            numMaquina
        from maquina
        where idMaquina = ${idMaquina};
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoMinuto(idMaquina) {

    var instrucaoSql = `
        select
            date_format(hrRegistro, '%H:%i') as momento_grafico,
            sum(valorRegistro) as totalLatas
        from registroSensor
        join sensor
            on registroSensor.fkSensor = sensor.idSensor
        join maquina
            on sensor.fkMaquina = maquina.idMaquina
        where idMaquina = ${idMaquina}
        group by date_format(hrRegistro, '%H:%i')
        order by momento_grafico;
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoMensalMaquina(idMaquina) {

    var instrucaoSql = `
        select
            year(hrRegistro) as ano,
            month(hrRegistro) as mes,
            sum(valorRegistro) as totalLatas
        from registroSensor
        join sensor
            on registroSensor.fkSensor = sensor.idSensor
        join maquina
            on sensor.fkMaquina = maquina.idMaquina
        where idMaquina = ${idMaquina}
        group by
            year(hrRegistro),
            month(hrRegistro)
        order by
            ano,
            mes;
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

module.exports = {
    buscarProducaoMensalMaquina,
    buscarProducaoMinuto,
    maquinaEspecifica,
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarTodasMaquinas,
    buscarProducaoGeral,
    buscarProducaoDiariaMaquina,
    buscarProducaoMensal
}
