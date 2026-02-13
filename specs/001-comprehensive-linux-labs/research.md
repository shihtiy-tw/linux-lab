# Research: Comprehensive Linux Labs Implementation

## Decision: Project Structure & Lifecycle

### Choice: Domain-First Polyglot Structure
**Decision**: Scenarios will be organized by subsystem (domain) rather than programming language. Each scenario will reside in its own directory under the subsystem (e.g., `cpu/scenarios/scheduler-latency/`) and may contain multiple implementations (e.g., `c/`, `rust/`, `go/`, `python/`).

**Rationale**: 
- High-level concepts are subsystem-specific. 
- Comparing different language implementations for the same kernel behavior is a core learning goal.
- Standardizes the entry point for users regardless of the implementation language.

**Alternatives Considered**: 
- **Language-First**: `c/cpu/`, `rust/cpu/`. Rejected because it fragments related subsystem labs.
- **Flat Scenario List**: `scenarios/cpu-scheduler/`. Rejected as it becomes unwieldy with many scenarios.

### Choice: Standardized Makefile Lifecycle
**Decision**: Every scenario directory will contain a `Makefile` implementing five targets: `init`, `build`, `run`, `verify`, and `clean`.

**Rationale**:
- Provides a technology-agnostic interface for users and automation.
- Enforces 12-factor compliance (idempotent setup/cleanup).
- `make` is ubiquitous in Linux systems programming.

### Choice: BTF-Enabled Shared eBPF
**Decision**: Kernel-side eBPF C code will be centralized in `shared/bpf/` and compiled into BTF-enabled ELF objects (`.o`). Userspace loaders in Go, Rust, and Python will load these pre-compiled objects.

**Rationale**:
- Avoids code duplication across loaders.
- Reduces runtime dependencies (no need for `clang` or kernel headers on the target system for CO-RE).
- Simplifies cross-language development.

## Decision: Technology & Integration

### Choice: Container Internals Lab (New Subsystem)
**Decision**: A new `containers/` subsystem will be added to cover Namespaces, Cgroups, runc, and containerd.

**Rationale**: Containers are a significant part of modern Linux usage and were explicitly requested. They don't fit perfectly into a single existing subsystem.

### Choice: Isolation via Namespaces
**Decision**: Labs that modify global kernel state (networking, sysctls) will be executed within isolated namespaces using `unshare` where possible.

**Rationale**: 
- Protects the host system from accidental misconfiguration.
- Allows multiple labs to run concurrently if needed.
- Aligns with 12-factor isolation principles.

## Resolved Clarifications (from Technical Context)

- **Language/Version**: Clang (C11), Rust (1.75+), Go (1.21+), Python (3.10+).
- **Target Platform**: Linux 5.15+ (for CO-RE support).
- **Metric Format**: JSON for structured data, Human-readable text for interactive CLI.
- **Security Labs**: Will be integrated into relevant subsystems (e.g., `networking/security`, `storage/encryption`) and a dedicated `security/` directory for general topics (AppArmor, SELinux).

## Needs Clarification

1. **GPU Lab Prerequisites**: Do we assume a specific GPU vendor (NVIDIA/AMD) and driver stack (CUDA/ROCm) is available?
2. **Boot Process Tracing**: Should we focus on `initrd` and `systemd` tracing or low-level UEFI/BIOS handoff (which may require VM/QEMU)?
3. **Hardware for Troubleshooting**: Are there specific hardware troubleshooting scenarios (e.g., EDAC, SMART) that require physical hardware access or can we simulate them?
