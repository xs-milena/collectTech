let validacao = false
let email_preenchido = false
let senha_preenchida = false
let userEmail = "";
let userSenha = "";
let codigo_ativacao = "";

function validarEmail() {
    // validação email
    userEmail = ipt_email.value
    let fim = userEmail.endsWith(".com") || userEmail.endsWith('.com.br')
    let inicio = !userEmail.startsWith("@") || !userEmail.startsWith(".com")
    let vezes_arroba = userEmail.indexOf("@") == userEmail.lastIndexOf("@")
    let vezes_ponto_com = userEmail.indexOf(".com") == userEmail.lastIndexOf(".com")

    if (fim && inicio && vezes_arroba && vezes_ponto_com) {
        validacao = true
    } else {
        validacao = false
            
    }

    if (email.lenght >= 0){
        email_preenchido = true
    }
}

function validarSenha() {
    // Validação senha
    userSenha = ipt_senha.value

    if (senha == '') {
        validacao = false
    }

    if (senha.lenght > 0){
        senha_preenchida = true
    }
}


 function entrar() {
    codigo_ativacao = ipt_codigo.value;

    // Simulação de entrada com dados válidos
    if (userEmail == 'admin@collectTech.com'){
        validacao_email = true;
        div_email.innerHTML = ""
    }
    else {
        validacao_email = false;
        div_email.innerHTML = "Email inválido!"
    }

    if (userSenha == 'urubu100'){
        validacao_senha = true;
        div_senha.innerHTML = ""
    }
    else {
        validacao_email = false;
        div_senha.innerHTML = "Senha incorreta!"
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
        codigo_ativacao == "ST191"){
            
        validacao_codigo = true;
        div_codigo.innerHTML = ""

    }
    else {
        validacao_codigo = false;
        div_codigo.innerHTML = "Código inválido!"
    }

    if (validacao_codigo &&
        validacao_email &&
        validacao_senha
    ){
        window.location.href = './dashboard.html'; 
        alert('Seja bem vindo(a)!')

    } else {
        alert('Algo deu errado, confira os campos e tente novamente')
    }

}
