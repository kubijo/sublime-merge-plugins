default:
    @just --list

# Add a new package: just add https://github.com/user/repo
add url:
    #!/usr/bin/env bash
    set -euo pipefail
    name=$(basename "{{ url }}" .git)
    git submodule add "{{ url }}" "$name"
    git add "$name" .gitmodules
    echo "Added $name - don't forget to commit"

# Update all packages to latest upstream (force reset)
update:
    git submodule foreach 'git fetch origin && git reset --hard origin/HEAD'
    @echo "Submodules reset to latest upstream - review and commit if desired"

# Remove a package: just remove package-name
remove name:
    git submodule deinit -f "{{ name }}"
    git rm -f "{{ name }}"
    rm -rf ".git/modules/{{ name }}"
    @echo "Removed {{ name }} - don't forget to commit"

# List all packages
list:
    @git submodule status

# Initial setup after cloning
init:
    git submodule update --init --recursive
