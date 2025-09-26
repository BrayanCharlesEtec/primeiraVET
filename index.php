<?php
include 'config.php';
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VetCare - Sistema Veterinário</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>VetCare</h1>
            <nav>
                <a href="index.php" class="active">Início</a>
                <a href="sobre.php">Sobre</a>
                <?php if(isset($_SESSION['usuario'])): ?>
                    <a href="painel.php">Painel</a>
                    <a href="logout.php">Sair</a>
                <?php else: ?>
                    <a href="login.php">Login</a>
                <?php endif; ?>
            </nav>
        </header>

        <main>
            <section class="welcome-section">
                <h2>Bem-vindo ao VetCare</h2>
                <p>Este é um sistema veterinário desenvolvido em PHP com HTML e CSS. 
                O objetivo é criar uma interface visual atrativa e funcional para gerenciamento de uma clínica veterinária.</p>
                
                <div class="features">
                    <h3>Recursos do sistema</h3>
                    <ul>
                        <li>Menu simples e intuitivo</li>
                        <li>Sistema de login seguro</li>
                        <li>Layout responsivo</li>
                        <li>Painel administrativo</li>
                    </ul>
                </div>
                
                <a href="login.php" class="btn-login">Fazer Login</a>
            </section>
        </main>

        <footer>
            <p>&copy; VetCare 2025 - Sistema Veterinário</p>
        </footer>
    </div>
</body>
</html>