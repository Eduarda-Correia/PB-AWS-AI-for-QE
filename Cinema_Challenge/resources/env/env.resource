*** Settings ***
Documentation     Variáveis de ambiente (URLs, etc.)

*** Variables ***
# URLs da API
${API_BASE_URL}   http://localhost:3000/api/v1

# URLs do Frontend
${FRONTEND_URL}   http://localhost:3002
${LOGIN_URL}      ${FRONTEND_URL}/login
${REGISTER_URL}   ${FRONTEND_URL}/register
${MOVIES_URL}     ${FRONTEND_URL}/movies

# Credenciais de teste
${USER_EMAIL}     test@example.com
${USER_PASSWORD}  password123
${ADMIN_EMAIL}    admin@example.com
${ADMIN_PASSWORD}    admin123

# Configurações de timeout
${TIMEOUT}        10s
${SHORT_TIMEOUT}  5s

# Configurações do navegador
${BROWSER}        chrome
${HEADLESS}       ${False}