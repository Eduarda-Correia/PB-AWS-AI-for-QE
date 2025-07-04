*** Settings ***
Resource          ../../../resources/base.robot
Resource          ../../../resources/services/ApiKeywords.robot

Suite Setup       Start API Session
Suite Teardown    End API Session

*** Test Cases ***
Criar reserva com usuário logado
    ${token}=       Login API    ${USER_EMAIL}    ${USER_PASSWORD}
    ${response}=    Criar Reserva API
    ...             ${token}
    ...             ${id_sessao}
    ...             2
    Validate Reservation Success    ${response}

Criar reserva com sessão inexistente
    ${token}=       Login API    ${USER_EMAIL}    ${USER_PASSWORD}
    Run Keyword And Expect Error    *404 Client Error*
    ...    Criar Reserva API
    ...    ${token}
    ...    id_invalido
    ...    1

Listar reservas do usuário
    ${token}=       Login API    ${USER_EMAIL}    ${USER_PASSWORD}
    ${response}=    Listar Reservas do Usuario API    ${token}
    Validate User Reservations Success    ${response}

Cancelar reserva existente
    ${token}=       Login API    ${USER_EMAIL}    ${USER_PASSWORD}
    ${id_reserva}=  Criar e Obter ID da Reserva    ${token}    ${id_sessao}    1
    ${response}=    Cancelar Reserva API    ${token}    ${id_reserva}
    Validate Cancel Reservation Success    ${response}
