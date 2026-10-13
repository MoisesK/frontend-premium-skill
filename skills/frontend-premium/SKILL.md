---
name: frontend-premium
description: Master workflow for building market-grade frontends — premium, free of the "made by AI" look, accessible, and verified in a real browser. Orchestrates the installed design skills (taste-skill, web-design-guidelines, Google Stitch skills such as extract-design-md and shadcn-ui, and playwright-cli), telling you which one to use at each step. Use it WHENEVER you start, build, redesign, polish or review any frontend (landing page, website, dashboard, web app, screen, component) in any stack, and also when the user says "start the frontend", "build the UI", "make it look premium", "market-ready", "review my UI", "this looks AI-generated" (or in Portuguese: "começar o frontend", "fazer a interface", "deixar premium", "padrão de mercado", "revisar a UI", "tá com cara de IA"), or asks to install/set up the frontend skills kit.
---

# Frontend Premium — master workflow

This skill does not replace the others: it is the **playbook** that decides when to call each one.
Goal: every frontend ships (1) with real art direction, (2) consistent with a documented design
system, (3) accessible and correct according to best practices, and (4) **seen in a browser** before
it is called done.

If any skill referenced below is not available, run the installer (see "Installation") before
continuing.

## Rules for the whole workflow

- **Complete code, always.** Follow `full-output-enforcement`: no `// ...rest unchanged`,
  placeholders, TODOs instead of implementation, or "left as an exercise".
- **Decide, don't ask.** Vague request → state your reading in one line and proceed. Ask only when a
  missing fact blocks the work (product name, audience, mandatory brand).
- **Don't reinvent what the project has.** Before creating a token, color, font or component, look in
  the code (Tailwind theme, CSS variables, `components/ui`, `DESIGN.md`).
- **Nothing is "done" without a screenshot.** Step 6 (browser verification) is mandatory.
- **One aesthetic direction per project.** Do not mix `minimalist-ui` with `industrial-brutalist-ui`
  in the same interface; pick one and apply it consistently.

## Step 0 — Classify the work

Identify the type, because it changes which skills apply:

| Type | Examples | Main direction skill |
|---|---|---|
| **Public / marketing page** | landing, company site, product page, portfolio, hero | `design-taste-frontend` |
| **App / dashboard / internal screen** | admin panel, CRUD, tables, forms, settings, logged-in area | `high-end-visual-design` + one style (`minimalist-ui` or `industrial-brutalist-ui`) + `shadcn-ui` |
| **Redesign of something existing** | "improve this screen", "it's ugly", "it looks AI-made" | `redesign-existing-projects` (+ the skill for its type above) |
| **Mobile** | iOS/Android app, React Native | `imagegen-frontend-mobile` (reference) + `react-native` |
| **Review only** | "review my UI", "check accessibility" | jump to step 5 |

> `design-taste-frontend` explicitly states it is **not for dashboards or app screens**. Do not use
> it in those cases.

## Step 1 — Understand the project and its existing design system

1. Read the stack, `package.json`, Tailwind/theme config, UI components and any existing brand
   (logo, colors, fonts).
2. If interface code already exists and **there is no `DESIGN.md`**, run `extract-design-md` to
   generate one from the code. It becomes the project's visual source of truth.
3. For a greenfield project, create `DESIGN.md` at the end of step 2 (same structure: atmosphere,
   palette with hex and role, typography, components, layout).
4. For large or multi-page scope, use `site-md` to capture requirements in a `SITE.md`.

## Step 2 — Art direction

**Public page:** follow `design-taste-frontend` to the letter — subject inventory (8–12 things only
this client has), dealing directions with `scripts/draw.mjs`, choosing the direction, real imagery
via `scripts/assets.mjs`. For heavy motion and scroll storytelling, add `gpt-taste`.

**App / dashboard:** use `high-end-visual-design` for typography, spacing, shadows and cards, and
pick ONE style:
- `minimalist-ui` — editorial, warm monochrome, flat bento grids. Safe default for SaaS/B2B.
- `industrial-brutalist-ui` — dense, technical, rigid grid. For data products and dev tools.

**Want a visual reference before coding?** `imagegen-frontend-web` (one image per section) or
`image-to-code` (generates the image and implements from it). Only if an image-generation tool is
available in the session.

**Brand identity from scratch?** `brandkit`.

**Vague idea?** `enhance-prompt` turns "I want a nice screen for X" into a specific brief.

Record the decision (direction, palette, fonts, radius, shadows) in `DESIGN.md`.

## Step 3 — Components and implementation

- **React + shadcn/ui:** follow `shadcn-ui` (discovery, installation via CLI, customization through
  the `DESIGN.md` tokens). Avoid editing `components/ui` unless necessary; compose on top of it.
- **React + Vite dashboard:** patterns from `react-vite-dashboard` (TanStack Query, accessible tokens).
- **Componentization:** `react-components` to split into modular, validated components.
- Tokens (colors, radius, fonts, spacing) ALWAYS come from the theme/CSS variables, never loose hex
  values in JSX.
- Required states on every data screen: loading (skeleton), empty, error, success.
- Responsive from the start: mobile (375px), tablet (768px), desktop (1440px).

## Step 4 — Anti-"AI look" polish

Run the `redesign-existing-projects` checklist over what was built. Typical tells to remove: generic
purple gradient, three icon cards in a row, centered headline with a badge above it, heavy shadows on
everything, cards inside cards, emojis as icons, lorem ipsum, default fonts chosen by inertia
(Inter/Roboto), uniform spacing with no hierarchy.

## Step 5 — Quality review (accessibility and best practices)

Run `web-design-guidelines` on the changed files. Fix every accessibility finding (contrast, visible
focus, labels, alt text, keyboard navigation, `prefers-reduced-motion`) before moving on. Purely
opinionated style findings can be listed for the user instead of applied.

## Step 6 — Browser verification (mandatory)

Use `playwright-cli` (prefer it over the Playwright MCP: it uses far less context):

```bash
playwright-cli open http://localhost:<port>/<route>
playwright-cli resize 375 812   && playwright-cli screenshot
playwright-cli resize 768 1024  && playwright-cli screenshot
playwright-cli resize 1440 900  && playwright-cli screenshot
playwright-cli snapshot          # structure / accessibility tree
playwright-cli close
```

Look at each screenshot critically: hierarchy, alignment, horizontal overflow, clipped text,
contrast, states. Fix and shoot again until nothing is wrong. On public pages, also run the
`design-taste-frontend` inspector (`scripts/inspect.mjs`).

If no dev server is running, start it before this step.

## Step 7 — Delivery

Tell the user: what was done, the chosen direction and why, what the review found and fixed, and what
is still pending.

## Google Stitch integration (optional)

The skills `generate-design`, `manage-design-system`, `code-to-design`, `upload-to-stitch`,
`react-components` (Stitch mode), `react-native`, `remotion`, `stitch-loop` and `design-md` need the
**Stitch MCP server** configured. Without it, use the workflow above as usual. With it:
- generate screens from a prompt → `generate-design` (prompts improved by `enhance-prompt`);
- move existing code into Stitch → `code-to-design`;
- Stitch design → React → `react-components`;
- walkthrough video → `remotion`.

## Quick map: situation → skill

| Situation | Skill |
|---|---|
| Award-level landing/site | `design-taste-frontend` |
| GSAP motion, pinned scroll | `gpt-taste` |
| Premium app/dashboard | `high-end-visual-design` |
| Clean editorial style | `minimalist-ui` |
| Technical/brutalist style | `industrial-brutalist-ui` |
| Improve an existing screen | `redesign-existing-projects` |
| Document the design system from code | `extract-design-md` |
| DESIGN.md with premium rules for Stitch | `stitch-design-taste` |
| Site requirements | `site-md` |
| shadcn components | `shadcn-ui` |
| a11y/UX review | `web-design-guidelines` |
| Test/see it in the browser | `playwright-cli` |
| Visual reference via images | `imagegen-frontend-web`, `imagegen-frontend-mobile`, `image-to-code` |
| Visual identity | `brandkit` |
| Improve a UI prompt | `enhance-prompt` |
| Static HTML of a screen | `extract-static-html` |
| Don't truncate code | `full-output-enforcement` |

Legacy skills — **do not use** unless explicitly asked: `design-taste-frontend-v1`,
`design-taste-frontend-v2-experimental`, `taste-design` (duplicate of `stitch-design-taste`).

## Installation

To install (or reinstall on another machine) everything this workflow uses:

```bash
bash ~/.claude/skills/frontend-premium/scripts/install.sh
```

The script installs, globally (`~/.claude/skills/`):

1. **taste-skill** — `npx skills add Leonxlnx/taste-skill -g -a claude-code -y`.
2. **web-design-guidelines** (Vercel) —
   `npx skills add vercel-labs/agent-skills --skill web-design-guidelines -g -a claude-code -y`.
3. **Stitch skills** (Google) — clones `google-labs-code/stitch-skills` and copies
   `plugins/*/skills/*` into `~/.claude/skills/`.
4. **playwright-cli** (Microsoft) — copies `skills/playwright-cli` from `microsoft/playwright-cli`
   and installs the binary with `npm install -g @playwright/cli@latest`, plus Playwright's Chromium.

Requirements: **Node 22+** (the `design-taste-frontend` scripts need it; the installer warns if
older), Git, npm, and Chrome/Edge/Chromium. Optional: a Stitch API key + Stitch MCP for the Stitch
skills. Start a new Claude Code session after installing so the skills are loaded.
