# linux-lab Agent Context

**Domain**: Linux OS Internals, Performance, and Observability  
**Location**: `/home/yst/Brainiverse/Brainiverse/Effort/Projects/Cultivation/Labs/Repositories/linux-lab`  
**Type**: Monorepo (Deep Dive OS)

---

## Current Focus

> 🎯 **Initialization → Setting up OS learning modules**

---

## YOU ARE HERE

```
linux-lab/
├── cpu/             # CPU scheduling, affinity, frequency scaling
├── memory/          # Virtual memory, paging, swap, hugepages
├── networking/      # TCP/IP stack, socket programming, netfilter
├── storage/         # I/O schedulers, file systems, RAID, LVM
├── gpu/             # GPU utilization and monitoring
├── observability/   # eBPF, perf, ftrace, strace, bcc-tools
├── performance/     # Benchmarking, profiling, optimization
├── troubleshooting/ # Systemic debugging scenarios
└── shared/          # Common C/Go/Rust/Python utilities
```

---

## Structure

| Directory | Purpose | Stack |
|-----------|---------|-------|
| `cpu/` | CPU internals | C, Go, Rust |
| `memory/` | Memory management | C, Go, Rust |
| `networking/` | Networking stack | C, eBPF, Go |
| `storage/` | Disk and Filesystems | C, Shell |
| `observability/` | Tracing and Metrics | eBPF, Python, Go |
| `performance/` | Analysis and Tuning | perf, bcc, bpftrace |

---

## Quick Start

```bash
# Verify 12-factor compliance
./verify.sh --help

# Run a scenario (example)
cd cpu/scenarios/scheduler-latency
./run.sh
```

---

## Lab Sessions

| Date | Focus | Notes |
|------|-------|-------|
| 2026-02-09 | Initial setup | Created structure and governance |

---

## Context Sources

- `.specify/` - Speckit specs and plans
- `.opencode/command/` - Specialized Linux workflows
- `shared/` - Reusable primitives

---

## 12-Factor Compliance

- **CLI**: Standardized flags, help, versioning
- **Scripts**: Idempotent setup and cleanup
- **Observability**: Consistent logging and metric formats

---

## Commands

See: `.opencode/command/*.md` for lab management

### Speckit (Spec-Driven Workflow)
- `speckit.specify`     # Create new specifications
- `speckit.plan`        # Create implementation plans
- `speckit.tasks`       # Generate task lists
- `speckit.taskstovibe` # Sync tasks to Vibe Kanban
- `speckit.implement`   # Execute implementation

### Linux Operations
- `linux.trace`         # Trace system events (eBPF)
- `linux.profile`       # Profile CPU/Memory usage
- `linux.bench`         # Run performance benchmarks

---

## Safety Rules

- Always backup before destructive operations
- Require confirmation for:
  - Kernel parameter changes (sysctl)
  - Destructive storage operations (fdisk, mkfs)
  - Network configuration changes
- Use dry-run modes when profiling production-like workloads
