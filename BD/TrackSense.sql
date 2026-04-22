
USE trackSense;

-- CRIAÇÃO DAS TABELAS --
CREATE TABLE endereco (
idEndereco INT AUTO_INCREMENT PRIMARY KEY ,
estado CHAR(2),
cidade VARCHAR(45),
bairro VARCHAR(45),
rua VARCHAR(45),
numero CHAR(4),
cep CHAR(8)
) AUTO_INCREMENT = 1000; 

CREATE TABLE empresa( 
idEmpresa INT AUTO_INCREMENT PRIMARY KEY ,
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
INSERT INTO endereco (estado, cidade, bairro, rua, numero, cep) VALUES
('SP','São Paulo','Bela Vista','Avenida Paulista','1000','09100200'),
('SP','São Bernardo do Campo','Nova Petrópolis','Rua Giovanne Pinheiro','1001','09100201'),
('MG','Belo Horizonte','Tiradentes','Rua Carlos Alberto','1002','09100202'),
('MG','Poços de Calda','Jardim Vergueiro','Rua Roberto Magalhães','1003','09100203'),
('RJ','Rio de Janeiro','Vila da Penha','Rua Severino Araújo de Lima','1004','09100204'),
('BA','Xique-Xique','Cidade das Flores','Rua Bartolomeu de Gusmão','1005','09100205'),
('PE','Recife','Boa Viagem','Avenida Litoral','1006','09100206');

INSERT INTO empresa (cnpj, nome, fkMatriz, fkEndereco) VALUES
('11122233344455','Quero Paulista', NULL, 1000),
('11122233377755','Quero São Bernardo do Campo', 1000, 1001),
('11122288877755','Quero Belo Horizonte', 1000, 1002),
('11122233344457','Knor Poços de Calda', NULL, 1003),
('11122233344476','Knor Rio de Janeiro', 1003, 1004),
('11122233344458','Predilecta Xique-xique', NULL, 1005),
('11199933344458','Predilecta Recife', 1005, 1006);

INSERT INTO usuario (nome, email, senha, fkSupervisor, fkEmpresa)VALUES
('Giovanna Flores', 'giovanna@email.com', 'gi120511', NULL, 1000),
('Nathan Fioravanti', 'nathan@email.com', 'nathan79', 1000, 1000),
('Lucas Espindola', 'lucas@email.com', 'lucas699', NULL, 1001),
('Matheus Profeta', 'matheus@email.com', 'matheus7', 1002, 1001),
('Max Maya', 'max@email.com', 'max45678', NULL, 1002),
('Sara Cheque', 'sara@email.com', 'sara1234', 1004, 1002);

INSERT INTO maquina (numMaquina, fkEmpresaMaquina) VALUES
('M01', 1000),
('M02', 1000),
('M01', 1001),
('M01', 1002),
('M01', 1003),
('M02', 1003),
('M01', 1004),
('M01', 1005),
('M02', 1005),
('M01', 1006);

INSERT INTO sensor (estadoSensor, numSerie, fkMaquina) VALUES
('Ativo','10002000','1000'),
('Inativo','10002001','1001'),
('Manutenção','10002002','1002'),
('Ativo','10002003','1003'),
('Inativo','10002004','1004'),
('Ativo','10002005','1005'),
('Inativo','10002006','1006'),
('Manutenção','10002007','1007'),
('Ativo','10002008','1008'),
('Ativo','10002009','1009');

INSERT INTO registroSensor (fkSensor, valorRegistro) VALUES -- arrumar
(1000, 1),
(1001, 1),
(1002, 1);

-- VISUALISAÇÃO DE INFORMAÇÕES -- 
SELECT * FROM endereco;
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
SELECT s.numSerie, rS.hrRegistro 
FROM sensor AS s
JOIN registroSensor AS rS
WHERE hrRegistro
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






