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

CREATE TABLE sensor( -- INSERIR DADOS
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
hrApontamento DATETIME DEFAULT CURRENT_TIMESTAMP,
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
('11122233344458','Predileta');

INSERT INTO usuario (nome, email, senha, fkSupervisor, fkEmpresa)VALUES
('Giovanna Flores', 'giovanna@email.com', 'gi120511', NULL, 1000),
('Nathan Fioravanti', 'nathan@email.com', 'nathan79', NULL, 1000),
('Lucas Espindola', 'lucas@email.com', 'lucas699', 1000, 1001),
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

INSERT INTO registroSensor (fkSensor) VALUES -- arrumar
(1000),
(1001),
(1002);


-- VISUALISAÇÃO DE INFORMAÇÕES -- 

SELECT * FROM empresa;
SELECT * FROM usuario;
SELECT * FROM maquina;
SELECT * FROM sensor;
SELECT * FROM registroSensor; 


/* SELECTs ANTIGOS

SELECT nome AS Nome, nivelAcesso AS 'Nivel de Acesso' FROM usuario;

VERIFICANDO OS REGISTROS ENTRE 14H E 15H
SELECT numSerie, hrApontamento, hrRegistro FROM registroSensor 
WHERE hrApontamento
BETWEEN '2026-02-26 14:00:00' 
AND '2026-02-26 15:00:00';

SELECT empresa.nome AS 'Nome da Empresa',numMaquina AS 'Nº da Máquina'  FROM maquina
JOIN empresa on fkEmpresaMaquina = idEmpresa
JOIN usuario ON fkEmpresa = idEmpresa;

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
	JOIN ocorrencia ON idUsuario = fkUsuarioOcorrencia; */
    
    
/* SELECTS que podemos fazer: 
1. Buscar registros entre horários;
2. Empresa + Máquina;
3. Empresa + Máquina + Sensor;
4. empresa + maquina + sensor + registro;
5. Sensores ativos;
6. Usuários com suas empresas;
7. Supervisor de cada usuário;
*/
    
    



