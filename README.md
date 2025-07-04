# Challenge Técnico PB AWS & AI for QE

---

## Descrição do Projeto

Este projeto consiste na automação de testes funcionais para a aplicação Cinema Challenge, utilizando Robot Framework. O objetivo é garantir a qualidade das APIs e do front-end, aplicando boas práticas de automação, análise de requisitos e cobertura de cenários críticos.

---

## Instruções de Clonagem e Execução

```bash
git clone https://github.com/seu-usuario/PB-AWS-AI-for-QE.git
cd PB-AWS-AI-for-QE/Cinema_Challenge
pip install -r requirements.txt
```

---

## Instruções de Execução dos Testes

Para executar todos os testes automatizados:

```bash
robot tests/
```

Para executar apenas os testes de API:

```bash
robot tests/api/
```

Para executar apenas os testes de front-end:

```bash
robot tests/frontend/
```

---

## Estrutura do Projeto

- `application/` - Código da aplicação (back-end e front-end)
- `Cinema_Challenge/` - Projeto de automação de testes
  - `resources/` - Recursos compartilhados (keywords, dados, libs)
  - `tests/` - Casos de teste organizados por área (api, frontend)
  - `requirements.txt` - Dependências do projeto de automação

---

## Contato

Dúvidas ou sugestões, entre em contato.
