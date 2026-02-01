# Sublime Merge Plugins

A collection of syntax highlighting plugins for Sublime Merge, managed as git submodules.

## Setup on a new machine

macOS:
```bash
cd "~/Library/Application Support/Sublime Merge/Packages"
git clone --recursive git@github.com:kubijo/sublime-merge-plugins.git my-collection
```

Linux:
```bash
cd ~/.config/sublime-merge/Packages
git clone --recursive git@github.com:kubijo/sublime-merge-plugins.git my-collection
```

## Usage

```bash
# Add a new plugin
make add URL=https://github.com/user/sublime-something

# Update all plugins to latest upstream
make update

# Remove a plugin
make remove NAME=plugin-name

# List all plugins
make list
```
