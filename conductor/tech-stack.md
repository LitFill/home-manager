# Tech Stack: LitFill's Home Manager Configuration

## Core Infrastructure
- **Nix (Flakes):** The foundation of the entire configuration, ensuring reproducibility and hermetic builds through the use of Flakes.
- **Home Manager:** Used for declarative management of user-specific packages, dotfiles, and service configurations.
- **Nixpkgs (nixos-unstable):** Leveraging the latest packages and improvements from the unstable channel of the Nix ecosystem.

## Primary Languages & Toolchains
- **Functional Programming:**
    - **Haskell:** Managed with GHC and HLS, using Fourmolu for formatting.
    - **Idris2:** For dependently typed programming.
    - **OCaml:** Configured with specialized environment settings via `.ocamlinit`.
- **Modern Development:**
    - **Rust:** Managed via `rustup` for a flexible and up-to-date toolchain.
    - **TypeScript/JavaScript:** Integrated for web and tooling development.
    - **Lua:** Primarily for Neovim configuration and lightweight scripting.

## Terminal & Shell Experience
- **Nushell:** A modern, structured shell used as the primary interface.
- **Starship:** A fast, customizable, and cross-shell prompt for a high-quality visual experience.
- **tmux:** For terminal multiplexing with sensible, reproducible defaults.
- **Key CLI Utilities:** `fd` (find), `ripgrep` (search), `yazi` (file management), `zoxide` (smart navigation), and `btop` (system monitoring).

## Editor & IDE
- **NixVim:** Neovim managed entirely through Nix, featuring a modular profile system for multi-machine flexibility and comprehensive LSP support.

## Management & Documentation
- **Git:** Declaratively configured for version control.
- **Documentation Tools:** `pandoc` and `glow` for processing and rendering Markdown and other formats.
- **Finance:** The `hledger` suite for plaintext accounting.
