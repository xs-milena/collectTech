let validacao = false
let email_preenchido = false
let senha_preenchida = false

function email() {
    // validação email
    let email = ipt_email.value
    let fim = email.endsWith(".com") || email.endsWith('.com.br')
    let inicio = !email.startsWith("@") || !email.startsWith(".com")
    let vezes_arroba = email.indexOf("@") == email.lastIndexOf("@")
    let vezes_ponto_com = email.indexOf(".com") == email.lastIndexOf(".com")
    if (fim && inicio && vezes_arroba && vezes_ponto_com) {
        validacao = true
    } else {
        validacao = false
            
    }
    if (email.lenght >= 0){
        email_preenchido = true
    }
}

function senha() {
    // Validação senha
    let senha = ipt_senha.value
    if (senha = '') {
        
        validacao = false
    }
    if (senha.lenght >= 0){
        senha_preenchida = true
    }
}

function entrar(){
    // Simulação de entrada com dados válidos
    if (ipt_email.value == 'admin@collectTech.com' && ipt_senha.value == 'urubu100'){
        validacao = true
    }
    else {
        validacao = false
    }
    if (validacao == true){
        link_entrar.href = './index.html'
        alert('Seja bem vindo(a)!')
    } else {
        alert('Algo deu errado, confira os campos e tente novamente')
    }
}