
USE trackSense;

-- CRIAÇÃO DAS TABELAS --
CREATE TABLE endereco (
idEndereco INT AUTO_INCREMENT PRIMARY KEY,
numero CHAR(4),
cep CHAR(8)
) AUTO_INCREMENT = 1000; 

CREATE TABLE empresa( 
idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
cnpj CHAR(14) UNIQUE,
nome VARCHAR(45),
fkMatriz INT,
	CONSTRAINT chFkMatriz
    FOREIGN KEY (fkMatriz)
    REFERENCES empresa(idEmpresa),
fkEndereco INT, 
	CONSTRAINT chFkEndereco 
    FOREIGN KEY (fkEndereco)
    REFERENCES endereco(idEndereco)
) AUTO_INCREMENT = 1000;

CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
senha VARCHAR(14) NOT NULL,
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSupervisor INT, 
	CONSTRAINT chFkSupervisor 
    FOREIGN KEY (fkSupervisor)
    REFERENCES usuario(idUsuario),
fkEmpresa INT,
	CONSTRAINT chFkEmpresa 
    FOREIGN KEY (fkEmpresa) 
    REFERENCES empresa(idEmpresa)
) AUTO_INCREMENT = 1000; 

CREATE TABLE maquina(
idMaquina INT PRIMARY KEY AUTO_INCREMENT,
numMaquina VARCHAR(10),
fkEmpresaMaquina INT,
	CONSTRAINT chFkEmpresaMaquina 
    FOREIGN KEY (fkEmpresaMaquina) 
    REFERENCES empresa(idEmpresa)
)AUTO_INCREMENT = 1000;

CREATE TABLE sensor( 
idSensor INT PRIMARY KEY AUTO_INCREMENT,
estadoSensor VARCHAR(10), 
	CONSTRAINT chEstadoSensor CHECK(estadoSensor IN('Ativo', 'Inativo', 'Manutenção')),
numSerie CHAR(8),
fkMaquina INT,
	CONSTRAINT chFkMaquina FOREIGN KEY (fkMaquina) REFERENCES maquina(idMaquina)
) AUTO_INCREMENT = 1000;

-- tabela sensor e tabela dados do sensor
CREATE TABLE registroSensor(
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
valorRegistro TINYINT,
hrRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
	CONSTRAINT chFkSensor
    FOREIGN KEY (fkSensor)
    REFERENCES sensor (idSensor)
) AUTO_INCREMENT = 1000;

-- EXEMPLO DE INSERÇÃO DE DADOS --
INSERT INTO endereco (numero, cep) VALUES
('1000','09100200'),('1001','09100201'),('1002','09100202'),
('1003','09100203'),('1004','09100204'),('1005','09100205'),
('1006','09100206');

INSERT INTO empresa (cnpj, nome, fkMatriz, fkEndereco) VALUES
('11122233344455','Quero Paulista', NULL, 1000),
('11122233377755','Quero São Bernardo do Campo', 1000, 1001),
('11122288877755','Quero Belo Horizonte', 1000, 1002),
('11122233344457','Knor Poços de Calda', NULL, 1003),
('11122233344476','Knor Rio de Janeiro', 1003, 1004),
('11122233344458','Predilecta Xique-xique', NULL, 1005),
('11199933344458','Predilecta Recife', 1005, 1006);
 
INSERT INTO usuario (nome, email, senha, fkSupervisor, fkEmpresa) VALUES
('Giovanna Flores', 'giovanna@email.com', 'gi120511', NULL, 1000),
('Nathan Fioravanti', 'nathan@email.com', 'nathan79', 1000, 1000),
('Lucas Espindola', 'lucas@email.com', 'lucas699', NULL, 1001),
('Matheus Profeta', 'matheus@email.com', 'matheus7', 1002, 1001),
('Max Maya', 'max@email.com', 'max45678', NULL, 1002),
('Sara Cheque', 'sara@email.com', 'sara1234', 1004, 1002);
 
INSERT INTO maquina (numMaquina, fkEmpresaMaquina) VALUES
('M01', 1000),('M02', 1000),('M03', 1000),('M04', 1000),('M05', 1000),('M06', 1000),('M07', 1000),('M08', 1000),
('M01', 1001),('M02', 1001),('M03', 1001),('M04', 1001),('M05', 1001),('M06', 1001),('M07', 1001),('M08', 1001),
('M01', 1002),('M02', 1002),('M03', 1002),('M04', 1002),('M05', 1002),('M06', 1002),('M07', 1002),('M08', 1002),
('M01', 1003),('M02', 1003),('M03', 1003),('M04', 1003),('M05', 1003),('M06', 1003),('M07', 1003),('M08', 1003),
('M01', 1004),('M02', 1004),('M03', 1004),('M04', 1004),('M05', 1004),('M06', 1004),('M07', 1004),('M08', 1004),
('M01', 1005),('M02', 1005),('M03', 1005),('M04', 1005),('M05', 1005),('M06', 1005),('M07', 1005),('M08', 1005),
('M01', 1006),('M02', 1006),('M03', 1006),('M04', 1006),('M05', 1006),('M06', 1006),('M07', 1006),('M08', 1006);

 
INSERT INTO sensor (estadoSensor, numSerie, fkMaquina) VALUES
-- Empresa 1000 (máquinas 1000 a 1007)
('Ativo', '10002000', 1000),('Ativo', '10002001', 1001),('Ativo', '10002002', 1002),('Ativo', '10002003', 1003),
('Ativo', '10002004', 1004),('Inativo', '10002005', 1005),('Inativo', '10002006', 1006),('Manutenção', '10002007', 1007),
-- Empresa 1001 (máquinas 1008 a 1015)
('Ativo', '10002008', 1008), ('Ativo', '10002009', 1009), ('Ativo', '10002010', 1010), ('Ativo', '10002011', 1011),
('Ativo', '10002012', 1012),('Inativo', '10002013', 1013),('Inativo', '10002014', 1014),('Manutenção', '10002015', 1015),
-- Empresa 1002 (máquinas 1016 a 1023)
('Ativo', '10002016', 1016),('Ativo', '10002017', 1017),('Ativo', '10002018', 1018),('Ativo', '10002019', 1019),
('Ativo', '10002020', 1020),('Inativo', '10002021', 1021),('Inativo', '10002022', 1022),('Manutenção', '10002023', 1023),
-- Empresa 1003 (máquinas 1024 a 1031)
('Ativo',      '10002024', 1024),('Ativo',      '10002025', 1025),('Ativo',      '10002026', 1026),('Ativo',      '10002027', 1027),
('Ativo',      '10002028', 1028),('Inativo',    '10002029', 1029),('Inativo',    '10002030', 1030),('Manutenção', '10002031', 1031),
-- Empresa 1004 (máquinas 1032 a 1039)
('Ativo',      '10002032', 1032),('Ativo',      '10002033', 1033),('Ativo',      '10002034', 1034),('Ativo',      '10002035', 1035),
('Ativo',      '10002036', 1036),('Inativo',    '10002037', 1037),('Inativo',    '10002038', 1038),('Manutenção', '10002039', 1039),
-- Empresa 1005 (máquinas 1040 a 1047)
('Ativo',      '10002040', 1040),('Ativo',      '10002041', 1041),('Ativo',      '10002042', 1042),('Ativo',      '10002043', 1043),
('Ativo',      '10002044', 1044),('Inativo',    '10002045', 1045),('Inativo',    '10002046', 1046),('Manutenção', '10002047', 1047),
-- Empresa 1006 (máquinas 1048 a 1055)
('Ativo',      '10002048', 1048),('Ativo',      '10002049', 1049),('Ativo',      '10002050', 1050),('Ativo',      '10002051', 1051),
('Ativo',      '10002052', 1052),('Inativo',    '10002053', 1053),('Inativo',    '10002054', 1054),('Manutenção', '10002055', 1055);


 -- REGISTROS DO SENSOR 1000 (M01 - Quero Paulista)
-- Produção alta 

-- Registros hoje
INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro) VALUES
(1000, 1, '2026-05-20 08:00:00'),(1000, 1, '2026-05-20 08:01:00'),(1000, 1, '2026-05-20 08:02:00'),(1000, 1, '2026-05-20 08:03:00'),
(1000, 1, '2026-05-20 08:04:00'),(1000, 1, '2026-05-20 08:05:00'),(1000, 1, '2026-05-20 08:06:00'),(1000, 1, '2026-05-20 08:07:00'),
(1000, 1, '2026-05-20 08:08:00'),(1000, 1, '2026-05-20 08:09:00'),(1000, 1, '2026-05-20 09:00:00'),(1000, 1, '2026-05-20 09:01:00'),
(1000, 1, '2026-05-20 09:02:00'),(1000, 1, '2026-05-20 09:03:00'),(1000, 1, '2026-05-20 09:04:00'),(1000, 1, '2026-05-20 10:00:00'),
(1000, 1, '2026-05-20 10:01:00'),(1000, 1, '2026-05-20 10:02:00'),(1000, 1, '2026-05-20 10:03:00'),(1000, 1, '2026-05-20 11:00:00'),
(1000, 1, '2026-05-20 11:01:00'),(1000, 1, '2026-05-20 11:02:00'),(1000, 1, '2026-05-20 12:00:00'),(1000, 1, '2026-05-20 12:01:00'),
(1000, 1, '2026-05-20 13:00:00'),(1000, 1, '2026-05-20 13:01:00'),(1000, 1, '2026-05-20 14:00:00'),(1000, 1, '2026-05-20 14:01:00'),
(1000, 1, '2026-05-20 14:02:00'),(1000, 1, '2026-05-20 14:03:00');
 
-- Registros mensais 2025
INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro) VALUES
-- Janeiro 2025 
(1000, 1, '2025-01-05 08:00:00'),(1000, 1, '2025-01-05 08:01:00'),(1000, 1, '2025-01-05 09:00:00'),
(1000, 1, '2025-01-10 08:00:00'),(1000, 1, '2025-01-10 08:01:00'),(1000, 1, '2025-01-10 09:00:00'),
(1000, 1, '2025-01-15 08:00:00'),(1000, 1, '2025-01-15 08:01:00'),(1000, 1, '2025-01-15 09:00:00'),
(1000, 1, '2025-01-20 08:00:00'),(1000, 1, '2025-01-20 08:01:00'),(1000, 1, '2025-01-20 09:00:00'),
-- Fevereiro 2025
(1000, 1, '2025-02-05 08:00:00'),(1000, 1, '2025-02-05 08:01:00'),(1000, 1, '2025-02-05 09:00:00'),
(1000, 1, '2025-02-10 08:00:00'),(1000, 1, '2025-02-10 08:01:00'),(1000, 1, '2025-02-10 09:00:00'),
(1000, 1, '2025-02-15 08:00:00'),(1000, 1, '2025-02-15 08:01:00'),(1000, 1, '2025-02-15 09:00:00'),
-- Março 2025
(1000, 1, '2025-03-05 08:00:00'),(1000, 1, '2025-03-05 08:01:00'),(1000, 1, '2025-03-05 09:00:00'),
(1000, 1, '2025-03-10 08:00:00'),(1000, 1, '2025-03-10 08:01:00'),(1000, 1, '2025-03-10 09:00:00'),
(1000, 1, '2025-03-15 08:00:00'),(1000, 1, '2025-03-15 08:01:00'),
-- Abril 2025
(1000, 1, '2025-04-05 08:00:00'),(1000, 1, '2025-04-05 08:01:00'),(1000, 1, '2025-04-05 09:00:00'),
(1000, 1, '2025-04-10 08:00:00'),(1000, 1, '2025-04-10 08:01:00'),
-- Maio 2025
(1000, 1, '2025-05-05 08:00:00'),(1000, 1, '2025-05-05 08:01:00'),(1000, 1, '2025-05-05 09:00:00'),
(1000, 1, '2025-05-10 08:00:00'),(1000, 1, '2025-05-10 08:01:00'),(1000, 1, '2025-05-15 08:00:00'),
-- Junho 2025
(1000, 1, '2025-06-05 08:00:00'),(1000, 1, '2025-06-05 08:01:00'),(1000, 1, '2025-06-10 08:00:00'),
(1000, 1, '2025-06-10 08:01:00'),(1000, 1, '2025-06-15 08:00:00');
 
-- Registros mensais 2026 
INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro) VALUES
-- Janeiro 2026 
(1000, 1, '2026-01-05 08:00:00'),(1000, 1, '2026-01-05 08:01:00'),(1000, 1, '2026-01-05 09:00:00'),
(1000, 1, '2026-01-05 09:01:00'),(1000, 1, '2026-01-05 10:00:00'),(1000, 1, '2026-01-10 08:00:00'),
(1000, 1, '2026-01-10 08:01:00'),(1000, 1, '2026-01-10 09:00:00'),(1000, 1, '2026-01-10 09:01:00'),
(1000, 1, '2026-01-15 08:00:00'),(1000, 1, '2026-01-15 08:01:00'),(1000, 1, '2026-01-20 08:00:00'),
(1000, 1, '2026-01-20 08:01:00'),(1000, 1, '2026-01-20 09:00:00'),(1000, 1, '2026-01-25 08:00:00'),
-- Fevereiro 2026
(1000, 1, '2026-02-05 08:00:00'),(1000, 1, '2026-02-05 08:01:00'),(1000, 1, '2026-02-05 09:00:00'),
(1000, 1, '2026-02-10 08:00:00'),(1000, 1, '2026-02-10 08:01:00'),(1000, 1, '2026-02-10 09:00:00'),
(1000, 1, '2026-02-15 08:00:00'),(1000, 1, '2026-02-15 08:01:00'),(1000, 1, '2026-02-20 08:00:00'),
-- Março 2026
(1000, 1, '2026-03-05 08:00:00'),(1000, 1, '2026-03-05 08:01:00'),(1000, 1, '2026-03-05 09:00:00'),
(1000, 1, '2026-03-10 08:00:00'),(1000, 1, '2026-03-10 08:01:00'),(1000, 1, '2026-03-15 08:00:00'),
(1000, 1, '2026-03-15 08:01:00'),(1000, 1, '2026-03-20 08:00:00'),
-- Abril 2026
(1000, 1, '2026-04-05 08:00:00'),(1000, 1, '2026-04-05 08:01:00'),(1000, 1, '2026-04-05 09:00:00'),
(1000, 1, '2026-04-10 08:00:00'),(1000, 1, '2026-04-10 08:01:00'),(1000, 1, '2026-04-15 08:00:00'),
(1000, 1, '2026-04-15 08:01:00'),
-- Maio 2026 
(1000, 1, '2026-05-01 08:00:00'),(1000, 1, '2026-05-01 08:01:00'),(1000, 1, '2026-05-01 09:00:00'),
(1000, 1, '2026-05-05 08:00:00'),(1000, 1, '2026-05-05 08:01:00'),(1000, 1, '2026-05-05 09:00:00'),
(1000, 1, '2026-05-10 08:00:00'),(1000, 1, '2026-05-10 08:01:00'),(1000, 1, '2026-05-15 08:00:00'),
(1000, 1, '2026-05-15 08:01:00'),(1000, 1, '2026-05-15 09:00:00'),(1000, 1, '2026-05-20 08:00:00');
 
-- REGISTROS DO SENSOR 1003 (M01 - Knor)
-- Produção média
INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro) VALUES
(1003, 1, '2026-05-20 08:00:00'),(1003, 1, '2026-05-20 08:02:00'),(1003, 1, '2026-05-20 08:04:00'),(1003, 1, '2026-05-20 08:06:00'),
(1003, 1, '2026-05-20 09:00:00'),(1003, 1, '2026-05-20 09:02:00'),(1003, 1, '2026-05-20 10:00:00'),(1003, 1, '2026-05-20 10:02:00'),
(1003, 1, '2026-05-20 11:00:00'),(1003, 1, '2026-05-20 11:02:00'),(1003, 1, '2026-05-20 12:00:00'),(1003, 1, '2026-05-20 13:00:00'),
(1003, 1, '2026-05-20 14:00:00'),(1003, 1, '2026-01-10 08:00:00'),(1003, 1, '2026-01-15 08:00:00'),(1003, 1, '2026-02-10 08:00:00'),
(1003, 1, '2026-02-15 08:00:00'),(1003, 1, '2026-03-10 08:00:00'),(1003, 1, '2026-04-10 08:00:00'),(1003, 1, '2026-05-10 08:00:00'),
(1003, 1, '2025-01-10 08:00:00'),(1003, 1, '2025-02-10 08:00:00'),(1003, 1, '2025-03-10 08:00:00'),(1003, 1, '2025-04-10 08:00:00'),
(1003, 1, '2025-05-10 08:00:00'),(1003, 1, '2025-06-10 08:00:00');
 
-- REGISTROS DO SENSOR 1005 (Predilecta)
-- Produção baixa
INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro) VALUES
(1005, 1, '2026-05-20 08:00:00'),(1005, 1, '2026-05-20 10:00:00'),(1005, 1, '2026-05-20 14:00:00'),(1005, 1, '2026-01-20 08:00:00'),
(1005, 1, '2026-02-20 08:00:00'),(1005, 1, '2026-03-20 08:00:00'),(1005, 1, '2026-04-20 08:00:00'),(1005, 1, '2025-01-20 08:00:00'),
(1005, 1, '2025-03-20 08:00:00'),(1005, 1, '2025-05-20 08:00:00');
 
-- REGISTROS DO SENSOR 1008 (M02 - Predilecta)
-- Produção normal
INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro) VALUES
(1008, 1, '2026-05-20 08:00:00'),(1008, 1, '2026-05-20 08:01:00'),(1008, 1, '2026-05-20 08:02:00'),(1008, 1, '2026-05-20 09:00:00'),
(1008, 1, '2026-05-20 09:01:00'),(1008, 1, '2026-05-20 10:00:00'),(1008, 1, '2026-05-20 10:01:00'),(1008, 1, '2026-05-20 11:00:00'),
(1008, 1, '2026-05-20 12:00:00'),(1008, 1, '2026-05-20 13:00:00'),(1008, 1, '2026-01-10 08:00:00'),(1008, 1, '2026-01-15 08:00:00'),
(1008, 1, '2026-02-10 08:00:00'),(1008, 1, '2026-03-10 08:00:00'),(1008, 1, '2026-04-10 08:00:00'),(1008, 1, '2026-05-10 08:00:00'),
(1008, 1, '2025-01-10 08:00:00'),(1008, 1, '2025-02-10 08:00:00'),(1008, 1, '2025-04-10 08:00:00'),(1008, 1, '2025-06-10 08:00:00');

-- REGISTROS DO SENSOR 1009 (M01 - Knor RJ)
-- Produção normal-alta
INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro) VALUES
(1009, 1, '2026-05-20 08:00:00'),(1009, 1, '2026-05-20 08:01:00'),(1009, 1, '2026-05-20 08:02:00'),(1009, 1, '2026-05-20 08:03:00'),
(1009, 1, '2026-05-20 09:00:00'),(1009, 1, '2026-05-20 09:01:00'),(1009, 1, '2026-05-20 09:02:00'),(1009, 1, '2026-05-20 10:00:00'),
(1009, 1, '2026-05-20 10:01:00'),(1009, 1, '2026-05-20 11:00:00'),(1009, 1, '2026-05-20 11:01:00'),(1009, 1, '2026-05-20 12:00:00'),
(1009, 1, '2026-05-20 13:00:00'),(1009, 1, '2026-05-20 14:00:00'),(1009, 1, '2026-01-10 08:00:00'),(1009, 1, '2026-01-15 08:00:00'),
(1009, 1, '2026-01-20 08:00:00'),(1009, 1, '2026-02-10 08:00:00'),(1009, 1, '2026-02-15 08:00:00'),(1009, 1, '2026-03-10 08:00:00'),
(1009, 1, '2026-03-15 08:00:00'),(1009, 1, '2026-04-10 08:00:00'),(1009, 1, '2026-04-15 08:00:00'),(1009, 1, '2026-05-10 08:00:00'),
(1009, 1, '2025-01-10 08:00:00'),(1009, 1, '2025-02-10 08:00:00'),(1009, 1, '2025-03-10 08:00:00'),(1009, 1, '2025-04-10 08:00:00'),
(1009, 1, '2025-05-10 08:00:00'),(1009, 1, '2025-06-10 08:00:00');

-- VISUALISAÇÃO DE INFORMAÇÕES -- 
SELECT * FROM endereco;
SELECT * FROM empresa;
SELECT * FROM usuario;
SELECT * FROM maquina;
SELECT * FROM sensor;
SELECT * FROM registroSensor; 

-- INSERT INTO registroSensor (fkSensor, valorRegistro, hrRegistro)
SELECT 
    fkSensor, 
    valorRegistro, 
    DATE_ADD(hrRegistro, INTERVAL FLOOR(RAND() * 59) SECOND)
FROM registroSensor;

-- Empresa + Máquina + Sensor + Registro
SELECT e.nome AS 'Empresa', m.numMaquina AS 'Máquina', 
s.numSerie AS 'Sensor', 
rS.valorRegistro AS 'Registro', rS.hrRegistro AS 'Data/Hora'
FROM registroSensor AS rS 
JOIN sensor AS s 
ON rS.fkSensor = s.idSensor
JOIN maquina AS m
ON s.fkMaquina = m.idMaquina
JOIN empresa AS e
ON m.fkEmpresaMaquina = e.idEmpresa;

-- Buscar registros entre horários; ex: 14H E 15H
SELECT s.numSerie, rS.hrRegistro 
FROM sensor AS s
JOIN registroSensor AS rS
WHERE hrRegistro
BETWEEN '2026-04-27 14:00:00' 
AND '2026-04-27 15:00:00';
-- Empresa + Máquina;
SELECT empresa.nome AS 'Nome da Empresa',numMaquina AS 'Nº da Máquina'  FROM maquina
JOIN empresa on fkEmpresaMaquina = idEmpresa;
-- Máquina + Sensor;
SELECT m.numMaquina, s.numSerie, s.estadoSensor
FROM maquina AS m
JOIN sensor AS s 
ON m.idMaquina = s.fkMaquina;
-- Sensores ativos;
SELECT numSerie FROM sensor WHERE estadoSensor = 'Ativo';
-- Usuários com suas empresas;
SELECT e.nome AS 'Empresa', u.nome AS 'Usuário', u.email AS 'Email'
FROM empresa AS e
JOIN usuario AS u
ON idEmpresa = fkEmpresa;
-- Usuarios com os supervisores 
SELECT u.nome AS 'Funcionário', s.nome AS 'Supervisor'
FROM usuario AS u
LEFT JOIN usuario AS s
ON u.fkSupervisor = s.idUsuario;
-- Empresas com os ceps
SELECT e.nome AS 'Empresa', cep AS 'CEP'
FROM empresa AS e 
JOIN endereco 
ON e.fkEndereco = idEndereco;


-- Quantos registros tem por sensor
SELECT fkSensor, COUNT(*) as total FROM registroSensor GROUP BY fkSensor;

-- Última leitura de cada sensor
SELECT fkSensor, valorRegistro, hrRegistro 
FROM registroSensor 
ORDER BY hrRegistro DESC 
LIMIT 10;

-- Máquinas da empresa 1000
SELECT m.idMaquina, m.numMaquina, s.idSensor, s.estadoSensor
FROM maquina m
JOIN sensor s ON s.fkMaquina = m.idMaquina
WHERE m.fkEmpresaMaquina = 1000;

SELECT m.fkEmpresaMaquina, e.nome, COUNT(*) as total_maquinas
FROM maquina m
JOIN empresa e ON e.idEmpresa = m.fkEmpresaMaquina
GROUP BY m.fkEmpresaMaquina;

-- Adiciona 6 máquinas novas na empresa 1000
SELECT idMaquina, numMaquina FROM maquina WHERE fkEmpresaMaquina = 1000;

