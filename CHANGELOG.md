## 8.1.1 (2025-07-25)

### Bug Fixes

* correct command for starting PostgreSQL Flexible server c823620

### Miscellaneous Chores

* refactor local variable names 973f53e

## 8.1.0 (2025-07-25)

### Features

* add postgresql & webapp compatibility 581b36f

### Bug Fixes

* use existing automation account name 470c62f

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review b0415f3
* 🗑️ remove old commitlint configuration files bc7f194
* **deps:** update dependency opentofu to v1.10.0 c40c624
* **deps:** update dependency opentofu to v1.10.1 1b799d2
* **deps:** update dependency opentofu to v1.10.3 b8b184c
* **deps:** update dependency opentofu to v1.9.1 405f8b3
* **deps:** update dependency terraform-docs to v0.20.0 64ec047
* **deps:** update dependency tflint to v0.56.0 56c39f4
* **deps:** update dependency tflint to v0.57.0 9c28ece
* **deps:** update dependency tflint to v0.58.0 170d13a
* **deps:** update dependency tflint to v0.58.1 3297362
* **deps:** update dependency trivy to v0.61.0 d1c368a
* **deps:** update dependency trivy to v0.61.1 ddd71c4
* **deps:** update dependency trivy to v0.62.0 3323a0d
* **deps:** update dependency trivy to v0.62.1 e593f51
* **deps:** update dependency trivy to v0.63.0 abab8e1
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 03102a3
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 ceed22e
* **deps:** update tools caff3f0

## 8.0.1 (2025-03-25)

### Bug Fixes

* **AZ-1543:** remove jsonencode function from azapi v2 resources 4ca150b

### Miscellaneous Chores

* **deps:** update dependency pre-commit to v4.2.0 4a31f68
* **deps:** update dependency trivy to v0.60.0 753a474
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 3445430

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
