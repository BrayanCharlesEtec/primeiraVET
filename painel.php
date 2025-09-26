<?php
include 'config.php';

// Redirecionar se não estiver logado
if(!isset($_SESSION['usuario'])) {
    header('Location: login.php');
    exit;
}

// Obter estatísticas do dashboard
$estatisticas = obterEstatisticas($pdo);

// Obter consultas agendadas para hoje
$sql_consultas_hoje = "SELECT c.*, p.nome as paciente_nome, cl.nome as cliente_nome 
                       FROM consultas c 
                       JOIN pacientes p ON c.paciente_id = p.id 
                       JOIN clientes cl ON p.cliente_id = cl.id 
                       WHERE DATE(c.data_consulta) = CURDATE() 
                       AND c.status = 'agendada' 
                       ORDER BY c.data_consulta 
                       LIMIT 5";
$consultas_hoje = $pdo->query($sql_consultas_hoje)->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel - VetCare</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>VetCare</h1>
            <nav>
                <a href="index.php">Início</a>
                <a href="sobre.php">Sobre</a>
                <a href="painel.php" class="active">Painel</a>
                <a href="logout.php">Sair</a>
            </nav>
        </header>

        <main>
            <section class="dashboard-section">
                <h2>Bem-vindo, <?php echo $_SESSION['nome']; ?>!</h2>
                <p>Você está logado como <?php echo $_SESSION['tipo']; ?>. Esta é a tela do painel do usuário.</p>
                
                <div class="dashboard-grid">
                    <div class="dashboard-card">
                        <h3>Resumo da Clínica</h3>
                        <ul>
                            <li>Consultas agendadas hoje: <?php echo $estatisticas['consultas_hoje']; ?></li>
                            <li>Pacientes internados: <?php echo $estatisticas['internados']; ?></li>
                            <li>Vacinações pendentes: <?php echo $estatisticas['vacinacoes_pendentes']; ?></li>
                            <li>Total de clientes: <?php echo $estatisticas['total_clientes']; ?></li>
                            <li>Total de pacientes: <?php echo $estatisticas['total_pacientes']; ?></li>
                        </ul>
                    </div>
                    
                    <div class="dashboard-card">
                        <h3>Configurações</h3>
                        <ul>
                            <li><a href="#">Editar Perfil</a></li>
                            <li><a href="#">Alterar Senha</a></li>
                            <li><a href="#">Preferências do Sistema</a></li>
                        </ul>
                    </div>
                    
                    <div class="dashboard-card">
                        <h3>Consultas de Hoje</h3>
                        <?php if(count($consultas_hoje) > 0): ?>
                            <ul>
                                <?php foreach($consultas_hoje as $consulta): ?>
                                    <li>
                                        <strong><?php echo date('H:i', strtotime($consulta['data_consulta'])); ?></strong> - 
                                        <?php echo $consulta['paciente_nome']; ?> (<?php echo $consulta['cliente_nome']; ?>)
                                    </li>
                                <?php endforeach; ?>
                            </ul>
                        <?php else: ?>
                            <p>Nenhuma consulta agendada para hoje.</p>
                        <?php endif; ?>
                    </div>
                    
                    <div class="dashboard-card">
                        <h3>Menu Rápido</h3>
                        <ul>
                            <li><a href="#">Cadastrar Novo Cliente</a></li>
                            <li><a href="#">Agendar Consulta</a></li>
                            <li><a href="#">Registrar Vacinação</a></li>
                            <li><a href="#">Emitir Relatório</a></li>
                        </ul>
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