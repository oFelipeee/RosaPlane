create database rosaplane;

use rosaplane;

CREATE TABLE Destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nome_destino VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    descricao TEXT
);

create table Pacotes (
	id_pacote int auto_increment primary key,
    id_destino int not null,
    nome_pacote varchar(100) not null,
    preco decimal(10, 2) not null, 
    data_inicio date not null, 
    data_termino date not null,
    foreign key (id_destino) references Destinos(id_destino) on delete cascade
);

create table Clientes (
	id_cliente int auto_increment primary key, 
    nome_cliente varchar(100) not null, 
    email varchar(100) not null unique,
    telefone varchar(15),
    endereco varchar(20)
);

CREATE TABLE Reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pacote INT NOT NULL,
    data_reserva DATE NOT NULL,
    numero_pessoas INT NOT NULL CHECK (numero_pessoas > 0),
    -- Adicionando status da reserva:
    status_reserva ENUM('confirmada', 'pendente', 'cancelada') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_pacote) REFERENCES Pacotes(id_pacote) ON DELETE CASCADE
);