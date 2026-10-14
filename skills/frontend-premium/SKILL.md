---
name: frontend-premium
description: >-
  Master workflow for building market-grade frontends — premium, free of the "made by AI" look, accessible, and verified in a real browser. Orchestrates the installed design skills (taste-skill, web-design-guidelines, Google Stitch skills such as extract-design-md and shadcn-ui, and playwright-cli), telling you which one to use at each step. Use it WHENEVER you start a new project from scratch, scaffold, build, redesign, polish or review any frontend (landing page, website, dashboard, web app, screen, component) in any stack — including native iOS apps in SwiftUI — and also when the user says "start the frontend", "new project from scratch", "build the UI", "make it look premium", "market-ready", "review my UI", "this looks AI-generated" (or in Portuguese: "começar o frontend", "fazer a interface", "deixar premium", "padrão de mercado", "revisar a UI", "tá com cara de IA"), when working on SwiftUI / iOS app screens ("app iOS", "tela em SwiftUI"), or asks to install/set up the frontend skills kit.
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
- **Nothing is "done" without a screenshot.** Step 6 (browser verification) is mandatory — on the
  Native iOS track, its Simulator verification step is.
- **One aesthetic direction per project.** Do not mix `minimalist-ui` with `industrial-brutalist-ui`
  in the same interface; pick one and apply it consistently.

## Step 0 — Classify the work

Identify the type, because it changes which skills apply:

| Type | Examples | Main direction skill |
|---|---|---|
| **Public / marketing page** | landing, company site, product page, portfolio, hero | `design-taste-frontend` |
| **App / dashboard / internal screen** | admin panel, CRUD, tables, forms, settings, logged-in area | `high-end-visual-design` + one style (`minimalist-ui` or `industrial-brutalist-ui`) + `shadcn-ui` |
| **Redesign of something existing** | "improve this screen", "it's ugly", "it looks AI-made" | `redesign-existing-projects` (+ the skill for its type above) |
| **Native iOS (SwiftUI)** | iPhone/iPad app, Xcode project, `.swift` views | **Follow the "Native iOS track"** below: `swiftui-expert-skill` (build) + `swiftui-pro` (review) |
| **Cross-platform mobile** | one codebase for iOS + Android, React Native, Expo | `imagegen-frontend-mobile` (reference) + `react-native` |
| **Review only** | "review my UI", "check accessibility" | jump to step 5 |

A project with an `.xcodeproj`/`Package.swift` and SwiftUI views is **Native iOS**: skip steps 1b–6
(they are web-specific) and use the Native iOS track instead. Native Android (Kotlin/Jetpack Compose)
is not covered by this kit — say so and, if the user wants both platforms from one codebase, propose
Expo + React Native.

Then check whether the project **exists**. No `package.json` / empty folder / "start from scratch"
→ it is **greenfield**: do step 1b before anything else. Classification above still applies (it
decides the stack in 1b).

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

## Step 1b — Project foundation (greenfield only)

Goal: a project that starts the same professional way every time, so every screen built later
inherits correct tooling, structure, theming, data handling and accessibility. The foundation is
**done before the first real screen** — never scaffold and build features in the same pass.

### 1b.1 — Ask only what blocks

Ask the user in ONE message, with a recommended answer for each, only for what you cannot infer:
- Product name and one-line purpose.
- Is there a **public site** (needs SEO), a **logged-in app**, or both?
- Is there a **backend/API** already? Its base URL, auth style (cookie session, JWT/bearer, OAuth
  provider) and whether it has an OpenAPI spec.
- Language(s) and locale of the UI (e.g. `pt-BR` only, or i18n from day one).
- Any mandatory brand assets (logo, colors, fonts) or a preferred stack.

Everything else follows the defaults below. State the chosen defaults in one line; don't ask.

### 1b.2 — Choose the stack

| Situation | Default stack |
|---|---|
| Logged-in app / dashboard, separate backend, no SEO needs | **Vite + React + TypeScript + React Router** (SPA) |
| Public site with SEO **and/or** app in the same codebase, or server rendering needed | **Next.js (App Router) + TypeScript** |
| Content-heavy marketing site, little interactivity | **Astro** (+ React islands if needed) |
| Cross-platform mobile (iOS + Android) | Expo + React Native (follow `react-native`) |
| Native iOS only | Xcode + SwiftUI — see "Native iOS track" (no Tailwind/shadcn/pnpm) |

Always: TypeScript in `strict` mode, Tailwind CSS v4, shadcn/ui, pnpm (fall back to npm if pnpm is
not installed), Node LTS ≥ 22. Respect the user's stack if they named one.

### 1b.3 — Scaffold

Use the shadcn CLI, which scaffolds the framework already wired with Tailwind and shadcn/ui:

```bash
npx shadcn@latest init -t vite      # or: -t next | -t astro | -t react-router | -t start
```

Run it in the target folder (it must be empty or only contain docs). If the CLI prompts for a base
color/preset, pick neutral — the real palette comes from step 2. Then verify `dev`, `build` and
`lint` run cleanly before adding anything.

### 1b.4 — Baseline dependencies

Install only what the classification needs; these are the defaults:

| Concern | Default | Notes |
|---|---|---|
| Server state / data fetching | `@tanstack/react-query` | Never hand-roll fetch + `useEffect` caching |
| Routing (Vite) | `react-router` | Next/Astro use their own router |
| Forms + validation | `react-hook-form` + `zod` + `@hookform/resolvers` | Same zod schemas validate API responses |
| Icons | `lucide-react` | No emoji as icons |
| Toasts | `sonner` (via `npx shadcn@latest add sonner`) | |
| Dates / numbers | native `Intl` (+ `date-fns` only if real date math is needed) | Locale from 1b.1 |
| Fonts | `@fontsource-variable/*` (Vite/Astro) or `next/font` (Next) | Self-hosted; no Google Fonts `<link>` |
| Tables (if data-heavy) | `@tanstack/react-table` via the shadcn data-table pattern | |
| Charts (if needed) | shadcn `chart` (Recharts) | Follow the project's dataviz rules |

Do not add a global state library (Redux, Zustand) up front. Server state lives in React Query, UI
state stays local; add Zustand only when a real cross-tree client state appears.

### 1b.5 — Tooling and quality gates

- ESLint (from the template) + **Prettier** with `prettier-plugin-tailwindcss` (class sorting).
- `tsconfig`: `strict: true`, `noUncheckedIndexedAccess: true`, path alias `@/*` → `src/*`.
- Scripts in `package.json`: `dev`, `build`, `preview`/`start`, `lint`, `typecheck` (`tsc --noEmit`),
  `format`, `test`.
- Tests: **Vitest** + **Testing Library** for units/components; `playwright-cli` for visual checks
  (step 6) and `@playwright/test` only when the user wants an e2e suite.
- `.env.example` committed with every variable the app reads (e.g. `VITE_API_URL` /
  `NEXT_PUBLIC_API_URL`); real `.env*` files in `.gitignore`. Env access goes through one typed module
  (`src/lib/env.ts`, validated with zod) — never `import.meta.env.X` scattered around.
- `.editorconfig`, `.nvmrc` with the Node version.

### 1b.6 — Folder structure

Feature-based, so the project scales without a giant `components/` dump (Vite shown; in Next.js the
same folders live under `src/` next to `app/`):

```
src/
  app/                 # app shell: providers, router, root layout, error boundary
    providers.tsx      # QueryClientProvider, ThemeProvider, Toaster
    router.tsx         # route table (Vite) — Next uses app/ directory routing
  components/
    ui/                # shadcn components (generated; compose, don't fork)
    layout/            # AppShell, Sidebar, Topbar, PageHeader, EmptyState, ErrorState
  features/
    <feature>/         # e.g. auth, billing, users
      api.ts           # query/mutation hooks for this feature
      schemas.ts       # zod schemas + inferred types
      components/      # feature-only components
      pages/           # route-level screens
  lib/
    api-client.ts      # the ONLY place that calls fetch
    env.ts             # typed, validated env
    query-client.ts    # React Query defaults
    format.ts          # Intl formatters (currency, date, number) for the app locale
    utils.ts           # cn() from shadcn
  styles/
    globals.css        # Tailwind + theme tokens
  hooks/               # cross-feature hooks only
```

Rules: features never import from other features' internals (share through `components/` or
`lib/`); route-level components live in `pages/`; one component per file.

### 1b.7 — Theme foundation

- All design tokens are CSS variables in `globals.css` (colors with semantic names — `--background`,
  `--foreground`, `--primary`, `--muted`, `--destructive`, `--border`, `--ring`, plus `--radius` and
  font families), exposed to Tailwind through `@theme`. Components use only semantic classes
  (`bg-primary`, `text-muted-foreground`), never raw hex or palette classes like `bg-blue-500`.
- Wire the tokens now with neutral values; **step 2 decides the real values** and writes them both
  to `globals.css` and `DESIGN.md`.
- Decide dark mode now: either support it from day one (`.dark` token set + theme toggle) or
  explicitly don't — retrofitting later is expensive.
- Set the base type scale and font loading here so every screen inherits it.

### 1b.8 — App shell and cross-cutting behavior

Build these before any feature screen:
- **Providers:** React Query (sensible defaults: `staleTime` ~30s, `retry: 1`, no refetch on window
  focus for admin apps), theme, toaster.
- **API client** (`lib/api-client.ts`): base URL from `env`, JSON handling, auth (credentials for
  cookie sessions or bearer token injection), one normalized `ApiError` type, 401 → redirect to
  login / session refresh. If the backend has an OpenAPI spec, generate types from it
  (`openapi-typescript`) instead of writing them by hand.
- **Routing:** layout routes (public vs. authenticated), protected-route guard, 404 page, error page
  / error boundary per route, lazy-loaded route chunks.
- **Shared states:** `PageSkeleton`, `EmptyState`, `ErrorState` components used by every data screen.
- **Accessibility baseline:** `<html lang>` set to the UI locale, skip-to-content link, visible focus
  ring from `--ring`, landmark elements (`header`, `nav`, `main`), page `<title>` per route.
- **Public pages (Next/Astro):** metadata per page, Open Graph image, `robots`, `sitemap`, favicon set.

### 1b.9 — Foundation done when

- `dev`, `build`, `lint`, `typecheck` and `test` all pass with zero errors.
- The app shell renders a placeholder home and the 404 page, verified with `playwright-cli` at 375 and
  1440 px (no horizontal scroll, focus ring visible on Tab).
- `README.md` documents: stack, how to run, scripts, env variables, folder structure.
- Git initialized with a first commit (ask before pushing anywhere).

Then continue to step 2 (art direction) and step 3 (screens).

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

## Native iOS track (SwiftUI)

Same goals as the web workflow (real direction, documented design system, accessible, **seen running**
before "done"), with the SwiftUI skills from the community:

- **`swiftui-expert-skill`** (Antoine van der Lee) — the **builder**: data flow, view composition,
  performance, lists, navigation, animation, layout, Instruments traces. Its Topic Router points to one
  reference per subject; load only the ones the task touches.
- **`swiftui-pro`** (Paul Hudson) — the **reviewer**: an ordered review (deprecated API → views → data
  flow → navigation → HIG design → resizability → accessibility → localization → performance → Swift →
  hygiene), findings by file with before/after fixes.

### iOS rules (from both skills)

- **Check the deployment target first.** Use newer APIs only when the target supports them or behind
  `#available` with a sensible fallback. Never change the target on your own.
- **Modern Swift**: Swift 6 strict concurrency, `@Observable` + `@State`/`@Bindable` (iOS 17+), no
  `ObservableObject` in new code unless the target requires it.
- **SwiftUI first**: no UIKit/AppKit bridging unless needed or requested; **no third-party
  frameworks without asking**.
- **One type per file**, folders by feature (same idea as `features/` on the web).
- **Each `View` is an invalidation boundary**: give it only the data it reads; extract subviews early.
- **Don't impose an architecture** (MVVM, TCA, VIPER); keep business logic out of views for testability.
- **Hard-deprecated API → replace. Soft-deprecated → flag only**, unless the user asked for a migration.
  During feature work, list unrelated modernization separately instead of applying it.
- **Liquid Glass only when the user asks for it.**
- Performance optimizations are suggestions, not requirements — unless a trace proves the problem.

### iOS steps

1. **Understand** — read the deployment target, Swift version, folder structure, Asset Catalog
   (colors, images) and any existing design. No `DESIGN.md`? Write one from the code (palette as named
   colors with light/dark values, type scale using Dynamic Type text styles, spacing, corner radius,
   SF Symbols in use).
2. **Foundation (greenfield)** — Xcode project with the latest stable iOS as target (unless the user
   needs older), Swift 6, folders by feature (`Features/<Name>/Views`, `Models`, `Services`),
   `DesignSystem/` with semantic colors from the Asset Catalog (`Color("Surface")`, never literal RGB in
   views), a networking layer (`URLSession` + `Codable` + `async/await`, one error type) and a mock
   service so every screen runs offline. Lint with `swift-format` if the project uses it.
3. **Art direction** — Apple HIG, not web patterns: native navigation (`NavigationStack`,
   `NavigationSplitView` on iPad/large displays, `TabView`), system materials, SF Symbols, Dynamic Type
   text styles instead of fixed point sizes. Use `swiftui-pro`'s `references/design.md` and
   `imagegen-frontend-mobile` for a visual reference if an image tool is available. The anti-"AI look"
   checklist of step 4 still applies (no gradient blobs, cards inside cards, emoji as icons).
4. **Build** — follow `swiftui-expert-skill`'s "Implement new SwiftUI feature" workflow: design data
   flow first (owned vs injected state), `Button` for everything tappable, accessibility labels and
   grouping, stable `ForEach` identity. Every screen has loading, empty, error and success states and a
   `#Preview` per state with self-contained mock data. Pass its **Correctness Checklist** before moving
   on (private `@State`, `.animation(_:value:)` with `value`, no `.indices` in `ForEach`, …).
5. **Review** — run `swiftui-pro` on the changed files (replaces `web-design-guidelines`). Fix every
   accessibility finding (VoiceOver labels, Dynamic Type, Reduce Motion, contrast) and every
   deprecated API; list purely stylistic findings for the user.
6. **Simulator verification (mandatory)** — build and look at it running:

   ```bash
   xcrun simctl list devices available                      # pick an iPhone and an iPad
   xcodebuild -scheme <App> -destination 'platform=iOS Simulator,name=<iPhone>' build
   xcrun simctl boot "<iPhone>" && open -a Simulator
   xcrun simctl install booted <path/to/App.app> && xcrun simctl launch booted <bundle.id>
   xcrun simctl io booted screenshot iphone-light.png
   xcrun simctl ui booted appearance dark && xcrun simctl io booted screenshot iphone-dark.png
   xcrun simctl ui booted content_size accessibility-extra-extra-extra-large \
     && xcrun simctl io booted screenshot iphone-xxxl.png
   ```

   Repeat on an iPad (and landscape / split view when the app supports it). Look for clipped or
   truncated text at large Dynamic Type sizes, safe-area problems, broken dark mode and layouts that
   don't adapt. Run the unit tests (`xcodebuild test`). For performance complaints, record and analyse
   an Instruments trace with `swiftui-expert-skill` (SwiftUI template on a real device or the Mac; Time
   Profiler on the Simulator).
7. **Delivery** — same as step 7, plus the deployment target used and any `#available` fallbacks.

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
| New project from scratch (stack, scaffold, structure) | Step 1b + `shadcn-ui` |
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
| SwiftUI screen / iOS feature (build) | `swiftui-expert-skill` |
| SwiftUI code review | `swiftui-pro` |
| SwiftUI performance / Instruments trace | `swiftui-expert-skill` (trace workflow) |
| Cross-platform mobile app | Expo + `react-native` |
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
5. **SwiftUI skills** —
   `npx skills add https://github.com/avdlee/swiftui-agent-skill --skill swiftui-expert-skill -g -a claude-code -y`
   (Antoine van der Lee) and
   `npx skills add https://github.com/twostraws/swiftui-agent-skill --skill swiftui-pro -g -a claude-code -y`
   (Paul Hudson).

Requirements: **Node 22+** (the `design-taste-frontend` scripts need it; the installer warns if
older), Git, npm, and Chrome/Edge/Chromium. Optional: a Stitch API key + Stitch MCP for the Stitch
skills; Xcode (with an iOS Simulator runtime) for the Native iOS track. Start a new Claude Code session after installing so the skills are loaded.
