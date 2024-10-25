create database rosaplane;

use rosaplane;

CREATE TABLE Destinos (
    id_destino INT PRIMARY KEY AUTO_INCREMENT,
    nome_destino VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    descricao TEXT
);

CREATE TABLE Pacotes (
    id_pacote INT PRIMARY KEY AUTO_INCREMENT,
    id_destino INT,
    nome_pacote VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,
    FOREIGN KEY (id_destino) REFERENCES Destinos(id_destino)
);

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    endereco TEXT
);

CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_pacote INT,
    data_reserva DATE NOT NULL,
    numero_pessoas INT NOT NULL,
    status_reserva ENUM('confirmada', 'pendente', 'cancelada') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_pacote) REFERENCES Pacotes(id_pacote)
);

-- CRIANDO AS VIEWS:
CREATE VIEW Pacotes_Destinos AS
SELECT 
    p.id_pacote,
    p.nome_pacote,
    p.preco,
    p.data_inicio,
    p.data_termino,
    d.nome_destino,
    d.pais
FROM 
    Pacotes p
JOIN 
    Destinos d ON p.id_destino = d.id_destino;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
CREATE VIEW Reservas_Detalhadas AS
SELECT 
    r.id_reserva,
    r.data_reserva,
    r.numero_pessoas,
    r.status_reserva,
    c.nome_cliente,
    p.nome_pacote,
    d.nome_destino
FROM 
    Reservas r
JOIN 
    Clientes c ON r.id_cliente = c.id_cliente
JOIN 
    Pacotes p ON r.id_pacote = p.id_pacote
JOIN 
    Destinos d ON p.id_destino = d.id_destino;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
SELECT 
    nome_pacote, preco, data_inicio, data_termino 
FROM 
    Pacotes 
WHERE 
    id_destino = (SELECT id_destino FROM Destinos WHERE nome_destino = 'Paris');
 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 SELECT 
    r.id_reserva, r.data_reserva, r.numero_pessoas, r.status_reserva, p.nome_pacote, d.nome_destino 
FROM 
    Reservas r
JOIN 
    Clientes c ON r.id_cliente = c.id_cliente
JOIN 
    Pacotes p ON r.id_pacote = p.id_pacote
JOIN 
    Destinos d ON p.id_destino = d.id_destino
WHERE 
    c.nome_cliente = 'João da Silva';
 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 SELECT 
    d.nome_destino, COUNT(p.id_pacote) AS quantidade_pacotes 
FROM 
    Destinos d
LEFT JOIN 
    Pacotes p ON d.id_destino = p.id_destino
GROUP BY 
    d.nome_destino;
 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  -- -- -- --
 SELECT 
    r.id_reserva, c.nome_cliente, p.nome_pacote, r.numero_pessoas 
FROM 
    Reservas r
JOIN 
    Clientes c ON r.id_cliente = c.id_cliente
JOIN 
    Pacotes p ON r.id_pacote = p.id_pacote
WHERE 
    r.status_reserva = 'pendente';
 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  -- -- -- -- -- 