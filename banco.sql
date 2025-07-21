CREATE DATABASE  encantos_db;
USE encantos_db;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);


CREATE TABLE endereco (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  rua VARCHAR(100) NOT NULL,
  numero INT NOT NULL,
  bairro VARCHAR(50),
  cidade VARCHAR(50),
  estado VARCHAR(2),
  numero_tel VARCHAR(15)
);

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,                         
    descricao TEXT,                                    
    categoria_id INT,                                   
    local VARCHAR(255),                              
    endereco VARCHAR(255),                             
    organizador VARCHAR(255),                          
    contato VARCHAR(100),                              
    imagem TEXT,                                       
    criado_por INT,                                     
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    FOREIGN KEY (categoria_id) REFERENCES categorias(id), 
    FOREIGN KEY (criado_por) REFERENCES usuarios(id)       
);

CREATE TABLE restaurantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    tipo_cozinha ENUM('Brasileira','Maranhense','Italiana','Japonesa','Mexicana','Francesa') NOT NULL,
    endereco VARCHAR(255),
    bairro VARCHAR(100),
    telefone VARCHAR(20),
    horario_funcionamento VARCHAR(100),
    faixa_preco ENUM('R$', 'R$$', 'R$$$', 'R$$$$'),
    capacidade INT,
    avaliacao INT CHECK (avaliacao BETWEEN 1 AND 5),
    imagem TEXT,
    reservas BOOLEAN,
    delivery BOOLEAN,
    estacionamento BOOLEAN,
    criado_por INT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (criado_por) REFERENCES usuarios(id)
);

CREATE TABLE comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo_destino ENUM('evento', 'restaurante') NOT NULL,
    destino_id INT NOT NULL,
    conteudo TEXT NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE eventos_tags (
    evento_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (evento_id, tag_id),
    FOREIGN KEY (evento_id) REFERENCES eventos(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);

CREATE TABLE restaurantes_tags (
    restaurante_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (restaurante_id, tag_id),
    FOREIGN KEY (restaurante_id) REFERENCES restaurantes(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);