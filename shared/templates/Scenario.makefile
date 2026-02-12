# Scenario Makefile Template
# Following 12-factor compliance for Linux Lab scenarios

.DEFAULT_GOAL := help

# Configuration
SCENARIO_NAME ?= $(notdir $(CURDIR))
SHELL := /bin/bash

# Colors for output
YELLOW := \033[1;33m
GREEN  := \033[1;32m
RED    := \033[1;31m
NC     := \033[0m # No Color

# Helper Macros
define check_root
	@[[ $$EUID -eq 0 ]] || (echo -e "$(RED)Error: This target must be run as root$(NC)" && exit 1)
endef

define check_tool
	@command -v $(1) >/dev/null 2>&1 || (echo -e "$(RED)Error: Tool '$(1)' is not installed$(NC)" && exit 1)
endef

.PHONY: all
all: build setup run verify cleanup ## Run the full scenario lifecycle

.PHONY: build
build: ## Compile source code if necessary
	@echo -e "$(YELLOW)Building scenario: $(SCENARIO_NAME)...$(NC)"
	@# Add build commands here (e.g., gcc, go build, cargo build)

.PHONY: setup
setup: ## Prepare environment (idempotent)
	@echo -e "$(YELLOW)Setting up environment for: $(SCENARIO_NAME)...$(NC)"
	@# Example: $(call check_root)
	@# Add setup commands here (e.g., sysctl, mkdir, modprobe)

.PHONY: run
run: ## Execute the scenario
	@echo -e "$(YELLOW)Running scenario: $(SCENARIO_NAME)...$(NC)"
	@# Add execution commands here

.PHONY: verify
verify: ## Verify scenario results
	@echo -e "$(YELLOW)Verifying results for: $(SCENARIO_NAME)...$(NC)"
	@# Add verification logic here (e.g., grep output, check exit codes)

.PHONY: cleanup
cleanup: ## Revert changes and clean up (idempotent)
	@echo -e "$(YELLOW)Cleaning up: $(SCENARIO_NAME)...$(NC)"
	@# Add cleanup commands here (e.g., rm, sysctl revert, rmmod)

.PHONY: help
help: ## Show this help message
	@echo -e "Usage: make [target]"
	@echo -e ""
	@echo -e "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

# Infrastructure targets (can be overridden)
.PHONY: check-prerequisites
check-prerequisites: ## Check if all required tools are available
	@# Example: $(call check_tool,perf)
	@# Example: $(call check_tool,bpftrace)
	@echo -e "$(GREEN)All prerequisites met.$(NC)"
