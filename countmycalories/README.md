# Count My Calories

Aplicativo de contador de calorias desenvolvido em Flutter, direcionado para Android e Web, seguindo o padrão arquitetural Hexagonal. As telas foram inspiradas nas referências fornecidas no link compartilhado do Canva: [Design de referência no Canva](https://www.canva.com/design/DAGqJ7n1P5k/QrJoe0p8DZeVYkE3vIcwXg/view?utm_content=DAGqJ7n1P5k&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=ha77f2d3e69).

## Objetivo

Permitir que usuários registrem refeições, contabilizem calorias diárias e acompanhem seu progresso ao longo do tempo. A primeira entrega inclui navegação, DI, gerenciamento de estado e telas iniciais (Login e Home) para Android e Web.

## Arquitetura

- **Padrão**: Hexagonal (Ports & Adapters)
- **Navegação**: `go_router`
- **Injeção de dependências**: `get_it`
- **Gerência de estado**: `provider`

Estrutura (simplificada) em `lib/`:

```
core/
  constants/ (cores, rotas, textos)
  di/ (service locator)
  platform/ (detector de plataforma)
application/
  providers/ (estado da aplicação)
  services/ (regras de aplicação/ports)
routes/
  app_router.dart (GoRouter)
pages/
  login/ (views Android/Web)
  home/ (views Android/Web)
```

## Requisitos (MVP)

- Login simples (mock) com email e senha.
- Tela inicial exibindo mensagem e ação para adicionar registro de calorias (placeholder).
- Navegação protegida: usuários não autenticados são redirecionados para Login.
- Suporte a Android e Web.

## Histórias de Usuário

- Como usuário, quero fazer login para acessar minhas informações e registrar calorias.
- Como usuário, quero visualizar a tela inicial para iniciar rapidamente um novo registro de calorias.
- Como usuário, quero sair da aplicação para encerrar minha sessão com segurança.

## Como executar

Pré-requisitos: Flutter SDK instalado e configurado.

1. Instale dependências:
   ```bash
   flutter pub get
   ```
2. Executar no Android (emulador/dispositivo):
   ```bash
   flutter run -d android
   ```
3. Executar na Web (Chrome):
   ```bash
   flutter run -d chrome
   ```

## Notas de Implementação

- `get_it` faz o registro do `AuthService` em `core/di/service_locator.dart`.
- `provider` expõe `AuthProvider` para gerenciar estado de autenticação.
- `go_router` controla rotas e redirecionamento com base no estado de login.
- Views específicas para Android e Web foram adicionadas para `Login` e `Home`.

## Próximos Passos (sugestões)

- Implementar entidades e casos de uso de refeições e metas calóricas (Domínio).
- Persistência local (ex.: `shared_preferences`/`hive`) e/ou API remota.
- Tela de cadastro/recuperação de senha e onboarding.
- Tela de registro detalhado de refeição, listagem e gráficos de evolução.
