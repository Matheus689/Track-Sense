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

function cadEmpresa(cnpj, nome, codEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha);
    
    var instrucaoSql = `
        INSERT INTO empresa (cnpj, nome, codEmpresa) VALUES ('${cnpj}', '${nome}', '${codEmpresa}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql)
         .then(function (resultadoEmpresa) {
            var idEmpresa = resultadoEmpresa.insertId;

            var sqlEndereco = `
                INSERT INTO endereco (cep, numero, fkEmpresa)
                VALUES ('${cep}', '${numero}', '${idEmpresa}');
            `;

            console.log("Executando a instrução SQL: \n" + sqlEndereco);
            return database.executar(sqlEndereco);
        });
}


module.exports = {
    verMatriz,
    cadEmpresa
}
