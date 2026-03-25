CREATE DATABASE trackSense;
USE trackSense;

-- CRIAÇÃO DAS TABELAS --

CREATE TABLE empresa( -- INSERIR DADOS
idEmpresa INT AUTO_INCREMENT PRIMARY KEY ,
cnpj CHAR(14) UNIQUE ,
nome VARCHAR(45),
telefone CHAR(13) 
) AUTO_INCREMENT = 1000;

CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
senha CHAR(8) NOT NULL,
nivelAcesso VARCHAR(10) NOT NULL,
CONSTRAINT chk_acesso CHECK(nivelAcesso IN ('Admin', 'Operador', 'Supervisor')), -- pq operador pode ver essa coisa
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
fkEmpresa INT,
	CONSTRAINT chFkEmpresa 
    FOREIGN KEY (fkEmpresa) 
    REFERENCES empresa(idEmpresa)
) AUTO_INCREMENT = 1000; 

CREATE TABLE sensor( -- INSERIR DADOS
idSensor INT PRIMARY KEY AUTO_INCREMENT,
estadoSensor VARCHAR(10), 
	CONSTRAINT chEstadoSensor CHECK(estadoSensor IN('Ativo', 'Inativo', 'Manutenção')),
numSerie CHAR(8)
) AUTO_INCREMENT = 1000;

-- tabela sensor e tabela dados do sensor
CREATE TABLE registroSensor(
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
hrApontamento DATETIME DEFAULT CURRENT_TIMESTAMP,
hrRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
	CONSTRAINT chFkSensor
    FOREIGN KEY (fkSensor)
    REFERENCES sensor (idSensor)
) AUTO_INCREMENT = 1000;

CREATE TABLE ocorrencia(
idOcorrencia INT PRIMARY KEY AUTO_INCREMENT,
fkSensorOcorrencia INT,
	CONSTRAINT chFkSensorOcorrencia 
    FOREIGN KEY (fkSensorOcorrencia) 
    REFERENCES sensor (idSensor),
motivo VARCHAR(300) NOT NULL,
dtOcorrencia DATETIME NOT NULL,
fkUsuarioOcorrencia INT,
	CONSTRAINT chFkUsuarioOcorrencia 
    FOREIGN KEY (fkUsuarioOcorrencia) 
    REFERENCES usuario (idUsuario)
-- numSerie CHAR(8) pode usar para ligar na fkSensor?
)AUTO_INCREMENT = 1000;

-- EXEMPLO DE INSERÇÃO DE DADOS --
INSERT INTO empresa (cnpj, nome,telefone) VALUES
('11122233344455','Quero','5511900000000'),
('11122233344457','Knor','5511900000002'),
('11122233344458','Predileta','5511900000003');

SELECT * FROM empresa;
INSERT INTO usuario (nome, email, senha, nivelAcesso, fkEmpresa) VALUES
('Giovanna Flores', 'giovanna@email.com', 'gi120511', 'Operador', 1000),
('Lucas Espindola', 'lucas@email.com', 'lucas699', 'Supervisor', 1001),
('Matheus Profeta', 'matheus@email.com', 'matheus7', 'Admin', 1002),
('Max Maya', 'max@email.com', 'max45678', 'Supervisor', 1001),
('Nathan Fioravanti', 'nathan@email.com', 'nathan79', 'Supervisor', 1000),
('Sara Cheque', 'sara@email.com', 'sara1234', 'Operador', 1001);

INSERT INTO sensor (estadoSensor, numSerie) VALUES
('Ativo','10002000'),
('Inativo','10002001'),
('Manutenção','10002002');

INSERT INTO registroSensor (fkSensor) VALUES -- arrumar
(1000),
(1001),
(1002)
;

INSERT INTO ocorrencia (motivo, dtOcorrencia, fkSensorOcorrencia, fkUsuarioOcorrencia) VALUES
('Falha na leitura do sensor de contagem', '2026-02-25 08:30:00', 1000, 1012),
('Sensor desligado para manutenção', '2026-02-25 10:15:00', 1001, 1013),
('Oscilação detectada no equipamento', '2026-02-26 14:40:00', 1002, 1014),
('Oscilação detectada no equipamento', '2026-02-26 14:40:00', 1001, 1017),
('Oscilação detectada no equipamento', '2026-02-26 14:40:00', 1002, 1016),
('Erro de comunicação com o sistema', '2026-02-27 09:20:00', 1000, 1015);


-- VISUALISAÇÃO DE INFORMAÇÕES -- 

SELECT * FROM usuario;
SELECT * FROM registroSensor;
SELECT * FROM ocorrencia;
SELECT * FROM empresa;
SELECT * FROM sensor;

-- Verificando qual o nivel de acesso dos usuarios 
SELECT nome AS Nome, nivelAcesso AS 'Nivel de Acesso' FROM usuario;

-- VERIFICANDO OS REGISTROS ENTRE 14H E 15H
SELECT numSerie, hrApontamento, hrRegistro FROM registroSensor 
WHERE hrApontamento
BETWEEN '2026-02-26 14:00:00' 
AND '2026-02-26 15:00:00';

-- 
SELECT empresa.nome, sensor.numSerie, hrApontamento, hrRegistro FROM empresa 
    JOIN usuario ON idEmpresa = fkEmpresa
	JOIN ocorrencia ON idUsuario = fkUsuarioOcorrencia
    JOIN sensor ON idSensor = fkSensorOcorrencia
    JOIN registroSensor ON idSensor = fkSensor;

-- Verificando os motivos das ocorrencias de parada entre as 9h e as 11h
SELECT nomeUsuario AS NOME, motivo AS Motivo, dtOcorrencia AS 'Data e Hora' FROM usuario
	JOIN usuario ON idEmpresa = fkEmpresa
	JOIN ocorrencia ON idUsuario = fkUsuarioOcorrencia
    JOIN sensor ON idSensor = fkSensorOcorrencia;

-- SELCIONAR OCORRENCIAS
SELECT empresa.nome AS 'Empresa', usuario.nome AS 'Usuário', nivelAcesso 'Nível de Acesso', motivo AS 'Ocorrência', numSerie AS 'Número de Série', dtOcorrencia AS 'Data de Ocorrência'  FROM empresa
	JOIN usuario ON idEmpresa = fkEmpresa
	JOIN ocorrencia ON idUsuario = fkUsuarioOcorrencia
    JOIN sensor ON idSensor = fkSensorOcorrencia;

SELECT usuario.*,ocorrencia.* FROM usuario
	JOIN ocorrencia ON idUsuario = fkUsuarioOcorrencia;



