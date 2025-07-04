*** Settings ***
Documentation     Testes de autenticação e autorização (login, register, me)
Resource          ../../../resources/base.robot
Resource          ../../../resources/services/ApiKeywords.robot
Test Setup        Start API Session
Test Teardown     End API Session

*** Test Cases ***
Login com usuário válido
    ${response}=    Login API    ${USER_EMAIL}    ${USER_PASSWORD}
    Validate Login Success    ${response}

Login com usuário inválido
    ${response}=    Login API    usuarioinvalido@example.com    senhaerrada
    Validate Login Failure    ${response}    # No swagger documenta que o status code é 400    Invalid credentials

Registro com e-mail já existente
    ${response}=    Registrar Usuário API    ${USER_EMAIL}    qualquerSenha
    Validate Registration Failure    ${response}    400    User already exists

Registro com formato inválido de e-mail
    ${response}=    Registrar Usuário API    emailinvalido    123
    Validate Registration Failure    ${response}    400    Validation failed
