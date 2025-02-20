# ASM Intrusion Detection

This repository contains a multi-task university assignment focusing on intrusion detection. The project implements several challenges in Assembly to simulate testing and verification procedures used in modern security systems.

## Project Overview

The assignment is divided into four main tasks:

- **Task 1 – Permissions (15p)**
  Implements file permission checking in C. It reads input files, verifies permissions using custom logic, and reports results. See [src/task-1/checker.c](src/task-1/checker.c) and [src/task-1/constants.h](src/task-1/constants.h).

- **Task 2 – Requests (20p)**
  Processes and validates request operations. The solution is implemented in C in [src/task-2/check_requests.c](src/task-2/check_requests.c).

- **Task 3 – Treyfer Encryption/Decryption (25p)**
  Implements the Treyfer cipher to encrypt/decrypt data. The tests and core logic are in [src/task-3/check_treyfer.c](src/task-3/check_treyfer.c).

- **Task 4 – Labyrinth Solver (30p)**
  A labyrinth solving algorithm implemented in Assembly ([src/task-4/labyrinth.asm](src/task-4/labyrinth.asm)) with a corresponding checker in C ([src/task-4/check_labyrinth.c](src/task-4/check_labyrinth.c)). The solver navigates a dynamically allocated maze and outputs the exit position.

## Supporting Tools

- **Checkers and Scripts**
  The [checker](checker/) directory contains:
  - A Bash checker script ([checker.sh](checker/checker.sh))
  - A Python version ([checker.py](checker/checker.py))
  Moreover, [local_checker.py](local_checker.py) provides an alternative checker implementation.

- **Docker Integration and Local Testing**
  The [local.sh](local.sh) script facilitates building, testing, and pushing Docker images. It supports commands such as:
  - `docker build` – Build a Docker image from the project
  - `docker push` – Push the built image to a specified registry
  - `docker test` – Run tests using the Docker container
  - `docker interactive` – Launch an interactive Docker session

## How to Run the Project

Ensure that you have Docker installed and configured. You can test, build, and deploy the project locally using the following commands:

- **Run the Checker Locally:**
```bash
./local.sh checker [--remove_image] [--use_existing_image <image_name>] [--force_build] [args_for_checker]
```

- **Build the Docker Image:**
```bash
./local.sh docker build [--image_name <image_name>] [--tag <tag>] [--registry <registry>] [--force_build]
```

- **Push the Docker Image:**
```bash
./local.sh docker push --user <user> --token <token> [--image_name <image_name>] [--tag <tag>] [--registry <registry>]
```

- **Test in the Docker Container:**
```bash
./local.sh docker test [--full_image_name <full_image_name>] [args_for_checker]
```

## Directory Structure

- **.gitlab-ci.yml**
  CI configuration for automated testing.

- **checker/**
  Contains the checker scripts:
  - checker.sh
  - checker.py

- **Dockerfile**
  Builds the container environment for testing the project.

- **local.sh**
  Main script for Docker commands and local testing (local.sh).

- **src/**
  - **images/**
    Contains images used for documentation and testing (e.g., labyrinth.png, dynamic_array.png).
  - **include/**
    Includes assembly headers such as io.mac.
  - **local_checker.py**
    A Python checker for local testing (local_checker.py).
  - **task-1/**
    Implements the Permissions task (src/task-1/checker.c, [src/task-1/constants.h](src/task-1/constants.h), and src/task-1/Makefile).
  - **task-2/**
    Implements the Requests task (src/task-2/check_requests.c).
  - **task-3/**
    Implements the Treyfer cipher (src/task-3/check_treyfer.c).
  - **task-4/**
    Implements the Labyrinth Solver using Assembly (src/task-4/labyrinth.asm) along with its test harness (src/task-4/check_labyrinth.c).

- **README.md**
  This file contains the project documentation.

## Implementation Details

- **Dynamic Memory Management:**
  Some tasks (e.g., the Labyrinth Solver) utilize dynamic memory allocation for matrices, ensuring that each line of the labyrinth is allocated consecutively despite not being contiguous overall.

- **Test Infrastructure:**
  Each task contains its own `input/`, `ref/`, and `output/` directories to store test cases and expected results. The checker scripts compare the outputs with reference files to assign scores.

- **Coding Practices:**
  - Task 1 and Task 2 use modular C code with clear separation of input reading, processing, and output writing.
  - Task 3 demonstrates a simple block-processing encryption/decryption algorithm in C.
  - Task 4 employs clean, well-commented Assembly code with structured labels and directives to adhere to best practices.

## Example Execution

```bash
./local.sh checker --use_existing_image iocla/tema2-2024 [additional checker arguments]
```

Happy testing!