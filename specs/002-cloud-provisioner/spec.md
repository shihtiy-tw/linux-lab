# Feature Specification: Cloud Provisioner

**Feature Branch**: `002-cloud-provisioner`  
**Created**: 2026-02-13  
**Status**: Draft  
**Input**: User description: "Cloud Provisioner: A way to provision different Linux distributions on different CSPs (AWS, Azure, GCP) in a fast way for lab environment setup."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Multi-CSP Unified Provisioning (Priority: P1)

As a lab user, I want to provision a specific Linux distribution across multiple cloud providers using a single command, so that I don't have to manually interact with different cloud consoles.

**Why this priority**: Essential for the core goal of "fast" and "different CSP" provisioning.

**Independent Test**: Successfully provision an Ubuntu instance on both AWS and GCP from the command line.

**Acceptance Scenarios**:

1. **Given** valid cloud credentials, **When** I run the provisioner for Ubuntu on AWS, **Then** an instance is created and SSH is accessible within 3 minutes.
2. **Given** valid cloud credentials, **When** I run the provisioner for Debian on GCP, **Then** an instance is created and SSH is accessible within 3 minutes.

---

### User Story 2 - Rapid Distribution Swapping (Priority: P2)

As an OS researcher, I want to quickly replace a running lab instance with a different Linux distribution on the same CSP, so that I can compare behaviors across kernels without manual reconfiguration.

**Why this priority**: Supports the "different linux distribution" aspect of the request.

**Independent Test**: Provision Fedora, then replace it with Rocky Linux on the same provider using the provisioner.

**Acceptance Scenarios**:

1. **Given** a running Fedora instance on Azure, **When** I request a "re-provision" with Rocky Linux, **Then** the Fedora instance is terminated and a new Rocky instance is available within 3 minutes.

---

### User Story 3 - Automated Teardown (Priority: P3)

As a cost-conscious user, I want all provisioned instances to be automatically cleaned up after my lab session ends, so that I don't incur unnecessary costs.

**Why this priority**: Critical for a 12-factor compliant lab environment.

**Independent Test**: Verify that instances are terminated on command or after a specified timeout.

**Acceptance Scenarios**:

1. **Given** active instances in AWS and GCP, **When** I run the "cleanup" command, **Then** all provisioned resources (instances, networking, keys) are permanently removed.

---

### Edge Cases

- **Credential Expiry**: How does the system handle expired CSP tokens mid-provisioning?
- **Quota Limits**: What happens if the CSP returns a "resource exhausted" error?
- **Network Failure**: How does the provisioner handle partial state if the network drops during setup?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST support AWS, GCP, and Azure cloud providers.
- **FR-002**: System MUST support at least 5 major Linux distributions: Ubuntu, Debian, Fedora, Rocky Linux, and Arch Linux.
- **FR-003**: System MUST provide a non-interactive mode for automated lab setups.
- **FR-004**: System MUST manage SSH key injection automatically for immediate access.
- **FR-005**: System MUST support automatic region optimization by default, while allowing manual region override via configuration.
- **FR-006**: System MUST support both a standard 'lab-tier' (e.g., 2vCPU/4GB) default and the ability for users to specify custom instance types.
- **FR-007**: System MUST be able to track and cleanup all resources created during a session.

### Key Entities

- **Provider**: A Cloud Service Provider configuration (AWS, GCP, Azure).
- **Image**: A specific combination of Linux Distribution and Version.
- **Instance**: A running virtual machine in a Provider's infrastructure.
- **Provisioning Profile**: A definition of Distro + Provider + Instance Type.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Successful instance provisioning (from command to SSH access) occurs in under 180 seconds on average across all supported CSPs.
- **SC-002**: 100% of provisioned resources are successfully identified and removed by the cleanup command.
- **SC-003**: Provisioning requires zero manual interaction with the CSP web console after initial credential setup.
- **SC-004**: Support for a new Linux distribution (on an existing CSP) can be added with only metadata changes.
