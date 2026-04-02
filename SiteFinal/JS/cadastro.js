let validacao = false
function nome() {
    //nome

    let nome = ipt_nome.value;
    let indice_nome = new RegExp("[A-z]");
    for (let i = 0; i < nome.length; i++) {
        if (indice_nome.test(nome[i]) == true) {
            validacao = true;
        } else {
            validacao = false;
            break;
            .innerHTML = "Nome contem caracteres invalidos!"
        }
    }
}
function telefone() {
    //telefone

    let telefone = ipt_telefone.value;
    let indice_telefone = new RegExp("[0-9], [ ]");
    for (let i = 0; i < telefone.length; i++) {
        if (telefone.length == 12 && indice_telefone.test(telefone[i]) == true) {
            validacao = true
        } else {
            validacao = false
            break;
            .innerHTML = "Telefone contem caracteres invalidos!"
        }
    }
}
let senha_correta = false
function senha() {
    //senha
    let senha = ipt_senha.value;
    let indice_senha = new RegExp("[0-9], [A-z], [@_-]");
    for (let i = 0; i < senha.length; i++) {
        if (senha.length >= 6 && indice_senha.test(senha[i]) == true) {
            validacao = true
            senha_correta = true
        } else {
            validacao = false
            break;
            .innerHTML = "Formato de senha invalido, são aceitos apenas (@, _ e -) como caracteres esspeciais!"
        }
    }
}
function validação_senha() {
    //validação senha
    let senha = ipt_senha.value;
    let confirmar_senha = ipt_confirmarSenha.value;
    if (senha_correta == true && senha == confirmar_senha) {
        validacao = true
    } else {
        validacao = false
            .innerHTML = "Senha divergente!"
    }
}
function email() {
    //email
    let email = ipt_email.value;
    let indice_ponto_com = email.indexOf(".com")
    let indice_arroba = email.indexOf("@")
    let fim = email.endsWith(".com") || email.endsWith('.com.br')
    let inicio = !email.startsWith("@") || !email.startsWith(".com")
    let vezes_arroba = email.indexOf("@") == email.lastIndexOf("@")
    let vezes_ponto_com = email.indexOf(".com") == email.lastIndexOf(".com")
    if (indice_ponto_com && indice_arroba && fim && inicio && vezes_arroba && vezes_ponto_com) {
        validacao = true
    } else {
        validacao = false
            .innerHTML = "Email invalido!"
    }
}
function cadastrar() {
    //validação
    if (validacao == true) {
        alert("Cadastro concluido com sucesso.")
    } else {
        alert("Cadastro não pode ser concluido, reveja as informações.")
    }
}
function cep() {
    for (let i = 0; i < array.length; i++) {
        if () {

        } else {

        }
    }
}
function cpf() {
    for (let i = 0; i < array.length; i++) {
        if () {

        } else {

        }
    }
}