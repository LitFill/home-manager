# Specification: Modularize Neovim Configuration

## Goal
Refactor the current Neovim configuration (via NixVim) to support a modular structure that allows for shared "base" settings and machine-specific "profile" overrides.

## Requirements
- Maintain a common set of plugins, keymaps, and options.
- Support adding or overriding settings based on the target machine (e.g., specific LSPs or UI plugins).
- Ensure the configuration remains reproducible and easily manageable through Nix.

## Proposed Architecture
1. **`config/nixvim/default.nix`**: New entry point for the NixVim module.
2. **`config/nixvim/base.nix`**: Module that imports all common settings (options, plugins, keymaps, etc.).
3. **`config/nixvim/profiles/`**: Directory for machine-specific Nix modules that can be optionally imported.
4. **Integration**: The `home.nix` will continue to import `config/nixvim.nix`, which will orchestrate the modular setup.
