# Alfie Flutter - AI Agent System

This file follows the [AGENTS.md standard](https://agents.md/) and contains essential project context for AI coding assistants.

---

## AI Agents

Alfie uses specialized AI agents for different development tasks. All agents are defined in `.ai/agents/` using standard markdown with YAML frontmatter, making them compatible with any AI coding assistant.

### Available Agents

| Agent | Purpose | File |
|-------|---------|------|
| `feature-orchestrator` | Coordinate full feature development lifecycle | `.ai/agents/feature-orchestrator.agent.md` |
| `spec-writer` | Create comprehensive feature specifications | `.ai/agents/spec-writer.agent.md` |
| `graphql-specialist` | GraphQL queries, mutations, graphql_codegen | `.ai/agents/graphql-specialist.agent.md` |
| `feature-developer` | Riverpod + MVVM Flutter feature implementation | `.ai/agents/feature-developer.agent.md` |
| `localization-specialist` | String externalization and localization readiness | `.ai/agents/localization-specialist.agent.md` |
| `testing-specialist` | Unit and widget tests with mocktail | `.ai/agents/testing-specialist.agent.md` |
| `security-specialist` | Security audits and vulnerability identification | `.ai/agents/security-specialist.agent.md` |

### Usage

AI tools should read the agent definition from `.ai/agents/<agent-name>.agent.md` and follow the instructions within.

**Example:**
```
Acting as the feature-developer agent (see .ai/agents/feature-developer.agent.md),
implement the Product Details feature following the spec in Docs/Specs/Features/ProductDetails.md
```

---

## Project Essentials

**Alfie** is a multi-brand e-commerce application built with:
- **Flutter/Dart** (latest stable)
- **MVVM Architecture** with Riverpod Notifier pattern
- **GoRouter 17.0.1** for navigation
- **GraphQL BFF API** (graphql_flutter 5.2.1)

### Core Technologies

- Flutter SDK (latest stable) / Dart (latest stable)
- Riverpod 3.2.0 — `Notifier` pattern with `NotifierProvider.autoDispose`
- GoRouter 17.0.1 — tab-based shell routing with Route Registry
- graphql_flutter 5.2.1 + graphql_codegen 3.0.1
- Hive 2.2.3 — local persistence
- mocktail 1.0.4 — mocking for tests
- flutter_lints 6.0.0 + riverpod_lint

---

## Critical Rules

### ✅ ALWAYS

- Use `Notifier<State>` + `NotifierProvider.autoDispose` for ViewModels
- Use `AsyncValue` for all async state (loading/data/error)
- Use `HookConsumerWidget` for screens; `ref.watch()` in build, `ref.read()` in callbacks
- Use `AppColors`, `AppTypography`, `AppSpacing` — never raw values
- Use Riverpod providers for all dependency injection (no `get_it`)
- Keep ViewModels free of `BuildContext`
- Use immutable state classes with `copyWith`
- Run `flutter analyze && flutter test` after every code change

### ❌ NEVER

- Use `setState()` or `ChangeNotifier`
- Use `get_it` or service locators
- Hardcode colors, typography, or spacing
- Edit generated files (`*.g.dart`, `*.graphql.dart`)
- Pass `BuildContext` to ViewModels
- Store secrets in source code
- Use `dynamic` types
- Use mutable state objects
- Ignore `flutter analyze` warnings

---

## Verification (MANDATORY)

**Every code change MUST be verified:**

```bash
flutter analyze && flutter test
```

Only mark work complete after both commands pass with no errors or warnings.

---

## Detailed Documentation

When you need specific guidance, read the appropriate guide:

| Topic | Guide |
|-------|-------|
| Architecture & MVVM | `Docs/Architecture.md` |
| Navigation (GoRouter) | `Docs/Navigation.md` |
| GraphQL Integration | `Docs/GraphQL.md` |
| Localization | `Docs/Localization.md` |
| Testing | `Docs/Testing.md` |
| Build & CI/CD | `Docs/Development.md` |
| Code Style & Conventions | `Docs/CodeStyle.md` |
| Quick Reference | `Docs/QuickReference.md` |

---

## How to Use This Documentation

### For Developers

**Quick start:**
1. Read this file (AGENTS.md) for core rules
2. Consult specific guides in `Docs/` as needed
3. Use `Docs/QuickReference.md` for commands and directory structure

**Common scenarios:**
- **New to project?** Start with `Docs/Architecture.md`
- **Implementing a feature?** Follow `Docs/Development.md`
- **Adding GraphQL?** See `Docs/GraphQL.md`
- **Need a quick lookup?** Use `Docs/QuickReference.md`

### For AI Agents

AI agents automatically read AGENTS.md and load detailed guides on-demand based on task context.

**Agent workflow:**
1. Load AGENTS.md (core rules)
2. Identify task type
3. Load relevant guide (e.g., `Docs/GraphQL.md` for API work)
4. Execute task following guidelines

---

**This minimal document provides core context. Read detailed guides only when needed for specific tasks.**
