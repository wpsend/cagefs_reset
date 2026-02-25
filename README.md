# CageFS Reset Script
### Professional CageFS Cleanup & Rebuild Tool for CloudLinux + cPanel Servers

[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![CloudLinux](https://img.shields.io/badge/CloudLinux-supported-blue.svg)](#)
[![cPanel](https://img.shields.io/badge/cPanel-compatible-orange.svg)](#)
[![Shell Script](https://img.shields.io/badge/language-bash-lightgrey.svg)](#)

A production-ready Bash script to safely reset and rebuild CageFS for a specific cPanel user on CloudLinux servers.

This tool resolves abnormal `.cagefs` disk usage issues that can consume 10GB to 20GB unexpectedly.

## Installation

### Option 1: Clone Repository

```bash
curl -O https://raw.githubusercontent.com/wpsend/cagefs_reset/main/cagefs_reset.sh
chmod +x cagefs_reset.sh username
```
---

## Table of Contents

- Overview
- Why This Script Exists
- Features
- Server Requirements
- Installation
- Usage
- How It Works
- Example Output
- Troubleshooting
- Security Notes
- SEO Keywords
- License

---

## Overview

On CloudLinux servers using CageFS, the `.cagefs` directory inside a user's home folder can grow unusually large due to cached environments, broken skeleton updates, or outdated configurations.

This script performs a safe reset using official `cagefsctl` commands without risking account corruption.

It automates:

- CageFS disable
- Safe `.cagefs` removal
- CageFS re-enable
- Skeleton force update
- Quota fix

---

## Why This Script Exists

Hosting providers frequently encounter:

- `.cagefs` using 10GB+
- Disk quota mismatch in cPanel
- PHP Selector cache overflow
- Python / Node environment leftovers
- CloudLinux skeleton corruption
- High hidden directory disk usage

Manual cleanup is risky. This script standardizes the process safely.

---

## Features

- Safe CageFS disable/enable cycle
- Automatic `.cagefs` cleanup
- Skeleton force update
- Automatic quota rebuild
- Root verification
- User validation
- Clean CLI output
- Lightweight and dependency-free
- Production safe

---

## Server Requirements

- CloudLinux OS
- CageFS enabled
- cPanel / WHM installed
- Root access
- Bash shell

---

## Installation

### Option 1: Clone Repository

```bash
git clone https://github.com/wpsend/cagefs_reset.git
cd cagefs_reset
chmod +x cagefs_reset.sh
