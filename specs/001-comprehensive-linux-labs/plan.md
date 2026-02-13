# Implementation Plan: Comprehensive Linux Labs

**Branch**: `001-comprehensive-linux-labs` | **Date**: 2026-02-12 | **Spec**: [specs/001-comprehensive-linux-labs/spec.md](spec.md)
**Input**: Feature specification from `/specs/001-comprehensive-linux-labs/spec.md`

## Summary

This feature implements a comprehensive, polyglot lab environment for mastering Linux OS internals. It provides modular scenarios across all major subsystems (CPU, Memory, Networking, Storage, GPU, Containers, Security) using C, Rust, Go, and Python. The implementation follows 12-factor principles, ensuring idempotent setup/cleanup and deep observability via eBPF, perf, and ftrace.

## Technical Context

**Language/Version**: C (Clang 15+), Rust (1.75+), Go (1.21+), Python (3.10+)
**Primary Dependencies**: libbpf, bpftool, perf, ftrace, gdb, tcpdump, flamegraph
**Storage**: N/A (mostly system-level probing)
**Testing**: pytest (Python), cargo test (Rust), go test (Go), unity/cmocka (C)
**Target Platform**: Linux 5.15+ (Kernel)
**Project Type**: Monorepo
**Performance Goals**: Minimal overhead (<5% CPU) from observability tools during benchmarks.
**Constraints**: 12-factor compliance (idempotency), root privileges required for most labs.
**Scale/Scope**: 50+ scenarios across 9 subsystems.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **Subsystem Isolation**: Labs must not pollute host state. (Handled via namespaces/unshare).
- [x] **Polyglot Consistency**: Labs must provide similar behavior across languages. (Handled via shared eBPF and unified Makefile interface).
- [x] **Observability**: Every lab must produce verifiable traces or metrics. (Handled via SC-005 in spec).

## Project Structure

### Documentation (this feature)

```text
specs/001-comprehensive-linux-labs/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output
└── tasks.md             # Phase 2 output (future)
```

### Source Code (repository root)

```text
linux-lab/
├── bin/                    # Lab runner CLI (lab)
├── shared/                 # Reusable components
│   ├── bpf/                # Shared eBPF C programs
│   ├── build/              # Compiled eBPF objects (.o)
│   ├── include/            # Shared C headers
│   └── scripts/            # Common 12-factor helpers
├── cpu/                    # CPU Subsystem
│   └── scenarios/          # Specific labs (e.g., scheduler-latency)
├── memory/                 # Memory Subsystem
├── networking/             # Networking Subsystem
├── storage/                # Storage Subsystem
├── containers/             # Container Internals (Namespaces, Cgroups)
├── gpu/                    # GPU Subsystem
├── security/               # Security Subsystem (AppArmor, SELinux)
├── observability/          # General Tracing/Monitoring labs
├── performance/            # Benchmarking suites
└── troubleshooting/        # Real-world debugging scenarios
```

**Structure Decision**: Subsystem-centric organization with nested scenarios. Each scenario directory contains a `Makefile` enforcing the lifecycle targets. Shared artifacts (eBPF objects) are centralized to avoid duplication.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| Cross-language eBPF | Essential for comparing different loaders. | Language-specific BPF code is harder to maintain and inconsistent. |
| Namespace Isolation | Required for 12-factor compliance on a singleton host kernel. | Direct host modification is too risky and lacks idempotency. |
