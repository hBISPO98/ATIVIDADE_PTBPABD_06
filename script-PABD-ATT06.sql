-- Afirmando criação do SCHEMA university
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'university')
BEGIN
    EXEC('CREATE SCHEMA university');
END

-- Criando tabelas CLASSROOM e STUDENT dentro do esquema university
CREATE TABLE university.CLASSROOM (id INT, building VARCHAR(50));
CREATE TABLE university.STUDENT (id INT, name VARCHAR(50));

-- Q01: Crie as contas de usuário User_A, User_B, User_C, User_D e User_E.
CREATE USER User_A WITH PASSWORD = 'Senha123@';
CREATE USER User_B WITH PASSWORD = 'Senha123@';
CREATE USER User_C WITH PASSWORD = 'Senha123@';
CREATE USER User_D WITH PASSWORD = 'Senha123@';
CREATE USER User_E WITH PASSWORD = 'Senha123@';

-- Q02: Considere o esquema de banco de dados relacional university. O User_A poderá selecionar ou modificar qualquer relação, exceto CLASSROOM, e pode conceder qualquer um desses privilégios a outros usuários.
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: university TO User_A WITH GRANT OPTION; -- Permissões com GRANT

DENY SELECT, INSERT, UPDATE, DELETE ON university.CLASSROOM TO User_A; -- Restrição com DENY

-- Q03: Liste as permissões do User_A.
SELECT 
    p.name AS Usuario, -- Conta que recebu permissão
    perm.permission_name AS Permissao, -- O que será alterado: SELECT, INSERT ou UPDATE
    perm.state_desc AS Status, -- Status da permissão: GRANT ou DENY
    OBJECT_NAME(perm.major_id) AS Nome_Objeto -- Busque o ID do objeto (per.major_id) e transforme no nome real (OBJECT_NAME), nomeando essa coluna de Nome_Objeto
FROM sys.database_permissions AS perm -- Busque os dados na tabela de permissoes do sistema (perm)
JOIN sys.database_principals AS p ON perm.grantee_principal_id = p.principal_id -- Cruze esses dados com os users (p) ligando o ID de quem recebeu a permissão com o ID do usuário (nome: User_A)
WHERE p.name = 'User_A'; -- Foco no User_A
