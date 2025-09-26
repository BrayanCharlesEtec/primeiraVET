<?php
include 'config.php';

if($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usuario = $_POST['usuario'] ?? '';
    $senha = $_POST['senha'] ?? '';
    
    // Verificar se os campos estão preenchidos
    if(empty($usuario) || empty($senha)) {
        header('Location: login.php?erro=2');
        exit;
    }
    
    // Verificar credenciais no banco de dados
    $usuario_db = verificarLogin($pdo, $usuario, $senha);
    
    if($usuario_db) {
        // Login bem-sucedido
        $_SESSION['usuario'] = $usuario_db['usuario'];
        $_SESSION['nome'] = $usuario_db['nome'];
        $_SESSION['tipo'] = $usuario_db['tipo'];
        $_SESSION['user_id'] = $usuario_db['id'];
        
        header('Location: painel.php');
        exit;
    } else {
        // Login falhou
        header('Location: login.php?erro=1');
        exit;
    }
} else {
    header('Location: login.php');
    exit;
}
?>