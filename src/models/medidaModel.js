var database = require("../database/config");

function buscarUltimasMedidas(idEmpresa) {

    var instrucaoSql = `
        SELECT * FROM view_buscarUltimasMedidas
            WHERE idEmpresa = ${idEmpresa}
            AND date(hrRegistro) = curdate()
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idEmpresa) {

    var instrucaoSql = `
    SELECT * FROM view_buscarMedidasEmTempoReal
        WHERE idEmpresa = ${idEmpresa}
        and date(hrRegistro) = curdate()
        ORDER BY momento_grafico desc
        limit 15;
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

// ranking de todas as maquinas
function buscarTodasMaquinas(idEmpresa) {
    var instrucaoSql = `
        SELECT * FROM view_buscarTodasMaquinas
        WHERE fkEmpresaMaquina = ${idEmpresa}
        ORDER BY eficiencia ASC;
    `;
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarProducaoGeral(idEmpresa) {

    var instrucaoSql = `
    SELECT * FROM (
        SELECT 
            DATE_FORMAT(r.hrRegistro, '%H:00') AS horario,
            COUNT(r.idRegistro) AS producao
        FROM registroSensor r
        JOIN sensor s ON r.fkSensor = s.idSensor
        JOIN maquina m ON s.fkMaquina = m.idMaquina
        WHERE m.fkEmpresaMaquina = ${idEmpresa}
        AND DATE(r.hrRegistro) = CURDATE() 
        GROUP BY horario
        ORDER BY horario desc
        limit 15) ultimos
    order by horario asc
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoDiariaMaquina(idEmpresa) {

    var instrucaoSql = `
        SELECT * FROM view_buscarProducaoDiariaMaquina
        WHERE fkEmpresaMaquina = ${idEmpresa} 
        AND data = CURDATE()
        ORDER BY producao DESC;
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoMensal(idSensor) {
    var instrucaoSql = `
        SELECT * FROM view_buscarProducaoMensal
        WHERE fkSensor = ${idSensor}
        
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
        where idMaquina = ${idMaquina} 
    `;

    console.log(instrucaoSql);

    return database.executar(instrucaoSql);
}

function buscarProducaoMinuto(idMaquina) {

    var instrucaoSql = `
    select * from 
        (select
                date_format(hrRegistro, '%H:%i') as momento_grafico,
                sum(valorRegistro) as totalLatas
        from registroSensor
        join sensor
            on registroSensor.fkSensor = sensor.idSensor
        join maquina
            on sensor.fkMaquina = maquina.idMaquina
        where idMaquina = ${idMaquina}
        and date(hrRegistro) = curdate()
        group by date_format(hrRegistro, '%H:%i')
        order by momento_grafico desc
        limit 15) ultimo
    order by momento_grafico asc;
    `;

    console.log(instrucaoSql);
    console.log("Teste de consoloe");

    return database.executar(instrucaoSql);
}

function buscarProducaoMensalMaquina(idMaquina) {

    var instrucaoSql = `
        SELECT * FROM view_buscarProducaoMensalMaquina
        where idMaquina = ${idMaquina}
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
