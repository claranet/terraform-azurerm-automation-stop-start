## 7.0.1 (2024-11-29)

### Bug Fixes

* handle target resource Subscription context in Automation Runbook script 2b1b735

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.6 2a9ef78
* **deps:** update dependency trivy to v0.57.1 731ca9f
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 af430fa
* **deps:** update terraform hashicorp/terraform to 1.5 de615f4
* **deps:** update tools 9fdbe13

## 7.0.0 (2024-11-15)

### ⚠ BREAKING CHANGES

* **AZ-111:** import Automation stop/start module

### Features

* **AZ-111:** import Automation stop/start module c8d75d1
* **AZ-111:** module Azure Stop/Start with Automation initialization eba0972
* **AZ-111:** optional RBAC assignment 7675046

### Documentation

* **AZ-111:** rework README and example 0e31e65
* **AZ-111:** update example ebbb9a6

### Code Refactoring

* **AZ-111:** apply suggestions e807e9e
* **AZ-111:** lint json & ps1 files 91d5dcb
* **AZ-111:** optional automation account bce094b
* **AZ-111:** use azapi instead of null_resource with AzCLI 0ce03b7

Added
  * AZ-111: Azure Stop/Start with Automation module first release
