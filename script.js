
// BANCO DE DADO -  local storage é tipo os cookies (coloquei para nao perder os usuarios cadastrados)
let usuario = JSON.parse(localStorage.getItem("listaUsuarios")) || [
    ["sara", "sara.com", "senha1"]
];

let temCaractere = false
let temMaiuscula = false
let temMinuscula = false
let confSenha = false
let tamanhoSenha = false
let emailConfi = false

let nome
let email
let senha

function cadValidarEmail() {
    email = inpEmail.value.toLowerCase();

    emailConfi = false;
    let valiEmail = ["@"];
    let valiEmail2 = ["."];

    for (let j = 0; j < valiEmail.length; j++) {
        if (email.includes(valiEmail[j])) {
            let posicaoArroba = email.indexOf(valiEmail)
            let posicaoPonto = email.lastIndexOf(valiEmail2)
            if (email.includes(valiEmail2[j]) && posicaoArroba < posicaoPonto) {
                emailConfi = true;
            }
        }
    }

    if (emailConfi) {
        exibirResultadoEmail.innerHTML = '';
    } else {
        exibirResultadoEmail.innerHTML = 'Coloque um e-mail válido';
    }
}


function cadValidarCadastro() {

    // redeclara pq o usuario pode apagar o texto e eu  nao quero o negocio sempre true ne
    temCaractere = false
    temMaiuscula = false
    temMinuscula = false
    confSenha = false
    tamanhoSenha = false


    nome = inpNome.value
    email = inpEmail.value.toLowerCase()
    senha = inpSenha.value

    let sConfirmar = inpSenhaConf.value
    let valiCaractere = ["!", "@", "#", "$", "%", "&"]



    // valida de tem caracter especial  eee eamil
    for (let i = 0; i < valiCaractere.length; i++) {
        let contemCaractere = senha.includes(valiCaractere[i])
        if (contemCaractere) {
            console.log(contemCaractere)
            temCaractere = true
        }
    }




    // valida o tamanho da senha
    if (senha.length >= 8) {
        tamanhoSenha = true
    }

    if (!temCaractere) {
        exibirResultadoCadastro.innerHTML = "Coloque um caractere especial"

    }

    // valida se tem uma letra maiuscula
    if (senha != senha.toUpperCase()) {
        temMinuscula = true
    }

    // valida se tem minuscula
    if (senha != senha.toLowerCase()) {
        temMaiuscula = true
    }

    // vc so pode confirmar a senha se vc tiver ja tiver passado por todas as validações
    if ((temCaractere && temMaiuscula && temMinuscula)) {
        if ((senha == sConfirmar)) {
            confSenha = true
        }

    }

    if (temMaiuscula == false) {
        exibirResultadoCadastro.innerHTML = "Insira no mínimo uma letra maiúscula"
    } else if (temMinuscula == false) {
        exibirResultadoCadastro.innerHTML = "Insira no mínimo uma letra minúscula"
    } else if (temCaractere == false) {
        exibirResultadoCadastro.innerHTML = "Insira no mínimo um caractere especial"
    } else if (tamanhoSenha == false) {
        exibirResultadoCadastro.innerHTML = "Insira no mínimo 8 dígitos"
    } else if (senha != sConfirmar) {
        exibirResultadoCadastro.innerHTML = "As senhas devem ser iguais"
    } else {
        exibirResultadoCadastro.innerHTML = ""
    }

    // console.log('especial' + temCaractere)
    // console.log('Maiusc' + temMaiuscula)
    // console.log('minus' + temMinuscula)
}

function CadCadastrar() {


    if (emailConfi == false) {
        exibirResultadoEmail.innerHTML = 'Coloque um email válido'
    } else {
        exibirResultadoEmail.innerHTML = ''
        if (temCaractere && temMaiuscula && temMinuscula && confSenha && tamanhoSenha) {
            alert("Cadastro realizado com sucesso")
            usuario.push([nome, email, senha])

            localStorage.setItem("listaUsuarios", JSON.stringify(usuario));
            let ultimo = usuario.length - 1

            console.log("Nome:", usuario[ultimo][0])
            console.log("Email:", usuario[ultimo][1])
            console.log("Senha:", usuario[ultimo][2])
            window.location.href = "Login.html";
        }
    }


    // EXPLICAÇÃO VETOR COM DUAS CASINHAS
    // A primeira casinha vai ser a linha, e a segunda a coluna, ou seja, [ULTIMO] vai referenciar a ultima LINHA, 
    // [0] a primeira COLUNA (nome), [1] a segunda COLUNA (email) e [2] a terceira COLUNA (senha)
    // visualmente a variavel fica assim: 
    // usuario = [
    //    [linha ] [ coluna 1, coluna 2, coluna 3],
    //    [linha 1] ["nome2", "email.com2", "senha2"]
    // ]
}

function LogEntrar() {
    let emailDigitado = inpEmail.value.toLowerCase();
    let senhaDigitada = inpSenha.value;
    let usuarioEncontrado = false;


    for (let i = 0; i < usuario.length; i++) {
        let emailCadastrado = usuario[i][1];
        let senhaCadastrada = usuario[i][2];

        if (emailDigitado == emailCadastrado && senhaDigitada == senhaCadastrada) {
            usuarioEncontrado = true;
            let nomeUsuario = usuario[i][0];

            alert(`Bem-vindo, ${nomeUsuario}! Você entrou na sua página.`);
            localStorage.setItem("logado", "true");
            window.location.href = "dashboard.html";
        }
    }

    if (!usuarioEncontrado) {
        alert("E-mail ou senha incorretos.");
    }
}

function cadValidarCNPJ() {

    let cnpj = ipt_cnpj.value.replace(/\D/g, '');

    // tamanho
    if (cnpj.length != 14) {
        exibirResultadoCNPJ.innerHTML = "CNPJ deve ter 14 números";
        return false;
    }

    // números repetidos
    if (/^(\d)\1+$/.test(cnpj)) {
        exibirResultadoCNPJ.innerHTML = "CNPJ inválido";
        return false;
    }

    // primeiro dígito
    let soma = 0;
    let peso = 5;

    for (let i = 0; i < 12; i++) {
        soma += cnpj[i] * peso;
        peso--;
        if (peso < 2) peso = 9;
    }

    let resto = soma % 11;
    let dig1 = resto < 2 ? 0 : 11 - resto;

    // segundo dígito
    soma = 0;
    peso = 6;

    for (let i = 0; i < 13; i++) {
        soma += cnpj[i] * peso;
        peso--;
        if (peso < 2) peso = 9;
    }

    resto = soma % 11;
    let dig2 = resto < 2 ? 0 : 11 - resto;

    // validação final
    if (dig1 != cnpj[12] || dig2 != cnpj[13]) {
        exibirResultadoCNPJ.innerHTML = "CNPJ inválido";
        return false;
    }

    // válido
    exibirResultadoCNPJ.innerHTML = "";
    return true;
}