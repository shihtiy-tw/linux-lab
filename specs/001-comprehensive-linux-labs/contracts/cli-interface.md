# CLI Contract: Lab Runner (`lab`)

The root-level CLI tool (`./lab`) serves as the unified entry point for all labs.

## Commands

### `run <subsystem>/<scenario>`
- **Description**: Executes the full lifecycle of a lab.
- **Flags**:
  - `--language, -l <name>`: Choose specific implementation (c, rust, go, python). Default: first available.
  - `--non-interactive`: Disable prompts and progress bars.
  - `--allow-destructive`: Required for scenarios tagged as destructive.
  - `--json`: Output metrics and results as JSON.

### `list [subsystem]`
- **Description**: Lists available scenarios.
- **Flags**:
  - `--subsystem <name>`: Filter by subsystem.
  - `--verbose`: Show detailed descriptions and available implementation languages.

### `verify <subsystem>/<scenario>`
- **Description**: Runs only the verification logic for a previously executed lab.

### `clean <subsystem>/<scenario>|all`
- **Description**: Runs the cleanup logic for a specific lab or all labs in the monorepo.

## Environment Variables

The CLI MUST pass these variables to the underlying `make` calls:
- `LAB_DEBUG`: Enable verbose logging.
- `LAB_OUTPUT_DIR`: Directory to store traces and artifacts.
- `LAB_IFACE`: Target network interface (if applicable).
