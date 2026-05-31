var database = require("../database/config");

function verMatriz(idEmpresa) {

    var instrucaoSql = `
        
        select 
            empresa.idEmpresa,
            empresa.nome,
            count(distinct( maquina.idMaquina)) as maquinas  ,
            count(registroSensor.valorRegistro) as eficiencia
        from empresa
        left join maquina
        on maquina.fkEmpresaMaquina = idEmpresa 
        left join sensor 
            on sensor.fkMaquina = maquina.idMaquina
        left join registroSensor
            on registroSensor.fkSensor = sensor.idSensor and registroSensor.valorRegistro = 1
        where empresa.fkMatriz  = ${idEmpresa}
            or empresa.idEmpresa = ${idEmpresa}
        group by empresa.idEmpresa;
        ;

    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    verMatriz
}
