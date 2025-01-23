# Variables
VENV = .venv
PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip

# Default target
.PHONY: all
all: setup

# Create virtual environment and install dependencies
.PHONY: setup
setup: $(VENV)/bin/activate

$(VENV)/bin/activate:
    python3 -m venv $(VENV)
    $(PIP) install --upgrade pip
    $(PIP) install -r requirements.txt

# Run the application
.PHONY: run
run:
    $(PYTHON) src/main.py

# Run tests
.PHONY: test
test:
    $(PYTHON) -m pytest tests/

# Clean up
.PHONY: clean
clean:
    rm -rf __pycache__
    rm -rf $(VENV)
    find . -type f -name "*.pyc" -delete
    find . -type d -name "__pycache__" -delete

# Install new dependencies and update requirements.txt
.PHONY: freeze
freeze:
    $(PIP) freeze > requirements.txt

# Development setup with additional tools
.PHONY: dev-setup
dev-setup: setup
    $(PIP) install black pylint pytest

# Format code
.PHONY: format
format:
    $(VENV)/bin/black src/ tests/

# Usage:
# make setup - Create venv and install dependencies
# make run - Run the application
# make test - Run tests
# make clean - Remove venv and cache files
# make freeze - Update requirements.txt
# make format - Format code using black