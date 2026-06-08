var database = require("../database/config");

function verMatriz(idEmpresa) {

    var instrucaoSql = `
        SELECT * FROM view_verMatriz
        WHERE fkMatriz  = ${idEmpresa}
            OR idEmpresa = ${idEmpresa}
        ;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadEmpresa(cnpj, nome, codEmpresa, cep, numero) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", cnpj, nome, codEmpresa, cep, numero);
    
    var sqlEndereco = `
        INSERT INTO endereco (cep, numero)
        VALUES ('${cep}', '${numero}');
    `;
    console.log("Executando SQL:\n" + sqlEndereco);
    return database.executar(sqlEndereco)

        .then(function (resultadoEndereco) {
            var idEndereco = resultadoEndereco.insertId; 
            var sqlEmpresa = `
                INSERT INTO empresa (cnpj, nome, codEmpresa, fkEndereco)
                VALUES ('${cnpj}', '${nome}', '${codEmpresa}', '${idEndereco}');
            `;

            console.log("Executando SQL:\n" + sqlEmpresa);
            return database.executar(sqlEmpresa);
        });

}


module.exports = {
    verMatriz,
    cadEmpresa
}
