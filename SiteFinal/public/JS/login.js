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


 function entrar() {

    // Simulação de entrada com dados válidos
    // if (ipt_email.value == 'admin@collectTech.com' && ipt_senha.value == 'urubu100'){
    //     validacao = true
    // }
    // else {
    //     validacao = false
    // }
    // if (validacao == true){
    //     link_entrar.href = './index.html'
    //     alert('Seja bem vindo(a)!')
    // } else {
    //     alert('Algo deu errado, confira os campos e tente novamente')
    // }

        aguardar();

        var emailVar = ipt_email.value;
        var senhaVar = ipt_senha.value;
        var codigoVar = ipt_codigo.value;
        var idEmpresaVincular

        if (emailVar == "" || senhaVar == "" || codigoVar == "") {
            cardErro.style.display = "block"
            mensagem_erro.innerHTML = "(Mensagem de erro para todos os campos em branco)";
            finalizarAguardar();
            return false;
        }
        else {
            setInterval(sumirMensagem, 5000)
        }

  
        console.log("FORM LOGIN: ", emailVar);
        console.log("FORM SENHA: ", senhaVar);
        console.log("FORM CODIGO: ", codigoVar);

        fetch("/usuarios/autenticar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                emailServer: emailVar,
                senhaServer: senhaVar,
                codigoServer: codigoVar
            })
        }).then(function (resposta) {
            console.log("ESTOU NO THEN DO entrar()!")

            if (resposta.ok) {
                console.log(resposta);

                resposta.json().then(json => {
                    console.log(json);
                    console.log(JSON.stringify(json));
                    sessionStorage.EMAIL_USUARIO = json.email;
                    sessionStorage.NOME_USUARIO = json.nome;
                    sessionStorage.ID_USUARIO = json.id;
                    sessionStorage.CODIGO_USUARIO = json.codigo;
                    sessionStorage.AQUARIOS = JSON.stringify(json.aquarios)

                    setTimeout(function () {
                        window.location = "./dashboard/cards.html";
                    }, 1000); // apenas para exibir o loading

                });

            } else {

                console.log("Houve um erro ao tentar realizar o login!");

                resposta.text().then(texto => {
                    console.error(texto);
                    finalizarAguardar(texto);
                });
            }

        }).catch(function (erro) {
            console.log(erro);
        })

        return false;
    }

    function sumirMensagem() {
        cardErro.style.display = "none"
    }
