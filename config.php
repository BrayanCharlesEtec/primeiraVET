<?php
// Configurações do banco de dados
$host = 'localhost';
$dbname = 'veterinaria_db';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Erro na conexão: " . $e->getMessage());
}

// Inicializar sessão
session_start();

// Função para verificar login
function verificarLogin($pdo, $usuario, $senha) {
    $sql = "SELECT * FROM usuarios WHERE usuario = :usuario AND ativo = TRUE";
    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':usuario', $usuario);
    $stmt->execute();
    
    $usuario_db = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($usuario_db && password_verify($senha, $usuario_db['senha'])) {
        return $usuario_db;
    }
    
    return false;
}

// Função para obter estatísticas do dashboard
function obterEstatisticas($pdo) {
    $estatisticas = [];
    
    // Total de clientes
    $sql = "SELECT COUNT(*) as total FROM clientes";
    $stmt = $pdo->query($sql);
    $estatisticas['total_clientes'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Total de pacientes
    $sql = "SELECT COUNT(*) as total FROM pacientes";
    $stmt = $pdo->query($sql);
    $estatisticas['total_pacientes'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Consultas agendadas para hoje
    $sql = "SELECT COUNT(*) as total FROM consultas WHERE DATE(data_consulta) = CURDATE() AND status = 'agendada'";
    $stmt = $pdo->query($sql);
    $estatisticas['consultas_hoje'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Pacientes internados
    $sql = "SELECT COUNT(*) as total FROM internacoes WHERE status = 'internado'";
    $stmt = $pdo->query($sql);
    $estatisticas['internados'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Vacinações pendentes (próximas 7 dias)
    $sql = "SELECT COUNT(*) as total FROM vacinacoes WHERE proxima_dose BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)";
    $stmt = $pdo->query($sql);
    $estatisticas['vacinacoes_pendentes'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    return $estatisticas;
}
?>