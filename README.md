# linux-lab

Standardized monorepo for learning and mastering Linux OS internals, performance tuning, and system observability.

## 🎯 Learning Objectives

*   **CPU**: Deep dive into scheduling algorithms, cache hierarchy, and interrupt handling.
*   **Memory**: Mastery of virtual memory, page allocation, and swap performance.
*   **Networking**: Understanding the TCP/IP stack, netfilter, and high-performance socket I/O.
*   **Storage**: Exploring filesystem internals, block layer scheduling, and RAID/LVM.
*   **GPU**: Basic monitoring and utilization patterns for compute workloads.
*   **Observability**: Leveraging eBPF, perf, and tracing tools for real-time analysis.
*   **Performance**: Systematic benchmarking and profiling of Linux subsystems.

## 🛠️ Technology Focus

*   **Languages**: C (Kernel/Low-level), Go, Rust, Python.
*   **Tooling**: eBPF (bcc, bpftrace), perf, ftrace, systemtap.
*   **Compliance**: 12-Factor CLI and Agent standards.

## 🏗️ Structure

```
linux-lab/
├── cpu/             # CPU-specific scenarios
├── memory/          # Memory management labs
├── networking/      # Network stack explorations
├── storage/         # Storage and IO tests
├── gpu/             # GPU monitoring tools
├── observability/   # eBPF and tracing scripts
├── performance/     # Benchmarking suites
├── troubleshooting/ # Debugging scenarios
└── shared/          # Common library code
```

## 🚀 Quick Start

1.  **Read the Context**: Review [AGENTS.md](AGENTS.md) for available commands.
2.  **Explore Scenarios**: Each module contains its own `README.md` with specific labs.
3.  **Run Tools**: Use the `.opencode/command` utilities for common operations.

## ⚖️ Governance

This lab follows the **Spec 008 (Lab Governance)** protocol. All new features and scenarios are developed using the spec-driven workflow.

---
**Current Focus**: Initialization
**Last Updated**: 2026-02-09
