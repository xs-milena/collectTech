// importando os bibliotecas necessárias
const { GoogleGenAI } = require("@google/genai");
const express = require("express");
const path = require("path");
const documentacao = `
CONTEXTO
A gestão de resíduos sólidos ainda enfrenta desafios significativos, mesmo em grandes centros urbanos que possuem acesso a tecnologias avançadas. No Brasil, milhões de toneladas de resíduos são produzidas anualmente, e uma parcela considerável ainda recebe destinação inadequada, evidenciando falhas no monitoramento e na logística de coleta. Na cidade de São Paulo, os Ecopontos desempenham um papel fundamental no descarte de materiais recicláveis e resíduos volumosos, recebendo grandes quantidades de resíduos diariamente. Entretanto, o processo de coleta nesses locais ainda ocorre sem informações precisas sobre o nível de ocupação das lixeiras, fazendo com que a operação dependa de verificações periódicas e nem sempre eficientes.

JUSTIFICATIVA
A ausência de monitoramento em tempo real gera impactos diretos na eficiência operacional da coleta. Sem informações confiáveis sobre o preenchimento das lixeiras, caminhões podem ser deslocados para pontos que ainda não necessitam de atendimento, enquanto outros podem atingir sua capacidade máxima antes da coleta ser realizada. Esse cenário provoca desperdício de combustível, aumento dos custos de manutenção da frota, uso inadequado da mão de obra e riscos de transbordamento dos resíduos. Dessa forma, torna-se necessária a implementação de uma solução tecnológica capaz de fornecer dados precisos para apoiar a tomada de decisões, reduzir gastos operacionais e melhorar a qualidade do serviço prestado à população.

OBJETIVO
O projeto Collect Tech tem como objetivo monitorar o volume de resíduos presente nas lixeiras dos Ecopontos por meio de sensores ultrassônicos integrados a uma plataforma web. Esses sensores realizam a medição do nível de preenchimento das lixeiras e enviam os dados para o sistema, permitindo o acompanhamento em tempo real da situação de cada ponto monitorado. A plataforma disponibiliza gráficos, relatórios e alertas automáticos quando a ocupação ultrapassa 80% da capacidade, auxiliando os gestores na definição das rotas de coleta. Com isso, busca-se otimizar o processo logístico, reduzir custos operacionais, minimizar impactos ambientais e aumentar a eficiência da gestão de resíduos nos bairros da Sé, Liberdade, Bela Vista, Cambuci, Alto de Pinheiros, Vila Madalena e Pinheiros.
`

// carregando as variáveis de ambiente do projeto do arquivo .env
require("dotenv").config();

// configurando o servidor express
const app = express();
const PORTA_SERVIDOR = process.env.PORTA;

// configurando o gemini (IA)
const chatIA = new GoogleGenAI({ apiKey: process.env.MINHA_CHAVE });

// configurando o servidor para receber requisições JSON
app.use(express.json());

// configurando o servidor para servir arquivos estáticos
app.use(express.static(path.join(__dirname, "public")));

// configurando CORS
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
    next();
});

// inicializando o servidor
app.listen(PORTA_SERVIDOR, () => {
    console.info(
        `
        ######                ###    #    
        #     #  ####  #####   #    # #   
        #     # #    # #    #  #   #   #  
        ######  #    # #####   #  #     # 
        #     # #    # #    #  #  ####### 
        #     # #    # #    #  #  #     # 
        ######   ####  #####  ### #     # 
        `
    );
    console.info(`A API BobIA iniciada, acesse http://10.18.32.31:${PORTA_SERVIDOR}`);
});

// rota para receber perguntas e gerar respostas
app.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;

    try {
        const resultado = await gerarResposta(pergunta);
        res.json({ resultado });
    } catch (error) {
        res.status(500).json({ error: 'Erro interno do servidor' });
    }

});

// função para gerar respostas usando o gemini
async function gerarResposta(mensagem) {

    try {
        // gerando conteúdo com base na pergunta
        const modeloIA = chatIA.models.generateContent({
            model: "gemini-2.5-flash",
            contents: `Em um paragráfo responda: ${mensagem} use como base ${documentacao}. Seja gentil e não use termos técnicos, agindo como se fosse um membro da equipe CollectTech.`

        });
        const resposta = (await modeloIA).text;
        const tokens = (await modeloIA).usageMetadata;

        console.log(resposta);
        console.log("Uso de Tokens:", tokens);

        return resposta;
    } catch (error) {
        console.error(error);
        throw error;
    }
}
