default:
    @just --list

# Add a new package: just add https://github.com/user/repo [local-name]
add url name='':
    #!/usr/bin/env bash
    set -euo pipefail
    name="{{ name }}"
    if [ -z "$name" ]; then
        name=$(basename "{{ url }}" .git)
    fi
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

# Hard reset parent repo to origin/HEAD and update submodules (DESTRUCTIVE)
sync:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "WARNING: This will discard all local changes and reset to origin/HEAD."
    read -rp "Continue? [y/N] " reply
    [[ "$reply" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 1; }
    git fetch origin
    git reset --hard origin/HEAD
    git submodule update --init --recursive
    echo "Synced to origin/HEAD with submodules."

# Update plugins and rebuild bat's syntax cache (when this repo is cloned as ~/.config/bat/syntaxes)
bat-update: update
    bat cache --build
