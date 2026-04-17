CREATE DATABASE trackSense;
USE trackSense;

-- CRIAÇÃO DAS TABELAS --
CREATE TABLE empresa( -- INSERIR DADOS
idEmpresa INT AUTO_INCREMENT PRIMARY KEY ,
cnpj CHAR(14) UNIQUE,
nome VARCHAR(45)
) AUTO_INCREMENT = 1000;

CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
senha CHAR(8) NOT NULL,
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
setor VARCHAR(45),
numMaquina VARCHAR(10),
fkEmpresaMaquina INT,
	CONSTRAINT chFkEmpresaMaquina FOREIGN KEY (fkEmpresaMaquina) REFERENCES empresa(idEmpresa)
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
	-- Funcionaria uma fk composta (idRegistro, fksensor)?
valorRegistro TINYINT (1),
	-- CONSTRAIN chValorRegistro CHECK (valorSensor IN (0,1)),
hrRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
fkSensor INT,
	CONSTRAINT chFkSensor
    FOREIGN KEY (fkSensor)
    REFERENCES sensor (idSensor)
) AUTO_INCREMENT = 1000;


-- EXEMPLO DE INSERÇÃO DE DADOS --
INSERT INTO empresa (cnpj, nome) VALUES
('11122233344455','Quero'),
('11122233344457','Knor'),
('11122233344458','Predilecta');

INSERT INTO usuario (nome, email, senha, fkSupervisor, fkEmpresa)VALUES
('Giovanna Flores', 'giovanna@email.com', 'gi120511', NULL, 1000),
('Nathan Fioravanti', 'nathan@email.com', 'nathan79', NULL, 1000),
('Lucas Espindola', 'lucas@email.com', 'lucas699', 1000, 1002),
('Matheus Profeta', 'matheus@email.com', 'matheus7', 1002, 1002),
('Max Maya', 'max@email.com', 'max45678', 1000, 1001),
('Sara Cheque', 'sara@email.com', 'sara1234', 1003, 1001);

INSERT INTO maquina (setor, numMaquina, fkEmpresaMaquina) VALUES
('Setor 1', 'M01', 1000),
('Setor 2', 'M02', 1000),
('Setor 3', 'M03', 1001);

INSERT INTO sensor (estadoSensor, numSerie, fkMaquina) VALUES
('Ativo','10002000','1000'),
('Inativo','10002001','1001'),
('Manutenção','10002002','1002');

INSERT INTO registroSensor (fkSensor, valorRegistro) VALUES -- arrumar
(1000, 1),
(1001, 1),
(1002, 1);

-- VISUALISAÇÃO DE INFORMAÇÕES -- 
SELECT * FROM empresa;
SELECT * FROM usuario;
SELECT * FROM maquina;
SELECT * FROM sensor;
SELECT * FROM registroSensor; 
    
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
SELECT s.numSerie, rS.hrApontamento, rS.hrRegistro 
FROM sensor AS s
JOIN registroSensor AS rS
WHERE hrApontamento
BETWEEN '2026-04-27 14:00:00' 
AND '2026-04-27 15:00:00'
;
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






