*** Settings ***
Documentation     Configurações globais, imports comuns, setup/teardown
Library           BuiltIn
Library           SeleniumLibrary
Library           RequestsLibrary
Library           String
Library           BuiltIn
Library           Collections
Library           JsonLibrary
Resource          env/env.resource

*** Keywords ***
# Keywords comuns para todos os testes
Start Session
    [Documentation]    Inicia uma nova sessão para o teste
    Log    Iniciando nova sessão de teste

Take Screenshot
    [Documentation]    Captura screenshot do teste
    Log    Screenshot capturado

# Keywords comuns para testes de API
Start API Session
    [Documentation]    Inicia uma nova sessão HTTP para testes de API
    Create Session    cinema    ${API_BASE_URL}

End API Session
    [Documentation]    Finaliza a sessão HTTP
    Delete All Sessions

# Keywords comuns para testes de UI
Start UI Session
    [Documentation]    Inicia uma nova sessão para testes de UI
    Open Browser    ${FRONTEND_URL}    chrome    headless=${False}

End UI Session
    [Documentation]    Finaliza a sessão de UI e fecha o navegador
    Log    Encerrando sessão de UI
    Close Browser

# Keywords de validação comuns
Validate Response Status
    [Arguments]    ${response}    ${expected_status}
    [Documentation]    Valida o status code da resposta da API
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}

Validate Response Contains
    [Arguments]    ${response}    ${expected_content}
    [Documentation]    Valida se a resposta contém o conteúdo esperado
    Should Contain    ${response.json()}    ${expected_content}

Validate Page Contains Element
    [Arguments]    ${locator}
    [Documentation]    Valida se a página contém o elemento especificado
    Wait Until Page Contains Element    ${locator}
    Page Should Contain Element    ${locator}

Validate Page Contains Text
    [Arguments]    ${text}
    [Documentation]    Valida se a página contém o texto especificado
    Wait Until Page Contains    ${text}
    Page Should Contain    ${text}

# Helpers
Get fixture
    [Arguments]    ${file_name}    ${cenario}
    [Documentation]    Carrega dados de fixture
    ${data}    Load Json From file
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    RETURN    ${data}[${cenario}]

Generate Random String
    [Arguments]    ${length}    ${chars}=[LETTERS][NUMBERS]
    [Documentation]    Gera uma string aleatória com o comprimento especificado
    ${random_string}=    BuiltIn.Generate Random String    ${length}    ${chars}
    RETURN    ${random_string}