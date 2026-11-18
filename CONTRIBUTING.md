# Contributing

Thank you for helping improve the Flutter Material 3 Default standard. This
guide applies equally to human contributors and AI coding agents.

## Ground rules

1. Read [`AGENTS.md`](AGENTS.md). It is the authoritative standard.
2. Keep every change **Material 3**, **fully responsive** and **documented**.
3. Keep the foundation small and dependency-light. Propose new dependencies in
   an issue first.

## Development setup

```bash
git clone https://github.com/Abdiaziiz09/flutter-material3-default.git
cd flutter-material3-default
./tool/bootstrap.sh          # or .\tool\bootstrap.ps1 on Windows
```

## Workflow

1. Create a branch: `feature/<short-description>` or `fix/<short-description>`.
2. Make focused changes that follow the project structure in
   [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).
3. Add or update tests.
4. Run the quality commands:

   ```bash
   dart format .
   flutter analyze
   flutter test
   ```

5. Complete [`docs/AGENT_CHECKLIST.md`](docs/AGENT_CHECKLIST.md).
6. Update [`CHANGELOG.md`](CHANGELOG.md) for user-visible changes.
7. Open a pull request using the template.

## Commit messages

Use the [Conventional Commits](https://www.conventionalcommits.org/) style:

```text
feat(layout): add permanent navigation drawer for large windows
fix(theme): correct dark scheme surface tint
docs: clarify breakpoint usage
```

## Pull request requirements

- CI is green (format, analyze, test).
- No hard-coded colours, font sizes or magic spacing numbers.
- No layout overflow at 320 px, 600 px, 840 px and 1200 px widths.
- Every new public member has a `///` doc comment.
- Names are meaningful and follow
  [`docs/NAMING_CONVENTIONS.md`](docs/NAMING_CONVENTIONS.md).
