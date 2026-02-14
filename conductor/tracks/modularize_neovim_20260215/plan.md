# Implementation Plan: Modularize Neovim Configuration

## Phase 1: Infrastructure and Analysis
- [x] Task: Analyze existing Neovim modules (`lsp.nix`, `plugins.nix`, etc.) to identify candidates for modularization.
- [x] Task: Create `config/nixvim/base.nix` as a central hub for common Neovim modules.
- [~] Task: Create `config/nixvim/profiles/` directory to house machine-specific configurations.
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Infrastructure' (Protocol in workflow.md)

## Phase 2: Core Refactoring
- [ ] Task: Update `config/nixvim/base.nix` to import `autocmds.nix`, `extra.nix`, `keymaps.nix`, `lsp.nix`, `options.nix`, and `plugins.nix`.
- [ ] Task: Refactor `config/nixvim.nix` to act as the primary entry point that imports `base.nix`.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Core Refactoring' (Protocol in workflow.md)

## Phase 3: Profile System Implementation
- [ ] Task: Implement a mechanism in `config/nixvim.nix` to allow passing a profile name via `extraSpecialArgs` or a similar Nix pattern.
- [ ] Task: Create an initial `config/nixvim/profiles/default.nix` for common overrides.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Profile System' (Protocol in workflow.md)

## Phase 4: Finalization and Testing
- [ ] Task: Verify the entire Home Manager configuration evaluates correctly using `home-manager build`.
- [ ] Task: Document the new modular Neovim structure in `README.md` or a dedicated doc file.
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Finalization' (Protocol in workflow.md)
