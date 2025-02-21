## 8.0.0 (2025-02-21)

### ⚠ BREAKING CHANGES

* **AZ-1088:** AzureRM Provider v4+ and OpenTofu 1.8+

### Features

* **AZ-1088:** module v8 structure and updates 668c746

### Documentation

* **AZ-1088:** update example 4d4acf2

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v8 593ec8a
* **deps:** update dependency tflint to v0.55.1 66397b3
* **deps:** update dependency trivy to v0.59.1 db571d0
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 01ee5b5
* **deps:** update terraform azapi to v2 b668027
* update Github templates c2fcffc

## 7.0.2 (2025-01-31)

### Code Refactoring

* **AZ-111:** updates and some fixes c38615f

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.7 7f38110
* **deps:** update dependency opentofu to v1.8.8 7819ebe
* **deps:** update dependency opentofu to v1.9.0 b193a65
* **deps:** update dependency pre-commit to v4.1.0 55af7a2
* **deps:** update dependency tflint to v0.55.0 291ca5a
* **deps:** update dependency trivy to v0.58.0 85b0a74
* **deps:** update dependency trivy to v0.58.1 e606e50
* **deps:** update dependency trivy to v0.58.2 6241364
* **deps:** update dependency trivy to v0.59.0 b42f3b5
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 4d1681d
* update tflint config for v0.55.0 863add0

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
