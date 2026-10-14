# frontend-premium-skill

[English](README.md) · **Português**

Uma skill-mestre para o [Claude Code](https://claude.com/claude-code) que transforma um monte de
ótimas skills de frontend em **um fluxo repetível** para entregar interfaces de nível de mercado:
direção de arte de verdade, design system documentado, revisão de acessibilidade e verificação
obrigatória no navegador.

Ela não reinventa nada: orquestra as melhores skills da comunidade e diz ao Claude **qual usar em
cada etapa**.

## O fluxo

| Etapa | O que acontece | Skills usadas |
|---|---|---|
| 0. Classificar | Página pública, app/dashboard, redesign, mobile ou só revisão | — |
| 1. Entender | Lê a stack; gera `DESIGN.md` a partir do código existente | `extract-design-md`, `site-md` |
| 1b. Fundação | Só para projeto novo: stack, scaffold, estrutura, tokens do tema, cliente de API, app shell | `shadcn-ui`, `playwright-cli` |
| 2. Direção de arte | Escolhe uma direção real em vez dos padrões do modelo | `design-taste-frontend`, `high-end-visual-design`, `minimalist-ui`, `industrial-brutalist-ui`, `gpt-taste`, `brandkit` |
| 3. Construir | Componentes a partir dos tokens do tema, todos os estados, responsivo | `shadcn-ui`, `react-vite-dashboard`, `react-components` |
| 4. Polir | Remove a "cara de feito por IA" | `redesign-existing-projects` |
| 5. Revisar | Acessibilidade e boas práticas de interface web | `web-design-guidelines` |
| 6. Verificar | Screenshots em 375 / 768 / 1440 px, corrige, repete | `playwright-cli` |
| 7. Entregar | Resumo das decisões, achados e pendências | — |

Em todo o fluxo: `full-output-enforcement` (sem código truncado nem placeholders).

### Trilha iOS nativo (SwiftUI)

Apps nativos de iPhone/iPad seguem uma trilha própria com os mesmos objetivos — as etapas web 1b–6
não se aplicam:

| Etapa | O que acontece | Skills usadas |
|---|---|---|
| Entender / fundação | Deployment target, Swift 6, pastas por feature, cores semânticas no Asset Catalog, serviço mock | — |
| Direção de arte | Human Interface Guidelines da Apple, SF Symbols, Dynamic Type | `swiftui-pro` (referência de design), `imagegen-frontend-mobile` |
| Construir | Fluxo de dados primeiro, `#Preview` por estado, checklist de correção | `swiftui-expert-skill` |
| Revisar | API depreciada, fluxo de dados, navegação, acessibilidade, localização, desempenho | `swiftui-pro` |
| Verificar | Screenshots no Simulator em iPhone e iPad, claro/escuro, maior tamanho de Dynamic Type; traces do Instruments | `xcrun simctl`, `swiftui-expert-skill` |

Apps multiplataforma (iOS + Android num só código) usam Expo + React Native. Android nativo
(Jetpack Compose) não é coberto.

## Instalação

```bash
git clone https://github.com/MoisesK/frontend-premium-skill.git
bash frontend-premium-skill/skills/frontend-premium/scripts/install.sh
```

O instalador coloca tudo em `~/.claude/skills/` (global, disponível em todos os projetos):

- esta skill `frontend-premium`;
- [taste-skill](https://github.com/Leonxlnx/taste-skill) (14 skills);
- [web-design-guidelines](https://github.com/vercel-labs/agent-skills), da Vercel;
- [Stitch skills](https://github.com/google-labs-code/stitch-skills), do Google (16 skills);
- [playwright-cli](https://github.com/microsoft/playwright-cli), da Microsoft — skill, binário e Chromium;
- [SwiftUI Expert](https://github.com/AvdLee/SwiftUI-Agent-Skill), de Antoine van der Lee, e
  [SwiftUI Pro](https://github.com/twostraws/swiftui-agent-skill), de Paul Hudson.

Use `--force` para sobrescrever skills já instaladas. Abra uma nova sessão do Claude Code depois.

Só quer a skill do fluxo (já tem as outras)?

```bash
npx skills add MoisesK/frontend-premium-skill -g -a claude-code
```

### Pré-requisitos

- **Node 22+** (os scripts da `design-taste-frontend` exigem), Git e npm
- Chrome, Edge ou Chromium
- Para a trilha iOS nativo: Xcode com um runtime do iOS Simulator
- Opcional: MCP do Google Stitch + chave de API, para as skills do Stitch

## Uso

Basta pedir ao Claude Code para trabalhar num frontend — "começa o frontend", "monta o dashboard",
"deixa essa página premium", "revisa minha UI". A skill é acionada automaticamente, ou chame com
`/frontend-premium`.

## Créditos

Este repositório contém apenas a skill de orquestração e o instalador. Todas as outras skills são
baixadas dos autores originais no momento da instalação — veja a tabela de licenças no
[README em inglês](README.md#credits).

## Licença

[MIT](LICENSE)
