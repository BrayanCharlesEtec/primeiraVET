<?php
include 'config.php';
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sobre - VetCare</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>VetCare</h1>
            <nav>
                <a href="index.php">Início</a>
                <a href="sobre.php" class="active">Sobre</a>
                <?php if(isset($_SESSION['usuario'])): ?>
                    <a href="painel.php">Painel</a>
                    <a href="logout.php">Sair</a>
                <?php else: ?>
                    <a href="login.php">Login</a>
                <?php endif; ?>
            </nav>
        </header>

        <main>
            <section class="about-section">
                <h2>Sobre o VetCare</h2>
                
                <div class="project-info">
                    <h3>Sobre o Projeto</h3>
                    <p>Este sistema faz parte do aprendizado de desenvolvimento web com PHP, HTML e CSS. 
                    O objetivo é criar uma interface visual para um sistema de gestão veterinária que inclui 
                    funcionalidades como login e painel administrativo.</p>
                    
                    <p>Aqui, os desenvolvedores trabalham com:</p>
                    <ul>
                        <li>Estruturação de páginas em HTML</li>
                        <li>Estilização com CSS</li>
                        <li>Organização de múltiplas páginas</li>
                        <li>Design responsivo</li>
                        <li>Integração com backend PHP</li>
                    </ul>
                </div>
                
                <div class="team-info">
                    <h3>Nossa Equipe</h3>
                    <div class="team-members">
                        <div class="member">
                            <h4>Dr. João Silva</h4>
                            <p>Veterinário Chefe</p>
                        </div>
                        <div class="member">
                            <h4>Dra. Maria Santos</h4>
                            <p>Veterinária Especialista</p>
                        </div>
                        <div class="member">
                            <h4>Carlos Oliveira</h4>
                            <p>Assistente Veterinário</p>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <footer>
            <p>&copy; VetCare 2025 - Sistema Veterinário</p>
        </footer>
    </div>
</body>
</html>