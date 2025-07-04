*** Settings ***
Documentation     Keywords genéricas para chamadas API (POST, GET, etc.)
Resource          ../base.robot

*** Keywords ***
# Keywords de Autenticação
Login API
    [Arguments]    ${email}    ${senha}
    [Documentation]    Realiza login via API
    ${payload}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    cinema    /auth/login    json=${payload}    expected_status=ANY
    RETURN    ${response}

Registrar Usuário API
    [Arguments]    ${email}    ${senha}
    [Documentation]    Registra um novo usuário via API
    ${payload}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    cinema    /auth/register    json=${payload}    expected_status=ANY
    RETURN    ${response}

# Keywords de Filmes
Listar Filmes API
    [Documentation]    Lista todos os filmes via API
    ${response}=    GET On Session    cinema    /movies
    RETURN    ${response}

Filtrar Filmes por Título API
    [Arguments]    ${titulo}
    [Documentation]    Filtra filmes por título via API
    ${response}=    GET On Session    cinema    /movies    params=title=${titulo}
    RETURN    ${response}

Filtrar Filmes por Gênero API
    [Arguments]    ${genero}
    [Documentation]    Filtra filmes por gênero via API
    ${response}=    GET On Session    cinema    /movies    params=genre=${genero}
    RETURN    ${response}

Criar Filme API
    [Arguments]    ${token}    ${titulo}    ${sinopse}    ${diretor}    ${generos}    ${duracao}    ${classificacao}    ${data_lancamento}    ${poster}
    [Documentation]    Cria um novo filme via API (requer token de admin)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${payload}=    Create Dictionary    title=${titulo}    synopsis=${sinopse}    director=${diretor}    genres=${generos}    duration=${duracao}    classification=${classificacao}    releaseDate=${data_lancamento}    poster=${poster}
    ${response}=    POST On Session    cinema    /movies    headers=${headers}    json=${payload}
    RETURN    ${response}

# Keywords de Validação Específicas para API
Validate Login Success
    [Arguments]    ${response}
    [Documentation]    Valida se o login foi bem-sucedido
    Validate Response Status    ${response}    200
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json['data']}    token
    ${token}=    Get From Dictionary    ${json['data']}    token
    Set Test Variable    ${TOKEN}    ${token}

Validate Login Failure
    [Arguments]    ${response}
    [Documentation]    Valida se o login falhou
    Validate Response Status    ${response}    400
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal    ${json['message']}    Invalid credentials

Validate Registration Success
    [Arguments]    ${response}
    [Documentation]    Valida se o registro foi bem-sucedido
    Validate Response Status    ${response}    201
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json['data']}    id

Validate Registration Failure
    [Arguments]    ${response}    ${expected_status}    ${expected_message}
    [Documentation]    Valida se o registro falhou
    Validate Response Status    ${response}    ${expected_status}
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal    ${json['message']}    ${expected_message}

Validate Movies List
    [Arguments]    ${response}
    [Documentation]    Valida se a lista de filmes foi retornada
    Validate Response Status    ${response}    200
    ${json}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${json}

Validate Movie Creation Success
    [Arguments]    ${response}
    [Documentation]    Valida se a criação do filme foi bem-sucedida
    Validate Response Status    ${response}    201
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json['data']}    id

Validate Movie Creation Failure
    [Arguments]    ${response}
    [Documentation]    Valida se a criação do filme falhou (sem permissão)
    Validate Response Status    ${response}    403
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal    ${json['message']}    Forbidden - Admin access required

Setup Reservations API
    Log    Iniciando suíte de testes de Reservations API

Teardown Reservations API
    Log    Finalizando suíte de testes de Reservations API

Listar Reservas API
    [Arguments]    ${token}
    [Documentation]    Lista reservas do usuário via API
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    cinema    /reservations    headers=${headers}
    RETURN    ${response}

Criar Reserva API
    [Arguments]    ${token}    ${session_id}    ${seat}
    [Documentation]    Cria uma nova reserva via API
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${payload}=    Create Dictionary    session_id=${session_id}    seat=${seat}
    ${response}=    POST On Session    cinema    /reservations    headers=${headers}    json=${payload}
    RETURN    ${response}

Validate Reservations List
    [Arguments]    ${response}
    [Documentation]    Valida se a lista de reservas foi retornada
    Validate Response Status    ${response}    200
    ${json}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${json}

Validate Reservation Creation Success
    [Arguments]    ${response}
    [Documentation]    Valida se a criação da reserva foi bem-sucedida
    Validate Response Status    ${response}    201
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    id

Setup Sessions API
    Log    Iniciando suíte de testes de Sessions API

Teardown Sessions API
    Log    Finalizando suíte de testes de Sessions API

Listar Sessões API
    [Arguments]    ${movie_id}
    [Documentation]    Lista sessões de um filme via API
    ${response}=    GET On Session    cinema    /movies/${movie_id}/sessions
    RETURN    ${response}

Criar Sessão API
    [Arguments]    ${token}    ${movie_id}    ${date}    ${time}    ${price}
    [Documentation]    Cria uma nova sessão via API
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${payload}=    Create Dictionary    date=${date}    time=${time}    price=${price}
    ${response}=    POST On Session    cinema    /movies/${movie_id}/sessions    headers=${headers}    json=${payload}
    RETURN    ${response}

Validate Sessions List
    [Arguments]    ${response}
    [Documentation]    Valida se a lista de sessões foi retornada
    Validate Response Status    ${response}    200
    ${json}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${json}

Validate Session Creation Success
    [Arguments]    ${response}
    [Documentation]    Valida se a criação da sessão foi bem-sucedida
    Validate Response Status    ${response}    201
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    id