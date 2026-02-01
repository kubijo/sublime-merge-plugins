.PHONY: add update remove list init

# Add a new package: make add URL=https://github.com/user/repo
add:
ifndef URL
	$(error URL is required. Usage: make add URL=https://github.com/user/repo)
endif
	@name=$$(basename "$(URL)" .git); \
	git submodule add "$(URL)" "$$name"; \
	git add "$$name" .gitmodules; \
	echo "Added $$name - don't forget to commit"

# Update all packages to latest upstream (force reset)
update:
	git submodule foreach 'git fetch origin && git reset --hard origin/HEAD'
	@echo "Submodules reset to latest upstream - review and commit if desired"

# Remove a package: make remove NAME=package-name
remove:
ifndef NAME
	$(error NAME is required. Usage: make remove NAME=package-name)
endif
	git submodule deinit -f "$(NAME)"
	git rm -f "$(NAME)"
	rm -rf ".git/modules/$(NAME)"
	@echo "Removed $(NAME) - don't forget to commit"

# List all packages
list:
	@git submodule status

# Initial setup after cloning
init:
	git submodule update --init --recursive
