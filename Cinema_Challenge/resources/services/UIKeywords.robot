*** Settings ***
Documentation     Keywords centralizadas para testes de UI
Resource          ../base.robot

*** Keywords ***
# Keywords de Login
Abrir Página de Login
    [Documentation]    Abre a página de login
    Go To    ${LOGIN_URL}
    Wait Until Page Contains Element    id=email

Fazer Login
    [Arguments]    ${email}    ${senha}
    [Documentation]    Preenche e submete o formulário de login
    Input Text    id=email    ${email}
    Input Text    id=password    ${senha}
    Click Button    id=login-btn
    Wait Until Page Contains Element    id=header-usuario    5s

Verificar Login com Sucesso
    [Documentation]    Verifica se o login foi bem-sucedido
    Validate Page Contains Element    id=header-usuario
    Validate Page Contains Text    Bem-vindo

Verificar Mensagem de Erro de Login
    [Arguments]    ${mensagem}
    [Documentation]    Verifica se a mensagem de erro de login está presente
    Validate Page Contains Text    ${mensagem}

# Keywords de Registro
Abrir Página de Registro
    [Documentation]    Abre a página de registro
    Go To    ${REGISTER_URL}
    Wait Until Page Contains Element    id=email

Fazer Registro
    [Arguments]    ${email}    ${senha}
    [Documentation]    Preenche e submete o formulário de registro
    Input Text    id=email    ${email}
    Input Text    id=password    ${senha}
    Click ButtoN    id=register-btn
    Wait Until Page Contains    Registro realizado com sucesso    5s

Verificar Registro com Sucesso
    [Documentation]    Verifica se o registro foi bem-sucedido
    Validate Page Contains Text    Registro realizado com sucesso

Verificar Mensagem de Erro de Registro
    [Arguments]    ${mensagem}
    [Documentation]    Verifica se a mensagem de erro de registro está presente
    Validate Page Contains Text    ${mensagem}

# Keywords de Filmes
Abrir Página de Filmes
    [Documentation]    Abre a página de listagem de filmes
    Go To    ${MOVIES_URL}
    Wait Until Page Contains Element    css:.movie-card

Verificar Lista de Filmes
    [Documentation]    Verifica se a lista de filmes está sendo exibida
    Validate Page Contains Element    css:.movie-card

Filtrar Filmes por Título
    [Arguments]    ${titulo}
    [Documentation]    Filtra filmes por título
    Input Text    id=search-title    ${titulo}
    Click Button    id=search-btn
    Wait Until Page Contains    ${titulo}    5s

Filtrar Filmes por Gênero
    [Arguments]    ${genero}
    [Documentation]    Filtra filmes por gênero
    Select From List By Value    id=genre-filter    ${genero}
    Click Button    id=search-btn
    Wait Until Page Contains    ${genero}    5s

Visualizar Detalhes do Primeiro Filme
    [Documentation]    Clica no primeiro filme para ver seus detalhes
    Click Element    css:.movie-card:first-child
    Wait Until Page Contains Element    css:.movie-detail    5s
    Validate Page Contains Element    css:.movie-detail
    Validate Page Contains Text    Sessões 