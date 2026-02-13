# Tasks: Comprehensive Linux Labs

**Input**: Design documents from `/specs/001-comprehensive-linux-labs/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Create subsystem root directories: cpu, memory, networking, storage, containers, gpu, security, observability, performance, troubleshooting
- [ ] T002 Create shared infrastructure directories: `shared/bpf/`, `shared/include/`, `shared/scripts/`, `shared/build/`
- [ ] T003 [P] Implement 12-factor helper functions (logging, traps, idempotency) in `shared/scripts/common.sh`
- [ ] T004 [P] Configure global linting and formatting (Clang-format, Shellcheck) at repository root

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T005 Implement the root-level `lab` CLI runner in `bin/lab` per CLI contract
- [ ] T006 Create the base `Makefile` template for scenario lifecycles in `shared/templates/Scenario.makefile`
- [ ] T007 [P] Setup shared BPF headers (vmlinux.h, bpf_helpers.h) in `shared/include/`
- [ ] T008 Setup centralized eBPF build pipeline in `shared/bpf/Makefile` to output to `shared/build/`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Multi-Language Kernel Exploration (Priority: P1) 🎯 MVP

**Goal**: Enable side-by-side comparison of C and Rust implementations for CPU scheduler exploration.

**Independent Test**: Run `./lab run cpu/scheduler-latency --language c` and `./lab run cpu/scheduler-latency --language rust`, then verify `verify` target passes.

### Implementation for User Story 1

- [ ] T009 [US1] Create scenario directory `cpu/scenarios/scheduler-latency/`
- [ ] T010 [P] [US1] Implement C-based scheduler benchmark in `cpu/scenarios/scheduler-latency/c/main.c`
- [ ] T011 [P] [US1] Implement Rust-based scheduler benchmark in `cpu/scenarios/scheduler-latency/rust/src/main.rs`
- [ ] T012 [US1] Create scenario lifecycle `Makefile` in `cpu/scenarios/scheduler-latency/Makefile` (using shared template)
- [ ] T013 [US1] Implement cross-language result comparison logic in `cpu/scenarios/scheduler-latency/verify.sh`

**Checkpoint**: User Story 1 (MVP) is fully functional and testable independently.

---

## Phase 4: User Story 2 - Deep Observability & Tracing (Priority: P2)

**Goal**: Capture low-level system behavior using eBPF and generate Flame Graphs.

**Independent Test**: Run observability lab and verify that a `.svg` flame graph is produced in the output directory.

### Implementation for User Story 2

- [ ] T014 [US2] Create scenario directory `observability/scenarios/task-tracing/`
- [ ] T015 [P] [US2] Implement shared eBPF program for task execution tracing in `shared/bpf/task_tracer.bpf.c`
- [ ] T016 [P] [US2] Implement Python-based loader for task tracer in `observability/scenarios/task-tracing/python/tracer.py`
- [ ] T017 [US2] Implement Flame Graph generation utility in `shared/scripts/flamegraph.sh`
- [ ] T018 [US2] Create scenario lifecycle `Makefile` in `observability/scenarios/task-tracing/Makefile`

**Checkpoint**: User Story 2 is fully functional with deep tracing capabilities.

---

## Phase 5: User Story 3 - Systemic Troubleshooting (Priority: P3)

**Goal**: Guided troubleshooting of memory pressure using standard CLI tools and isolation.

**Independent Test**: Successfully identify process causing memory pressure in an isolated namespace using `top`.

### Implementation for User Story 3

- [ ] T019 [US3] Create scenario directory `troubleshooting/scenarios/memory-pressure/`
- [ ] T020 [P] [US3] Implement Go-based memory workload generator in `troubleshooting/scenarios/memory-pressure/go/main.go`
- [ ] T021 [US3] Create guided troubleshooting documentation in `troubleshooting/scenarios/memory-pressure/GUIDE.md`
- [ ] T022 [US3] Create scenario `Makefile` in `troubleshooting/scenarios/memory-pressure/Makefile` with `unshare` isolation

**Checkpoint**: User Story 3 is ready for troubleshooting labs.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final refinements and global features.

- [ ] T023 [P] Implement `lab list` command in `bin/lab` to scan subsystems for scenarios
- [ ] T024 [P] Update root `README.md` with subsystem overview and Quickstart integration
- [ ] T025 Conduct final 12-factor compliance audit (idempotency, cleanup) for all scenarios
- [ ] T026 [P] Update `AGENTS.md` with newly implemented subsystems and commands

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately.
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories.
- **User Stories (Phase 3+)**: All depend on Foundational phase completion.
- **Polish (Final Phase)**: Depends on all user stories being complete.

### User Story Dependencies

- **User Story 1 (P1)**: Independent after Phase 2.
- **User Story 2 (P2)**: Independent after Phase 2.
- **User Story 3 (P3)**: Independent after Phase 2.

### Parallel Opportunities

- All [P] tasks within a phase can run in parallel.
- Once Phase 2 is done, US1, US2, and US3 can be developed in parallel.

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Verify C and Rust implementations produce consistent results.

### Incremental Delivery

1. Foundation ready.
2. Add US1 → Side-by-side language labs ready.
3. Add US2 → Observability stack ready.
4. Add US3 → Troubleshooting scenarios ready.
