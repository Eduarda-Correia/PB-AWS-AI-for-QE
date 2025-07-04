*** Settings ***
Resource          ../../../resources/base.robot
Resource          ../../../resources/services/ApiKeywords.robot

Suite Setup       Start API Session
Suite Teardown    End API Session

*** Test Cases ***
Listar sessões de um filme
    ${response}=    Listar Sessoes De Um Filme API    ${id_do_filme}
    Validate Session List Success    ${response}

Criar nova sessão (admin)
    ${token}=       Login API    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    ${response}=    Criar Sessao API
    ...             ${token}
    ...             ${id_do_filme}
    ...             ${id_do_teatro}
    ...             2025-08-01
    ...             20:00
    Validate Session Creation Success    ${response}
