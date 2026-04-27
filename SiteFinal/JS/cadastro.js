let validacao_cpf = false;
let validacao_nome = false
let validacao_email = false
let validacao_telefone = false
let validacao_cargo = false
let validacao_senha = false
let validacao_final = false;
let senha_correta = false;
let codigo_ativacao = "";
let cpf = "";
let nome = "";
let userEmail = "";
let telefone = "";
let cargo = "";
let userSenha = "";

function validarCpf() {
    cpf = ipt_cpf.value
    let indice_numeros = new RegExp('[0-9]')

    for (let i = 0; i < cpf.length; i++) {
        if (cpf.length == 11 && indice_numeros.test(cpf[i])) {
            validacao_cpf = true
            div_cpf.innerHTML = "";
        } else {
            div_cpf.innerHTML = 'Número de CPF Inválido!'
            validacao_cpf = false
            break
        }
    }
}

function validarNome() {
    //nome
    nome = ipt_nome.value;
    let indice_nome = new RegExp("[A-Za-zçÇÁáúÚéÉíÍÓóÂÃãâÊêÎîÔÕôõÛû ]");

    for (let i = 0; i < nome.length; i++) {
        if (indice_nome.test(nome[i]) == true && nome.length >= 5) {
            validacao_nome = true;
            div_nome.innerHTML = "";

        } else if (indice_nome.test(nome[i]) == false) {
            validacao_nome = false;
            div_nome.innerHTML = "Nome contêm caracteres inválidos!"
            break;

        } else if (nome.length < 5) {
            validacao_nome = false;
            div_nome.innerHTML = "Nome não contêm caracteres suficientes!"
            break;
        }
    }
}

function validarEmail() {
    //email
    userEmail = ipt_email.value;
    let fim = userEmail.endsWith(".com") || userEmail.endsWith('.com.br')
    let inicio = !userEmail.startsWith("@") || !userEmail.startsWith(".com")
    let vezes_arroba = userEmail.indexOf("@") == userEmail.lastIndexOf("@")
    let vezes_ponto_com = userEmail.indexOf(".com") == userEmail.lastIndexOf(".com")

    if (fim && inicio && vezes_arroba && vezes_ponto_com) {
        validacao_email = true
        div_email.innerHTML = "";

    } else {
        validacao_email = false
        div_email.innerHTML = "Email inválido!"
    }
}

function validarTelefone() {
    //telefone
    telefone = ipt_telefone.value;
    let indice_telefone = new RegExp("[0-9]");

    for (let i = 0; i < telefone.length; i++) {
        if (telefone.length == 11 && indice_telefone.test(telefone[i]) == true) {
            validacao_telefone = true
            div_telefone.innerHTML = "";

        } else if (indice_telefone.test(telefone[i]) == false) {
            validacao_telefone = false
            div_telefone.innerHTML = "Telefone contêm caracteres inválidos!"
            break;

        } else if (telefone.length != 11) {
            validacao_telefone = false
            div_telefone.innerHTML = "Telefone não contêm caracteres suficientes!"
            break;
        }
    }
}

function validarCargo() {
    cargo = ipt_cargo.value;
    cargo = cargo.toLowerCase();

    if (cargo == "gestor ambiental" ||
        cargo == "coordenador" ||
        cargo == "motorista"
    ) {
        validacao_cargo = true
        div_cargo.innerHTML = "";
    } else {
        validacao_cargo = false
        div_cargo.innerHTML = "Cargo inválido!"
    }
}

function validarSenha() {
    //senha
    userSenha = ipt_senha.value;
    let indice_senha = new RegExp("[0-9A-Za-z@_-]");

    for (let i = 0; i < userSenha.length; i++) {
        if (userSenha.length >= 6 && indice_senha.test(userSenha[i]) == true) {
            validacao_senha = true;
            senha_correta = true;
            div_senha.innerHTML = "";

        } else if (indice_senha.test(userSenha[i]) == false) {
            validacao_senha = false;
            senha_correta = false;
            div_senha.innerHTML = "Formato de senha inválido, são aceitos letras, números e apenas (@, _ e -) como caracteres especiais!"
            break;

        } else if (userSenha.length < 6) {
            validacao_senha = false;
            senha_correta = false;
            div_senha.innerHTML = "Senha não contêm caracteres suficientes!"
            break;
        }
    }
}

function cadastrar() {
    //confirmar senha
    let validacoes = [validacao_cpf, validacao_nome, validacao_email, validacao_telefone, validacao_cargo, validacao_senha];
    let senhaCorreta = false;
    let codigoCorreto = false;
    let confirmar_senha = ipt_confirmarSenha.value;
    codigo_ativacao = ipt_codigo.value;

    if (senha_correta == true && userSenha == confirmar_senha) {
        senhaCorreta = true;
        div_confirma.innerHTML = "";

    } else {
        senhaCorreta = false;
        div_confirma.innerHTML = "Senha divergente!"

    }
    
    if (codigo_ativacao == "AB123" ||
        codigo_ativacao == "CD456" ||
        codigo_ativacao == "EF789" ||
        codigo_ativacao == "GH101" ||
        codigo_ativacao == "IJ112" ||
        codigo_ativacao == "KL131" ||
        codigo_ativacao == "MN415" ||
        codigo_ativacao == "OP161" ||
        codigo_ativacao == "QR718" ||
        codigo_ativacao == "ST191") {
        div_codigo.innerHTML = "";
        codigoCorreto = true;

    } else {
        codigoCorreto = false;
        div_codigo.innerHTML = "Este código não existe!"

    }

    for(let i = 0; i < validacoes.length; i++) {
        if(validacoes[i] == true) {
            validacao_final = true;
        }else {
            validacao_final = false;
            break;
        }
    }
    
    if (validacao_final == true &&
        senhaCorreta == true &&
        codigoCorreto == true
    ) {
        alert("Cadastro concluido com sucesso.");

    } else {
        alert("Cadastro não pode ser concluido, reveja as informações.");
    }
}