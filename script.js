document.addEventListener('DOMContentLoaded', function() {
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');
    
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
        });
    }
    
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            if (navMenu) {
                navMenu.classList.remove('active');
            }
        });
    });
    
    const actionButtons = document.querySelectorAll('.btn-action');
    actionButtons.forEach(button => {
        button.addEventListener('click', function() {
            const acao = this.textContent.trim();
            let mensagem = '';
            
            switch(acao) {
                case 'Nova Consulta':
                    mensagem = 'Redirecionando para agendamento de consulta...';
                    break;
                case 'Cadastrar Paciente':
                    mensagem = 'Abrindo formulário de cadastro...';
                    break;
                case 'Registrar Medicamento':
                    mensagem = 'Acessando controle de medicamentos...';
                    break;
                case 'Gerar Relatório':
                    mensagem = 'Preparando relatórios...';
                    break;
                default:
                    mensagem = 'Funcionalidade em desenvolvimento';
            }
            
            alert(mensagem);
        });
    });
    
    const heroTitle = document.querySelector('.hero-title');
    if (heroTitle) {
        const text = heroTitle.textContent;
        heroTitle.textContent = '';
        let i = 0;
        
        function typeWriter() {
            if (i < text.length) {
                heroTitle.textContent += text.charAt(i);
                i++;
                setTimeout(typeWriter, 100);
            }
        }
        
        setTimeout(typeWriter, 1000);
    }
});