# Lifecycle Contract: Scenario Interface

Every lab scenario MUST implement the following `Makefile` targets to ensure consistency across the polyglot environment.

## Targets

### `init`
- **Pre-requisite**: None.
- **Action**: Verifies environment (kernel version, root privileges, dependencies). Creates necessary namespaces or dummy interfaces.
- **Idempotency**: If the environment is already prepared, it must exit successfully without changes.

### `build`
- **Pre-requisite**: `init`.
- **Action**: Compiles source code (C, Rust, Go) and eBPF objects.
- **Output**: Binaries should be placed in the local `bin/` directory within the scenario.

### `run`
- **Pre-requisite**: `build`.
- **Action**: Executes the lab workload. 
- **Requirements**:
  - MUST respect environment variables for configuration (e.g., `DURATION`, `LOAD`).
  - MUST use `trap` to ensure `clean` is called on interrupt or failure.
  - SHOULD output structured data (JSON) to `stdout` or a file.

### `verify`
- **Pre-requisite**: `run`.
- **Action**: Asserts that the lab produced the expected kernel side-effects. 
- **Output**: Exit code 0 for success, non-zero for failure. Prints a summary of findings.

### `clean`
- **Pre-requisite**: None.
- **Action**: Reverts all system changes made during `init` or `run`.
- **Idempotency**: Must succeed even if called multiple times or on a clean system.
