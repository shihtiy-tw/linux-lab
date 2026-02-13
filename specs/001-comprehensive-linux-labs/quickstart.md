# Quickstart: Comprehensive Linux Labs

Welcome to the Linux Lab! This guide will get you started with your first system exploration.

## 1. Prerequisites

Ensure your host meets these requirements:
- **Kernel**: 5.15 or newer.
- **Privileges**: Root/Sudo access is required for most labs.
- **Tools**: `build-essential`, `clang`, `llvm`, `pkg-config`, `libbpf-dev`, `bpftool`.

## 2. Environment Setup

Clone the repo and initialize the shared components:

```bash
# Initialize shared eBPF artifacts
make -C shared/bpf build
```

## 3. Running Your First Lab

Let's explore CPU scheduler latency:

```bash
# List available CPU labs
./lab list cpu

# Run the scheduler latency lab using the C implementation
./lab run cpu/scheduler-latency --language c
```

## 4. Understanding Output

Each lab will provide:
1. **Interactive Console**: Real-time progress and summary.
2. **Metrics**: Structured data (JSON) in `output/results.json`.
3. **Traces**: (If enabled) eBPF or `perf` traces in `output/traces/`.

## 5. Cleaning Up

The lab runner automatically cleans up after execution. If you need to force a cleanup:

```bash
./lab clean cpu/scheduler-latency
# Or cleanup everything
./lab clean all
```
