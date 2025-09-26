-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS veterinaria_db;
USE veterinaria_db;

-- Tabela de usuários (veterinários e funcionários)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    tipo ENUM('admin', 'veterinario', 'assistente') DEFAULT 'veterinario',
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de clientes (donos dos animais)
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    cpf VARCHAR(14) UNIQUE,
    endereco TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de espécies de animais
CREATE TABLE especies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT
);

-- Tabela de raças
CREATE TABLE racas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    especie_id INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT,
    FOREIGN KEY (especie_id) REFERENCES especies(id) ON DELETE CASCADE
);

-- Tabela de pacientes (animais)
CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    especie_id INT NOT NULL,
    raca_id INT,
    data_nascimento DATE,
    peso DECIMAL(5,2),
    sexo ENUM('M', 'F'),
    pelagem VARCHAR(50),
    observacoes TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,
    FOREIGN KEY (especie_id) REFERENCES especies(id),
    FOREIGN KEY (raca_id) REFERENCES racas(id)
);

-- Tabela de consultas
CREATE TABLE consultas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    veterinario_id INT NOT NULL,
    data_consulta DATETIME NOT NULL,
    tipo_consulta ENUM('rotina', 'emergencia', 'retorno', 'vacina', 'cirurgia') DEFAULT 'rotina',
    sintomas TEXT,
    diagnostico TEXT,
    tratamento TEXT,
    observacoes TEXT,
    status ENUM('agendada', 'realizada', 'cancelada') DEFAULT 'agendada',
    valor DECIMAL(10,2) DEFAULT 0,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (veterinario_id) REFERENCES usuarios(id)
);

-- Tabela de vacinas
CREATE TABLE vacinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    dose_recomendada VARCHAR(50),
    intervalo_semanas INT,
    valido_ate DATE
);

-- Tabela de vacinações
CREATE TABLE vacinacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    vacina_id INT NOT NULL,
    veterinario_id INT NOT NULL,
    data_vacinacao DATE NOT NULL,
    dose VARCHAR(50),
    lote VARCHAR(50),
    proxima_dose DATE,
    observacoes TEXT,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (vacina_id) REFERENCES vacinas(id),
    FOREIGN KEY (veterinario_id) REFERENCES usuarios(id)
);

-- Tabela de procedimentos
CREATE TABLE procedimentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    valor_base DECIMAL(10,2) DEFAULT 0
);

-- Tabela de procedimentos realizados
CREATE TABLE procedimentos_realizados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT NOT NULL,
    procedimento_id INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (consulta_id) REFERENCES consultas(id) ON DELETE CASCADE,
    FOREIGN KEY (procedimento_id) REFERENCES procedimentos(id)
);

-- Tabela de medicamentos
CREATE TABLE medicamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100),
    concentracao VARCHAR(50),
    forma_farmaceutica VARCHAR(50),
    estoque_atual INT DEFAULT 0,
    estoque_minimo INT DEFAULT 5
);

-- Tabela de prescricoes
CREATE TABLE prescricoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT NOT NULL,
    medicamento_id INT NOT NULL,
    dosagem VARCHAR(100),
    frequencia VARCHAR(50),
    duracao_dias INT,
    observacoes TEXT,
    FOREIGN KEY (consulta_id) REFERENCES consultas(id) ON DELETE CASCADE,
    FOREIGN KEY (medicamento_id) REFERENCES medicamentos(id)
);

-- Tabela de internações
CREATE TABLE internacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    veterinario_id INT NOT NULL,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME,
    motivo TEXT,
    diagnostico TEXT,
    tratamento TEXT,
    observacoes TEXT,
    status ENUM('internado', 'alta', 'obito') DEFAULT 'internado',
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (veterinario_id) REFERENCES usuarios(id)
);

-- Tabela de pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT,
    valor DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM('dinheiro', 'cartao_credito', 'cartao_debito', 'pix') DEFAULT 'dinheiro',
    status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
    data_pagamento TIMESTAMP NULL,
    data_vencimento DATE,
    FOREIGN KEY (consulta_id) REFERENCES consultas(id) ON DELETE SET NULL
);

-- Inserir dados iniciais

-- Inserir espécies
INSERT INTO especies (nome, descricao) VALUES 
('Cão', 'Animal doméstico da família Canidae'),
('Gato', 'Animal doméstico da família Felidae'),
('Ave', 'Pássaros e aves domésticas'),
('Roedor', 'Hamsters, porquinhos-da-índia, etc.');

-- Inserir raças para cães
INSERT INTO racas (especie_id, nome, descricao) VALUES 
(1, 'Labrador Retriever', 'Raça de porte médio/grande, muito amigável'),
(1, 'Golden Retriever', 'Raça de porte médio/grande, pelagem dourada'),
(1, 'Bulldog Francês', 'Raça de porte pequeno, orelhas de morcego'),
(1, 'Poodle', 'Raça inteligente, disponível em vários tamanhos'),
(1, 'Vira-lata', 'Sem raça definida');

-- Inserir raças para gatos
INSERT INTO racas (especie_id, nome, descricao) VALUES 
(2, 'Siamês', 'Gato de pelagem clara com extremidades escuras'),
(2, 'Persa', 'Gato de pelagem longa e focinho achatado'),
(2, 'Maine Coon', 'Raça de gato grande e peluda'),
(2, 'SRD', 'Sem Raça Definida');

-- Inserir usuários iniciais
INSERT INTO usuarios (usuario, senha, nome, email, tipo, telefone) VALUES 
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador do Sistema', 'admin@vetcare.com', 'admin', '(11) 9999-8888'),
('vetjoao', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dr. João Silva', 'joao@vetcare.com', 'veterinario', '(11) 9777-6666'),
('vetmaria', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dra. Maria Santos', 'maria@vetcare.com', 'veterinario', '(11) 9555-4444'),
('assistente', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Carlos Oliveira', 'carlos@vetcare.com', 'assistente', '(11) 9333-2222');

-- Inserir vacinas
INSERT INTO vacinas (nome, descricao, dose_recomendada, intervalo_semanas) VALUES 
('V8/V10', 'Vacina múltipla para cães (cinomose, parvovirose, etc.)', '1 mL', 4),
('V4', 'Vacina múltipla para gatos (panleucopenia, rinotraqueíte, etc.)', '1 mL', 4),
('Antirrábica', 'Vacina contra raiva', '1 mL', 52),
('Giárdia', 'Vacina contra giárdia', '1 mL', 4),
('Leishmaniose', 'Vacina contra leishmaniose visceral', '1 mL', 4);

-- Inserir procedimentos
INSERT INTO procedimentos (nome, descricao, valor_base) VALUES 
('Consulta de rotina', 'Consulta veterinária básica', 120.00),
('Consulta de emergência', 'Consulta de urgência', 250.00),
('Vacinação', 'Aplicação de vacina', 80.00),
('Banho e tosa', 'Banho, tosa higiênica e corte de unhas', 80.00),
('Exame de sangue', 'Hemograma completo', 150.00),
('Ultrassonografia', 'Exame de imagem por ultrassom', 300.00),
('Cirurgia de castração', 'Procedimento cirúrgico para castração', 500.00);

-- Inserir medicamentos
INSERT INTO medicamentos (nome, principio_ativo, concentracao, forma_farmaceutica, estoque_atual, estoque_minimo) VALUES 
('Antipulgas Simparic', 'Sarolaner', '20 mg', 'Comprimido', 50, 10),
('Vermífugo Drontal', 'Praziquantel + Pirantel', '50 mg + 144 mg', 'Comprimido', 30, 5),
('Anti-inflamatório Meloxicam', 'Meloxicam', '1,5 mg/mL', 'Solução oral', 25, 5),
('Antibiótico Amoxicilina', 'Amoxicilina', '50 mg/mL', 'Suspensão oral', 40, 8),
('Analgésico Carprofeno', 'Carprofeno', '20 mg', 'Comprimido', 35, 7);

-- Inserir alguns clientes de exemplo
INSERT INTO clientes (nome, email, telefone, cpf, endereco) VALUES 
('Ana Paula Oliveira', 'ana.oliveira@email.com', '(11) 9888-7777', '123.456.789-00', 'Rua das Flores, 123 - São Paulo/SP'),
('Roberto Santos', 'roberto.santos@email.com', '(11) 9777-6666', '234.567.890-11', 'Av. Paulista, 1000 - São Paulo/SP'),
('Carla Mendes', 'carla.mendes@email.com', '(11) 9666-5555', '345.678.901-22', 'Rua Augusta, 500 - São Paulo/SP');

-- Inserir pacientes (animais) de exemplo
INSERT INTO pacientes (cliente_id, nome, especie_id, raca_id, data_nascimento, peso, sexo, pelagem) VALUES 
(1, 'Rex', 1, 1, '2020-05-15', 28.5, 'M', 'Dourado'),
(1, 'Luna', 2, 4, '2021-08-20', 4.2, 'F', 'Cinza'),
(2, 'Thor', 1, 5, '2019-03-10', 22.0, 'M', 'Preto'),
(3, 'Mel', 2, 2, '2022-01-30', 3.8, 'F', 'Branco');

-- Inserir consultas de exemplo
INSERT INTO consultas (paciente_id, veterinario_id, data_consulta, tipo_consulta, sintomas, diagnostico, tratamento, status, valor) VALUES 
(1, 2, '2025-01-15 10:00:00', 'rotina', 'Check-up anual', 'Saudável', 'Vacinação V10 e antirrábica', 'realizada', 200.00),
(2, 3, '2025-01-16 14:30:00', 'rotina', 'Consulta de rotina', 'Saudável', 'Vacinação V4', 'realizada', 180.00),
(3, 2, '2025-01-20 09:00:00', 'emergencia', 'Vômito e diarreia', 'Gastroenterite', 'Dieta leve e medicação', 'realizada', 300.00),
(4, 3, '2025-01-25 11:00:00', 'vacina', 'Vacinação anual', 'Saudável', 'Vacinação V4 e antirrábica', 'agendada', 160.00);

-- Inserir vacinações de exemplo
INSERT INTO vacinacoes (paciente_id, vacina_id, veterinario_id, data_vacinacao, dose, proxima_dose) VALUES 
(1, 1, 2, '2025-01-15', '1 mL', '2025-02-12'),
(1, 3, 2, '2025-01-15', '1 mL', '2026-01-15'),
(2, 2, 3, '2025-01-16', '1 mL', '2025-02-13'),
(2, 3, 3, '2025-01-16', '1 mL', '2026-01-16');

-- Inserir pagamentos de exemplo
INSERT INTO pagamentos (consulta_id, valor, forma_pagamento, status, data_pagamento) VALUES 
(1, 200.00, 'cartao_credito', 'pago', '2025-01-15 10:30:00'),
(2, 180.00, 'pix', 'pago', '2025-01-16 15:00:00'),
(3, 300.00, 'dinheiro', 'pendente', NULL);