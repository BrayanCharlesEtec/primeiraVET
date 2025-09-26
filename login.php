<?php
include 'config.php';

// Redirecionar se já estiver logado
if(isset($_SESSION['usuario'])) {
    header('Location: painel.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - VetCare</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>VetCare</h1>
            <nav>
                <a href="index.php">Início</a>
                <a href="sobre.php">Sobre</a>
                <a href="login.php" class="active">Login</a>
            </nav>
        </header>

        <main>
            <section class="login-section">
                <h2>Login</h2>
                
                <?php if(isset($_GET['erro'])): ?>
                    <div class="error-message">
                        <?php 
                        if($_GET['erro'] == 1) echo "Usuário ou senha incorretos!";
                        if($_GET['erro'] == 2) echo "Preencha todos os campos!";
                        ?>
                    </div>
                <?php endif; ?>
                
                <form action="autenticar.php" method="POST">
                    <div class="form-group">
                        <label for="usuario">Usuário:</label>
                        <input type="text" id="usuario" name="usuario" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="senha">Senha:</label>
                        <input type="password" id="senha" name="senha" required>
                    </div>
                    
                    <button type="submit" class="btn-login">Entrar</button>
                </form>
                
                <p class="register-link">Não tem conta? <a href="#">Solicitar acesso</a></p>
            </section>
        </main>

        <footer>
            <p>&copy; VetCare 2025 - Sistema Veterinário</p>
        </footer>
    </div>
</body>
</html>