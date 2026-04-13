let validacao = false
function nome() {
    //nome

    let nome = ipt_nome.value;
    let indice_nome = new RegExp("[A-z]");
    if (indice_nome.test(nome) == true) {
        validacao = true
    } else { validacao = false }
}
function telefone() {
    //telefone

    let telefone = ipt_telefone.value;
    let indice_telefone = new RegExp("[0-9]");
    if (telefone.length == 12 && indice_telefone.test(telefone) == true) {
        validacao = true
    } else { validacao = false }
}
let senha_correta = false
function senha() {
    //senha
    let senha = ipt_senha.value;
    let indice_senha = new RegExp("[}{,.^?~=+-_/*-+.|],");
    if (senha.length >= 6 && indice_senha.test(senha) == false) {
        validacao = true
        senha_correta = true
    } else { validacao = false }
}

function validação_senha() {
    //validação senha
    let senha = ipt_senha.value;
    let confirmar_senha = ipt_confirmarSenha.value;
    if (senha_correta == true && senha == confirmar_senha) {
        validacao = true
    } else { validacao = false }
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
    } else { validacao = false }
}
function cadastrar() {
    //validação
    if (validacao == true) {
        alert("Cadastro concluido com sucesso.")
    } else {
        alert("Cadastro não pode ser concluido, reveja as informações.")
    }
}