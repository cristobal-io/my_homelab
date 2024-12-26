# Define variables
INVENTORY = hosts
PLAYBOOK = run.yml
REQUIREMENTS = requirements.yml

# Color definitions
RESET = \033[0m
BOLD = \033[1m
BLUE = \033[34m
GREEN = \033[32m
YELLOW = \033[33m

# Default target: display help
.DEFAULT_GOAL := help

.PHONY: install-requirements
# Install Ansible requirements
install-requirements:
	@echo "$(BOLD)$(BLUE)Installing Ansible requirements...$(RESET)"
	ansible-galaxy install -r $(REQUIREMENTS)

.PHONY: edit-secrets
# Edit secrets (opens the encrypted vault file for editing)
edit-secrets:
	@echo "$(BOLD)$(BLUE)Editing secrets in the Ansible vault...$(RESET)"
	ansible-vault edit group_vars/all/secret.yml

.PHONY: run-play
# Run the Ansible playbook
run-play: install-requirements
	@echo "$(BOLD)$(BLUE)Running Ansible playbook...$(RESET)"
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK)

.PHONY: run-containers
# Run only the containers tag
run-containers: install-requirements
	@echo "$(BOLD)$(BLUE)Running Ansible playbook with containers tag...$(RESET)"
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --tags containers

.PHONY: run-spotdl
# Run only the spotdl tag
run-spotdl: install-requirements
	@echo "$(BOLD)$(BLUE)Running Ansible playbook with spotdl tag...$(RESET)"
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --tags spotdl

.PHONY: store-password
# Store the Ansible vault password in the system keychain
store-password:
	@echo "$(BOLD)$(BLUE)Storing Ansible vault password in the system keychain...$(RESET)"
	@read -p "Enter the Ansible vault password: " password; \
	security add-generic-password -a "crgomo" -s "ansible-vault-password" -w "$$password"

.PHONY: help
# Help command to display available targets with colors
help:
	@echo "$(BOLD)$(BLUE)Ansible Automation Makefile$(RESET)"
	@echo "$(BLUE)==============================$(RESET)"
	@echo "$(BOLD)Available targets:$(RESET)"
	@echo "  $(YELLOW)install-requirements$(RESET): Install Ansible Galaxy requirements"
	@echo "  $(YELLOW)edit-secrets$(RESET)        : Edit the encrypted Ansible vault"
	@echo "  $(YELLOW)run-play$(RESET)            : Run the complete Ansible playbook"
	@echo "  $(YELLOW)run-containers$(RESET)      : Run only the containers tag in the playbook"
	@echo "  $(YELLOW)run-spotdl$(RESET)         : Run only the spotdl tag in the playbook"
	@echo "  $(YELLOW)store-password$(RESET)      : Store the Ansible vault password in the system keychain"
	@echo "  $(YELLOW)help$(RESET)                : Display this help message"
	@echo ""
	@echo "$(BOLD)$(GREEN)Usage:$(RESET) make $(YELLOW)<target>$(RESET)"
	@echo "Running make without a target will display this help message."