DROP TABLE IF EXISTS Venda_Prod;
DROP TABLE IF EXISTS Forne_Prod;
DROP TABLE IF EXISTS Lote;
DROP TABLE IF EXISTS Venda;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Farmacia;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Dono;
DROP TABLE IF EXISTS Fornecedor;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS PlanoSaude;
DROP TABLE IF EXISTS Pessoa;


CREATE TABLE Pessoa(
    CPF CHAR(11),
    DataNascimento DATE NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE CHECK (Email LIKE '%@%'),
    Telefone VARCHAR(20) NOT NULL UNIQUE,
    CEP CHAR(8) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    Cidade VARCHAR(50) NOT NULL,
    PRIMARY KEY(CPF)
);
CREATE TABLE PlanoSaude(
    CodPlano INT,
    PercDesconto DECIMAL(5,2) NOT NULL,
    NomeOperadora VARCHAR(100) NOT NULL,
    PRIMARY KEY(CodPlano)
);
CREATE TABLE Produto(
    CodProduto INT,
    Nome VARCHAR(100) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(CodProduto)
);
CREATE TABLE Fornecedor(
    CNPJFornecedor CHAR(14),
    Nome VARCHAR(100) NOT NULL,
    Cidade VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL CHECK (Email LIKE '%@%'),
    PRIMARY KEY(CNPJFornecedor)
);
CREATE TABLE Dono(
    CPF CHAR(11),
    PRIMARY KEY(CPF),
    FOREIGN KEY(CPF) REFERENCES Pessoa(CPF)
);
CREATE TABLE Cliente(
    CPF CHAR(11),
    CodPlano INT,
    ValidadePlano DATE NOT NULL,
    PRIMARY KEY(CPF),
    FOREIGN KEY(CPF) REFERENCES Pessoa(CPF),
    FOREIGN KEY(CodPlano) REFERENCES PlanoSaude(CodPlano)
);
CREATE TABLE Farmacia(
    CNPJ CHAR(14),
    CPF CHAR(11) NOT NULL,
    CEP CHAR(8) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    Cidade VARCHAR(50) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    PRIMARY KEY(CNPJ),
    FOREIGN KEY(CPF) REFERENCES Dono(CPF)
);
CREATE TABLE Funcionario(
    CPF CHAR(11),
    CNPJ CHAR(14),
    Cargo VARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(CPF),
    FOREIGN KEY(CPF) REFERENCES Pessoa(CPF),
    FOREIGN KEY(CNPJ) REFERENCES Farmacia(CNPJ)
);
CREATE TABLE Venda(
    CodVenda INT,
    CPF CHAR(11) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    Desconto DECIMAL(10,2),
    FormaPagamento VARCHAR(50) NOT NULL CHECK (FormaPagamento IN ('Credito', 'Debito', 'PIX', 'Dinheiro')),
    Data DATE NOT NULL,
    ValorTotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(CodVenda),
    FOREIGN KEY(CPF) REFERENCES Cliente(CPF),
    FOREIGN KEY(CNPJ) REFERENCES Farmacia(CNPJ)
);
CREATE TABLE Forne_Prod(
    CodProduto INT,
    CNPJFornecedor CHAR(14),
    CustoUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(CodProduto, CNPJFornecedor),
    FOREIGN KEY(CodProduto) REFERENCES Produto(CodProduto),
    FOREIGN KEY(CNPJFornecedor) REFERENCES Fornecedor(CNPJFornecedor)
);
CREATE TABLE Venda_Prod(
    CodVenda INT,
    CodProduto INT,
    Quantidade INT NOT NULL,
    PRIMARY KEY(CodVenda, CodProduto),
    FOREIGN KEY(CodVenda) REFERENCES Venda(CodVenda),
    FOREIGN KEY(CodProduto) REFERENCES Produto(CodProduto)
);
CREATE TABLE Lote(
    CodLote INT,
    CodProduto INT,
    CNPJ CHAR(14) NOT NULL,
    Validade DATE,
    Quantidade INT NOT NULL,
    DataFabricacao DATE NOT NULL,
    PRIMARY KEY(CodLote, CodProduto),
    FOREIGN KEY(CodProduto) REFERENCES Produto(CodProduto),
    FOREIGN KEY(CNPJ) REFERENCES Farmacia(CNPJ)
);

