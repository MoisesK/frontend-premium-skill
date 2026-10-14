# frontend-premium-skill

**English** · [Português](README.pt-BR.md)

A master [Claude Code](https://claude.com/claude-code) skill that turns a pile of great frontend
skills into **one repeatable workflow** for shipping market-grade interfaces: real art direction,
a documented design system, accessibility review, and mandatory verification in a real browser.

It doesn't reinvent anything — it orchestrates the best community skills and tells Claude **which one
to use at each step**.

## The workflow

| Step | What happens | Skills used |
|---|---|---|
| 0. Classify | Public page, app/dashboard, redesign, mobile or review-only | — |
| 1. Understand | Read the stack; generate `DESIGN.md` from existing code | `extract-design-md`, `site-md` |
| 1b. Foundation | Greenfield only: stack choice, scaffold, structure, theme tokens, API client, app shell | `shadcn-ui`, `playwright-cli` |
| 2. Art direction | Pick a real direction instead of model defaults | `design-taste-frontend`, `high-end-visual-design`, `minimalist-ui`, `industrial-brutalist-ui`, `gpt-taste`, `brandkit` |
| 3. Build | Components from theme tokens, all data states, responsive | `shadcn-ui`, `react-vite-dashboard`, `react-components` |
| 4. Polish | Remove the "AI-generated" tells | `redesign-existing-projects` |
| 5. Review | Accessibility and web interface best practices | `web-design-guidelines` |
| 6. Verify | Screenshots at 375 / 768 / 1440 px, fix, repeat | `playwright-cli` |
| 7. Deliver | Summary of decisions, findings and pending items | — |

Throughout: `full-output-enforcement` (no truncated code or placeholders).

### Native iOS track (SwiftUI)

Native iPhone/iPad apps follow their own track with the same goals — the web steps 1b–6 don't apply:

| Step | What happens | Skills used |
|---|---|---|
| Understand / foundation | Deployment target, Swift 6, folders by feature, semantic colors in the Asset Catalog, mock service | — |
| Art direction | Apple Human Interface Guidelines, SF Symbols, Dynamic Type | `swiftui-pro` (design reference), `imagegen-frontend-mobile` |
| Build | Data flow first, `#Preview` per state, correctness checklist | `swiftui-expert-skill` |
| Review | Deprecated API, data flow, navigation, accessibility, localization, performance | `swiftui-pro` |
| Verify | Simulator screenshots on iPhone and iPad, light/dark, largest Dynamic Type; Instruments traces | `xcrun simctl`, `swiftui-expert-skill` |

Cross-platform apps (iOS + Android from one codebase) use Expo + React Native. Native Android
(Jetpack Compose) is not covered.

## Installation

```bash
git clone https://github.com/MoisesK/frontend-premium-skill.git
bash frontend-premium-skill/skills/frontend-premium/scripts/install.sh
```

The installer puts everything in `~/.claude/skills/` (global, available in every project):

- this `frontend-premium` skill;
- [taste-skill](https://github.com/Leonxlnx/taste-skill) (14 skills);
- [web-design-guidelines](https://github.com/vercel-labs/agent-skills) from Vercel;
- [Stitch skills](https://github.com/google-labs-code/stitch-skills) from Google (16 skills);
- [playwright-cli](https://github.com/microsoft/playwright-cli) from Microsoft — skill, CLI binary and Chromium;
- [SwiftUI Expert](https://github.com/AvdLee/SwiftUI-Agent-Skill) by Antoine van der Lee and
  [SwiftUI Pro](https://github.com/twostraws/swiftui-agent-skill) by Paul Hudson.

Use `--force` to overwrite skills that are already installed. Start a new Claude Code session
afterwards.

Only want the workflow skill (you already have the others)?

```bash
npx skills add MoisesK/frontend-premium-skill -g -a claude-code
```

### Requirements

- **Node 22+** (the `design-taste-frontend` scripts need it), Git and npm
- Chrome, Edge or Chromium
- For the Native iOS track: Xcode with an iOS Simulator runtime
- Optional: Google Stitch MCP server + API key, for the Stitch skills (generate screens, sync designs)

## Usage

Just ask Claude Code to work on a frontend — "start the frontend", "build the dashboard",
"make this page look premium", "review my UI". The skill triggers automatically, or call it with
`/frontend-premium`.

## Credits

This repository only contains the orchestration skill and installer. All other skills are
downloaded from their original authors at install time:

| Project | Author | License |
|---|---|---|
| [taste-skill](https://github.com/Leonxlnx/taste-skill) | Leonxlnx | MIT |
| [agent-skills](https://github.com/vercel-labs/agent-skills) (web-design-guidelines) | Vercel | see repository |
| [stitch-skills](https://github.com/google-labs-code/stitch-skills) | Google | Apache-2.0 |
| [playwright-cli](https://github.com/microsoft/playwright-cli) | Microsoft | Apache-2.0 |
| [SwiftUI-Agent-Skill](https://github.com/AvdLee/SwiftUI-Agent-Skill) (swiftui-expert-skill) | Antoine van der Lee | MIT |
| [swiftui-agent-skill](https://github.com/twostraws/swiftui-agent-skill) (swiftui-pro) | Paul Hudson | MIT |

## License

[MIT](LICENSE)
