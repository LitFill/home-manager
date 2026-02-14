# Product Guidelines: LitFill's Home Manager Configuration

## Documentation Style
- **Technical and Concise:** Maintain a standard technical documentation tone. Explanations should be direct, focusing on implementation details and configuration logic without unnecessary verbosity.

## Design Principles
- **Modular & Composable:** New Nix modules must be small and focused. Each file should represent a single tool or a cohesive set of related settings, allowing them to be independently imported and managed.
- **Strict Type Checking:** Utilize the Nix module system's `lib.types` wherever possible. Define clear options for custom modules to ensure configuration validity and provide helpful error messages during evaluation.

## Visual Identity & UI Consistency
- **Global Theme Variable:** Visual consistency is maintained through a central theme configuration. Colors and styles should be unified across the terminal, editor, and system utilities to ensure a cohesive user experience.

## Workflow & Development Principles
- **Test Before Switch:** Always verify the configuration (e.g., using `home-manager build`) before applying changes. This ensures that the configuration is evaluable and reproducible, preventing environment breakage.
- **Atomic Commits:** Configuration changes should be broken down into small, logical units. Each commit must represent a single functional change or fix, accompanied by a clear description to facilitate debugging and rollbacks.

## Dependency & Plugin Management
- **Pragmatic Nix Integration:** 
    - Use Nix for lightweight dependencies and plugins to maintain reproducibility.
    - For "heavy" dependencies or those with complex lifecycles, evaluate the trade-off between Nix management and native managers. 
    - **Policy:** Default to Nix for most additions; seek clarification or perform a feasibility check for significantly large or complex new dependencies before implementation.
