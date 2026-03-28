# seleciona o nome de todas as pessoas que realizaram uma compra usando cartao de credito

SELECT DISTINCT P.Nome
FROM Pessoa P, Venda V
WHERE (V.CPF = P.CPF) AND (V.FORMAPAGAMENTO = 'Credito');

# seleciona o nome, custo e contato dos fornecedores do produto "paracetamol", ordenado pelo menor custo (3 tabelas)

SELECT F.Nome, F.Email, FP.CustoUnitario
FROM Fornecedor F, Forne_Prod FP, Produto P
WHERE ((P.CodProduto = FP.CodProduto) AND (FP.CNPJFORNECEDOR = F.CNPJFORNECEDOR))
AND (P.Nome LIKE 'Paracetamol%')
ORDER BY FP.CustoUnitario ASC;

# seleciona o nome da operadora dos planos de saude aceitos e quantos clientes cada um tem, ordenado pelos mais usados

SELECT P.NomeOperadora, COUNT(C.CodPlano) AS QuantClientes
FROM PlanoSaude P, Cliente C
WHERE (C.CodPlano = P.CodPlano)
GROUP BY (P.NomeOperadora)
ORDER BY COUNT(C.CodPlano) DESC;
