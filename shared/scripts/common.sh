#!/usr/bin/env bash

# common.sh - 12-factor helper functions for linux-lab scripts
# This script should be sourced by other scripts.

set -euo pipefail
IFS=$'\n\t'
set -E

readonly SCRIPT_NAME="${SCRIPT_NAME:-$(basename "$0")}"
readonly COL_RESET='\033[0m'
readonly COL_RED='\033[0;31m'
readonly COL_GREEN='\033[0;32m'
readonly COL_YELLOW='\033[0;33m'
readonly COL_BLUE='\033[0;34m'
readonly COL_CYAN='\033[0;36m'

# 12-factor: Treat logs as event streams. Output to stderr.
declare -A LOG_LEVELS=([DEBUG]=0 [INFO]=1 [WARN]=2 [ERROR]=3 [FATAL]=4)
LOG_LEVEL="${LOG_LEVEL:-INFO}"

_log_fmt() {
    local level=$1
    local color=$2
    local msg=$3
    
    if [[ ${LOG_LEVELS[$level]:-1} -ge ${LOG_LEVELS[$LOG_LEVEL]:-1} ]]; then
        local timestamp
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        printf "${color}[%s] [%-5s] [%s] %s${COL_RESET}\n" \
            "$timestamp" "$level" "$SCRIPT_NAME" "$msg" >&2
    fi
}

log_info()  { _log_fmt "INFO"  "$COL_GREEN"  "$1"; }
log_warn()  { _log_fmt "WARN"  "$COL_YELLOW" "$1"; }
log_error() { _log_fmt "ERROR" "$COL_RED"    "$1"; }
log_fatal() { _log_fmt "FATAL" "$COL_RED"    "$1"; exit 1; }
log_debug() { _log_fmt "DEBUG" "$COL_BLUE"   "$1"; }
log_step()  { _log_fmt "STEP"  "$COL_CYAN"   "$1"; }

CLEANUP_TASKS=()

add_cleanup() {
    local task=$1
    CLEANUP_TASKS+=("$task")
}

_execute_cleanup() {
    local exit_code=$?
    for ((i=${#CLEANUP_TASKS[@]}-1; i>=0; i--)); do
        local task="${CLEANUP_TASKS[$i]}"
        eval "$task" || log_warn "Cleanup task failed: $task"
    done
    exit "$exit_code"
}

trap _execute_cleanup EXIT SIGINT SIGTERM

require_command() {
    local cmd=$1
    if ! command -v "$cmd" >/dev/null 2>&1; then
        log_error "Required command '$cmd' not found."
        exit 1
    fi
}

ensure_dir() {
    local dir=$1
    [[ -d "$dir" ]] || mkdir -p "$dir"
}

# Atomic locking using flock
acquire_lock() {
    local lockfile=$1
    local timeout=${2:-10}
    ensure_dir "$(dirname "$lockfile")"
    
    # Open lockfile on FD 200
    exec 200>"$lockfile"
    if flock -n -w "$timeout" 200; then
        add_cleanup "rm -f '$lockfile'"
    else
        log_error "Failed to acquire lock on $lockfile (timeout ${timeout}s)"
        exit 1
    fi
}

append_unique() {
    local line=$1
    local file=$2
    ensure_dir "$(dirname "$file")"
    touch "$file"
    grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

require_env() {
    local var_name=$1
    if [[ -z "${!var_name:-}" ]]; then
        log_error "Required environment variable '$var_name' is not set."
        exit 1
    fi
}

log_debug "common.sh loaded successfully."
