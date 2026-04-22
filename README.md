# Sublime Merge Plugins

A collection of syntax highlighting plugins for Sublime Merge, managed as git submodules.
The same collection can be reused by [`bat`](https://github.com/sharkdp/bat), which loads
`.sublime-syntax` files recursively from its syntaxes directory.

## Setup on a new machine

### Sublime Merge

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

### bat

```bash
git clone --recursive git@github.com:kubijo/sublime-merge-plugins.git ~/.config/bat/syntaxes
cd ~/.config/bat/syntaxes
just bat-update
```

`just bat-update` also handles future upgrades (`git submodule` reset + cache rebuild +
workarounds for grammars bat's parser rejects — see the recipe in the `justfile`).

Non-syntax files in each submodule (`plugin.py`, `Completions/`, `Build Systems/`, …) are
ignored by bat, so the same repo works for both editors.

## Usage

```bash
# Add a new plugin (name defaults to the repo's basename, override with 2nd arg)
just add https://github.com/user/sublime-something
just add https://github.com/caddyserver/sublimetext Caddyfile

# Update all plugins to latest upstream
just update

# Update all plugins and rebuild bat's syntax cache
just bat-update

# Remove a plugin
just remove plugin-name

# List all plugins
just list
```
