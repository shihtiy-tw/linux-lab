# Data Model: Comprehensive Linux Labs

## Lab Entities

### Lab Subsystem
Represents a major area of the Linux kernel or system.
- **Name**: (string) e.g., "CPU", "Memory".
- **Path**: (string) root-relative path (e.g., `cpu/`).
- **Description**: (string) overview of the subsystem.
- **Scenarios**: (list of LabScenario)

### Lab Scenario
A specific experiment or troubleshooting case.
- **Name**: (string) e.g., "scheduler-latency".
- **Path**: (string) subsystem-relative path (e.g., `scenarios/scheduler-latency/`).
- **Description**: (string) what the scenario demonstrates.
- **Languages**: (list of enum) [C, Rust, Go, Python].
- **Tools**: (list of string) e.g., ["ebpf", "perf"].
- **Complexity**: (enum) [Low, Medium, High].
- **Destructive**: (boolean) if true, requires explicit confirmation.

### Lifecycle State
The current execution state of a lab scenario.
- **State**: (enum) [Uninitialized, Ready, Running, Completed, Cleaned].
- **LastResult**: (enum) [Pass, Fail, Error].
- **Timestamp**: (datetime).

## Metrics Model

### Observability Metric
A data point captured during lab execution.
- **Type**: (enum) [CPU_Cycles, Memory_Usage, Page_Faults, Syscall_Count, Packet_Loss].
- **Value**: (float).
- **Unit**: (string) e.g., "ms", "bytes", "percent".
- **Tags**: (map of string:string) e.g., {"pid": "1234", "cpu": "0"}.
- **Timestamp**: (unix timestamp).

## Relationships
- A **Lab Subsystem** contains multiple **Lab Scenarios**.
- A **Lab Scenario** produces multiple **Observability Metrics** during its `run` phase.
- A **Lab Scenario** follows the **Lifecycle Contract** via its `Makefile`.
