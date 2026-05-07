function exibirResultado() {
        let habitantes = Number(ipt_habitantes.value)
        console.log("recebe habitantes")

        let caminhao = Number(ipt_caminhao.value)
        console.log("recebe caminhao")

        div_mensagem.innerHTML = "";

        // 120km (qtd media que o caminhão roda) / 2,5(quantos km o caminhão roda por litro) = 48 litros
        //  * R$ 6,00 (valor medio do combustivel) = R$288,00  (diarios de combustivel)
        // 288 * 7 (dias da semana) = 2016

        let combustivel = (2016 * caminhao) * 0.20 // 20% de combustiveis desperdiçado por ma gestão das rotas
        console.log(combustivel)

        //LIXO NÃO COLETADO POR MÁ GESTÃO DE ROTA
        let prejuizoinicial = ((((habitantes) * 0.20) / 10000) * 2016)

        //PREJUÍZO DE MÁ GESTÃO + 15% DE GASTOS ADMINISTRATIVOS (EX: FUNCIONÁRIOS, DESGASTE DE PEÇAS, ETC.)
        let prejuizofinal = prejuizoinicial + (prejuizoinicial * 0.15)

        // COMBUSTÍVEL + MÁ GESTÃO + GASTOS ADMINISTRATIVOS
        let prejuizototal = combustivel + prejuizofinal;

        //PREJUÍZO MENSAL 
        let prejuizomensal = prejuizofinal * 4;
        console.log(prejuizomensal)

        //PREJUÍZO ANUAL
        let prejuizoanual = prejuizomensal * 12;
        console.log(prejuizoanual)

        div_mensagem.innerHTML = `<div id="mensagem_combustivel">
                    <h4>Perda de combustível:</h4>
                    <span>R$${combustivel.toFixed(2)}</span>
                </div>
                <div id="mensagem_lixo">
                    <h4>Perda do lixo não coletado:</h4>
                    <span>R$${prejuizofinal.toFixed(2)}</span>
                </div>
                <div id="mensagem_anual">
                    <h4>Perda anual:</h4>
                    <span>R$${prejuizoanual.toFixed(2)}</span>
                </div>`;
    }

    function comoFunciona() {

        informacao_span.innerHTML = `<span>O cálculo do simulador foi desenvolvido para estimar os prejuízos financeiros causados pela má
                        gestão de rotas na coleta de lixo. A análise considera dois fatores principais: desperdício de
                        combustível e lixo não recolhido.
                    </span>

                    <span>Primeiramente, é calculado o custo semanal de combustível de cada caminhão. Para isso,
                        considera-se
                        que um caminhão percorre em média 120 km por dia e faz 2,5 km por litro de combustível,
                        resultando
                        em um consumo médio de 48 litros diários. Multiplicando esse valor pelo preço médio do
                        combustível
                        (R$6,00), obtém-se um gasto diário de R$288,00. Em uma semana, esse custo chega a R$2.016,00 por
                        caminhão. A partir disso, estima-se que 20% desse valor seja desperdiçado devido a rotas
                        ineficientes.
                    </span>

                    <span>Em seguida, o sistema calcula o impacto do lixo não coletado. Considera-se que 20% da
                        população
                        atendida pode ser afetada por falhas de rota. Esse volume é convertido em uma estimativa de
                        caminhões adicionais necessários para suprir a demanda, tomando como base a capacidade média de
                        10
                        toneladas por caminhão. Sobre esse custo operacional, ainda são adicionados 15% referentes a
                        despesas administrativas, como mão de obra, manutenção de peças e custos extras.
                    </span>

                    <span>Por fim, o simulador soma o prejuízo com combustível desperdiçado e o custo gerado pelo lixo
                        não
                        recolhido, apresentando o valor total estimado. Além do resultado semanal, também são exibidas
                        projeções mensais e anuais, permitindo visualizar o impacto financeiro acumulado da má gestão
                        logística.
                    </span>`
    }