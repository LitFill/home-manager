# Specification: Nushell Utility Functions

## Overview
This track aims to enhance the Nushell experience by providing a curated collection of utility functions. These functions will focus on file and system management, data transformation, and common Nushell idioms, catering to both developer and general-purpose needs.

## Functional Requirements
1. **Infrastructure:**
   - Create a dedicated Nushell script file: `files/functions.nu`.
   - Update `config/shell/nushell.nix` to source this file.
2. **File/System Management:**
   - Implement functions for enhanced navigation (e.g., `mkcd`, quick back-navigation).
   - Implement enhanced file/directory listing or search wrappers.
3. **Data Transformation:**
   - Include helpers for processing common data formats (JSON, CSV, YAML) into structured tables.
   - Add text processing utilities (e.g., line cleaning, regex helpers).
4. **Nushell Idioms:**
   - Provide "Nushell-native" wrappers for common external CLI tools (e.g., `btop`, `fd`, `rg`) that may not natively return structured data.
   - Include examples of pipeline-friendly functions.

## Non-Functional Requirements
- **Documentation:** Every function MUST have a `help` description using Nushell doc-comments.
- **Reproducibility:** The configuration MUST remain fully reproducible via Home Manager.
- **Code Style:** Functions should follow idiomatic Nushell patterns (pipes over loops where possible).

## Acceptance Criteria
- [ ] `files/functions.nu` exists and is correctly sourced in the Nushell configuration.
- [ ] At least 5 distinct utility functions are implemented and documented.
- [ ] `home-manager build` evaluates and completes without errors.
- [ ] All new functions are verified to work within a Nushell session.

## Out of Scope
- Large-scale system automation scripts.
- Replacement of existing core Nix/Home Manager modules.
- GUI-related shell integrations.
