# Implementation Plan: Modularize Neovim Configuration

## Phase 1: Infrastructure and Analysis [checkpoint: 0277ee0]
- [x] Task: Analyze existing Neovim modules (`lsp.nix`, `plugins.nix`, etc.) to identify candidates for modularization. 9bd2a72
- [x] Task: Create `config/nixvim/base.nix` as a central hub for common Neovim modules. 9bd2a72
- [x] Task: Create `config/nixvim/profiles/` directory to house machine-specific configurations. 9bd2a72
- [x] Task: Conductor - User Manual Verification 'Phase 1: Infrastructure' (Protocol in workflow.md)

## Phase 2: Core Refactoring [checkpoint: 31bc41e]
- [x] Task: Update `config/nixvim/base.nix` to import `autocmds.nix`, `extra.nix`, `keymaps.nix`, `lsp.nix`, `options.nix`, and `plugins.nix`. 9bd2a72
- [x] Task: Refactor `config/nixvim.nix` to act as the primary entry point that imports `base.nix`. a44584e
- [x] Task: Conductor - User Manual Verification 'Phase 2: Core Refactoring' (Protocol in workflow.md)

## Phase 3: Profile System Implementation
- [x] Task: Implement a mechanism in `config/nixvim.nix` to allow passing a profile name via `extraSpecialArgs` or a similar Nix pattern. 29a50b0
- [x] Task: Create an initial `config/nixvim/profiles/default.nix` for common overrides. 29a50b0
- [~] Task: Conductor - User Manual Verification 'Phase 3: Profile System' (Protocol in workflow.md)

## Phase 4: Finalization and Testing
- [x] Task: Verify the entire Home Manager configuration evaluates correctly using `home-manager build`. 29a50b0
- [x] Task: Document the new modular Neovim structure in `README.md` or a dedicated doc file. 2d5ee24
- [x] Task: Conductor - User Manual Verification 'Phase 4: Finalization' (Protocol in workflow.md)
