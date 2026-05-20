// importando os bibliotecas necessárias
const { GoogleGenAI } = require("@google/genai");
const express = require("express");
const path = require("path");
const documentacao = `
CONTEXTO
O cenário nas metrópoles é marcado por grandes desafios. Enquanto a tecnologia é avançada, os serviços essenciais de infraestrutura básica, como a gestão de resíduos sólidos, ainda funcionam de forma analógica e retroativa. No Brasil, esse atraso se mostra alarmante. Segundo o relatório Panorama dos Resíduos Sólidos no Brasil 2023, que foi elaborado pela Associação Brasileira de Resíduos e Meio Ambiente, a ABREMA, o país gera mais de 81 milhões de toneladas atualmente e, aproximadamente, 41,5% desses dejetos possuem um descarte inadequado, mostrando que o problema reside também no monitoramento, coleta e processamento desse lixo.
Dentro desse panorama, a cidade de São Paulo se mostra um epicentro de como esse contexto se materializa. Com a produção de 20 mil toneladas de resíduos por dia, a capital paulista lida com essas situações de logística com o sistema de Ecopontos, que é planejado para que as pessoas possam se descentralizar onde o descarte de materiais volumosos e recicláveis é feito. No primeiro semestre de 2023, eles receberam aproximadamente 190 mil toneladas de detritos. No entanto, o sistema de coleta desses pontos de entrega carece de um sistema de tecnologia. Atualmente, essa coleta é realizada de forma cega ou com um cronograma fixo que ignora o preenchimento real das lixeiras e caçambas. 
Essa falta de integração tecnológica acaba gerando uma grande ineficiência e grandes perdas econômicas. Sem saber o nível de ocupação de um ecoponto, as prefeituras municipais enfrentam dois desafios críticos. Ou enviam frotas para remover lixeiras quase vazias, o que gera um gasto desnecessário com combustível, além da manutenção do veículo, ou ocorre o atraso da coleta de pontos já transbordando. 
Nesse cenário, o sistema de coleta dos resíduos sólidos necessita de uma modernização, e é nesse ambiente que o projeto Collect Tech se posiciona. Com tecnologia IoT e com o intuito da instalação de sensores ultrassônicos acoplados em lixeiras de Ecopontos, esses dispositivos são capazes de ler a distância entre os resíduos e o topo das lixeiras, transformando essas informações em dados percentuais de preenchimento.
Ao integrar esses sensores a uma plataforma web, o Collect Tech transformará a coleta de lixo em um sistema inteligente. Ele permite que os gestores vejam mapas de calor sobre as zonas que têm o maior descarte de resíduos, otimizem as rotas de caminhões de acordo com a demanda real com alertas com a capacidade maior de 80 por cento e geram relatórios que ajudarão no planejamento estatístico a longo prazo. Dessa forma, a solução não apenas reduzirá os custos e o impacto ambiental, mas estabelecerá um novo nível de eficiência do serviço público.

OBJETIVO 
O objetivo deste projeto é realizar o monitoramento do volume residual em lixeiras de ecoponto, além de otimizar o sistema de decisão de envio dos caminhões de coleta para lixeiras cujo nível ultrapasse 80% de sua capacidade total, visando reduzir não somente o acúmulo de lixo, como também a redução de custos operacionais. 
Ademais, esse objetivo se enquadra na metodologia SMART ao ser: 
Específico: Para tornar esse processo mais eficiente, o projeto foca especificamente em lixeiras de ecoponto localizadas na região central de São Paulo, nos bairros da Liberdade, Sé, Bela Vista e Cambuci, tendo em vista que são regiões onde há grande concentração de lixo urbano. 
Mensurável: Lixeiras de ecoponto possuem medidas padronizadas em relação ao tamanho e volume, possibilitando um monitoramento mensurável. 
Realista: De acordo com os itens citados anteriormente, o objetivo se torna realista ao utilizar um sensor que detecta o volume residual de lixo dentro das lixeiras de ecoponto, permitindo a utilização destes dados em gráficos para futuras análises do cliente. Além de utilizar um sistema otimizado de definição de rotas baseado no nível de ocupação das lixeiras, eliminando deslocamentos desnecessários até lixeiras vazias com baixa capacidade ocupada. 
Relevante: O projeto agrega valor ao cliente ao auxiliar na decisão de envio dos caminhões, deste modo, diminuindo custos operacionais. Além de reduzir os impactos ambientais ao tornar o processo logístico eficiente. 
Temporal: O projeto visa reduzir em 30% o volume residual presente nas lixeiras de ecopontos no período de até 12 meses após a implementação do sistema. Além disso, pretende reduzir em 25% os trajetos desnecessários realizados pelos caminhões de coleta, bem como diminuir em 20% os gastos com combustível da frota de coleta municipal no mesmo período.

JUSTIFICATIVA 
De acordo com a prefeitura de São Paulo, só na primeira metade de 2023 os Ecopontos da cidade receberam cerca de 190 mil toneladas de resíduos. Esse volume exige uma logística contínua de coleta, e sem dados atualizados, os caminhões podem percorrer trajetos desnecessários até lixeiras vazias ou parcialmente cheias, resultando em um consumo excessivo de combustível e acúmulo de resíduos em ruas próximas a lixeiras cheias que acabaram não recebendo atenção. 
Considerando que o combustível representa um custo diretamente proporcional à distância percorrida, qualquer ineficiência logística pode gerar um impacto financeiro significativo e recorrente. Impacto esse que pode ser facilmente reduzido com a inteligência operacional que o sistema da Collect Tech pode proporcionar, pois com ele seria possível saber exatamente os pontos que precisam de atenção e planejar a rota mais eficiente para coletá-los, evitando desvios desnecessários e otimizando o serviço, tempo e o orçamento municipal. 
E para reforçar ainda mais a eficiência deste tipo de sistema, é possível observar a cidade de Edimburgo, na Escócia, que após implementar+ um sistema parecido de monitoramento de lixo registrou uma redução de 30% nos gastos com combustível e mão de obra para coleta de resíduos, além de uma maior satisfação pública, tanto de residentes como turistas, qualidade do ar elevada devido a menor emissão de carbono, e 50% menos reclamações sobre lixeiras cheias.
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
    console.info(`A API BobIA iniciada, acesse http://localhost:${PORTA_SERVIDOR}`);
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
            contents: `Em um paragráfo responda: ${mensagem} use como base ${documentacao}. Seja gentil e não ue termos técnicos, agindo como se fosse um membro da equipe CollectTech.`

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
