# Makefile for Ansible operations

# Define variables
INVENTORY = hosts
PLAYBOOK = run.yml
VAULT_PASSWORD_FILE = pass.sh

# Color definitions
RESET = \033[0m
BOLD = \033[1m
BLUE = \033[34m
GREEN = \033[32m
YELLOW = \033[33m

# Default target: display help
.DEFAULT_GOAL := help

# Edit secrets (opens the encrypted vault file for editing)
edit-secrets:
	@echo "Editing secrets in the Ansible vault..."
	ansible-vault edit group_vars/all/secret.yml --vault-password-file=$(VAULT_PASSWORD_FILE)

# Run the Ansible playbook
run-play:
	@echo "Running Ansible playbook..."
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --vault-password-file=$(VAULT_PASSWORD_FILE)

# Store the Ansible vault password in the system keychain
store-password:
	@echo "Storing Ansible vault password in the system keychain..."
	@read -p "Enter the Ansible vault password: " password; \
	security add-generic-password -a "crgomo" -s "ansible-vault-password" -w "$$password"

# Help command to display available targets with colors
help:
	@echo "$(BOLD)$(BLUE)Ansible Automation Makefile$(RESET)"
	@echo "$(BLUE)==============================$(RESET)"
	@echo "$(BOLD)Available targets:$(RESET)"
	@echo "  $(YELLOW)edit-secrets$(RESET)  : Edit the encrypted Ansible vault"
	@echo "  $(YELLOW)run-play$(RESET)      : Run the Ansible playbook"
	@echo "  $(YELLOW)store-password$(RESET): Store the Ansible vault password in the system keychain"
	@echo "  $(YELLOW)help$(RESET)          : Display this help message"
	@echo ""
	@echo "$(BOLD)$(GREEN)Usage:$(RESET) make $(YELLOW)<target>$(RESET)"
	@echo "Running make without a target will display this help message."

.PHONY: edit-secrets run-play store-password help