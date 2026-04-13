document.addEventListener('DOMContentLoaded', () => {
    const hamburger = document.querySelector('.hamburger-icon');
    const navbarCelular = document.querySelector('.navbar-celular'); // Nome corrigido
    const fecharIcon = document.querySelector('.fechar');

    // Função para abrir/fechar
    if (hamburger && navbarCelular) {
        hamburger.addEventListener('click', () => {
            navbarCelular.classList.add('open');
        });

        fecharIcon.addEventListener('click', () => {
            navbarCelular.classList.remove('open');
        });

        // Fechar ao clicar fora do menu
        document.addEventListener('click', (event) => {
            if (navbarCelular.classList.contains('open')) {
                if (!navbarCelular.contains(event.target) && !hamburger.contains(event.target)) {
                    navbarCelular.classList.remove('open');
                }
            }
        });
    }
});

