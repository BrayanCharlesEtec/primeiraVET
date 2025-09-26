<?php
require_once 'config.php';

try {
    $pdo = new PDO("mysql:host=" . DB_HOST, DB_USER, DB_PASS);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    $sql = file_get_contents('database.sql');
    
    $pdo->exec($sql);
    
    echo "<h1>Instalação concluída com sucesso!</h1>";
    echo "<p>Banco de dados 'petcare' criado e populado com dados de exemplo.</p>";
    echo "<p><a href='index.php'>Ir para o sistema</a></p>";
    
} catch(PDOException $e) {
    echo "<h1>Erro na instalação:</h1>";
    echo "<p>" . $e->getMessage() . "</p>";
}
?>
<link rel="stylesheet" href="styles.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">