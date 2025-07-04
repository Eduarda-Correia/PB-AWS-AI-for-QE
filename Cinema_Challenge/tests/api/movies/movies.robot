*** Settings ***
Documentation     Testes de gestão de filmes (GET, POST, PUT, DELETE)
Resource          ../../../resources/base.robot
Resource          ../../../resources/services/ApiKeywords.robot
Test Setup        Start API Session
Test Teardown     End API Session

*** Test Cases ***
Listar todos os filmes
    ${response}=    Listar Filmes API
    Validate Movies List    ${response}

Filtrar filmes por título
    ${response}=    Filtrar Filmes por Título API    Filme Teste
    Validate Movies List    ${response}

Filtrar filmes por gênero
    ${response}=    Filtrar Filmes por Gênero API    Ação
    Validate Movies List    ${response}

Criar filme com usuário admin
    ${login}=    Login API    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    ${json}=    Set Variable    ${login.json()}
    ${token}=    Get From Dictionary    ${json['data']}    token
    ${response}=    Criar Filme API    ${token}    Filme Teste    Sinopse do filme de teste    Diretor Teste    ["Ação"]    ${120}    Livre    2024-06-01    https://exemplo.com/poster.jpg
    Validate Movie Creation Success    ${response}

Criar filme com usuário regular (sem permissão)    #Resultado esperado: falha Status 403
    ${login}=    Login API    ${USER_EMAIL}    ${USER_PASSWORD}
    ${json}=    Set Variable    ${login.json()}
    ${token}=    Get From Dictionary    ${json['data']}    token
    ${response}=    Criar Filme API    ${token}    Filme Teste 2    Sinopse 2    Diretor 2    ["Drama"]    ${100}    12 anos    2024-07-01    https://exemplo.com/poster2.jpg
    Validate Movie Creation Failure    ${response}
