# Contributing to Home Manager Configuration

Thank you for your interest in contributing to this Home Manager configuration!
This document provides guidelines and best practices for contributors.

## How to Contribute

### Reporting Issues

1. **Search existing issues** before creating new ones
2. **Use descriptive titles** for issues
3. **Provide detailed information**:
   - Your system (Linux distribution, version)
   - Nix version
   - Steps to reproduce
   - Expected vs actual behavior
   - Error messages (if any)

### Suggesting Features

1. **Check if feature fits** the configuration's philosophy
2. **Open an issue** with "Feature Request" label
3. **Describe the use case** and benefits
4. **Consider implementation** details

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/your-feature-name`
3. **Make your changes** following the guidelines below
4. **Test thoroughly** (see Testing section)
5. **Submit a pull request** with clear description

## Contribution Guidelines

### Code Style

#### Nix Files
- Use **2 spaces** for indentation
- Align lists and attributes
- Use trailing commas in multi-line lists
- Keep lines under 80 characters when possible

```nix
# Good
home.packages = with pkgs; [
  package-one
  package-two
  package-three
];

# Avoid
home.packages = with pkgs; [ package-one package-two package-three ];
```

#### Documentation
- Use **clear, concise language**
- Include **examples** for complex configurations
- **Update relevant documentation** files
- Use **consistent formatting** (Markdown)

### File Organization

#### Adding New Packages
1. Add to appropriate section in `config/packages.nix`
2. Group by category (development, system, etc.)
3. Add alphabetically within groups
4. Update README.md if adding new categories

#### Adding New Modules
1. Create file in `config/` directory
2. Follow naming convention: `feature-name.nix`
3. Import in `home.nix`
4. Add documentation in `CONFIGURATION.md`

#### Configuration Changes
1. **Make changes modular** - separate concerns
2. **Use sensible defaults** - don't break existing setups
3. **Provide customization options** when possible
4. **Document new options** thoroughly

## Testing

### Before Submitting

1. **Check syntax**:
   ```bash
   nix flake check
   ```

2. **Test configuration**:
   ```bash
   home-manager switch --flake .#your-username
   ```

3. **Verify functionality**:
   - Test new packages/tools
   - Check configuration files are created correctly
   - Ensure no breaking changes

4. **Test on clean system** (if possible):
   - Use temporary directory
   - Test fresh installation

### Testing Checklist

- [ ] Configuration builds without errors
- [ ] All new packages work as expected
- [ ] Documentation is updated
- [ ] No breaking changes for existing users
- [ ] Code follows style guidelines
- [ ] Tests pass (if applicable)

## Types of Contributions

### Bug Fixes
- **Priority**: High
- **Requirements**: Clear description of bug, steps to reproduce
- **Process**: Fix, test, document

### Feature Additions
- **Priority**: Medium
- **Requirements**: Use case description, implementation plan
- **Process**: Discuss in issue, implement, test, document

### Documentation
- **Priority**: Medium
- **Requirements**: Clear, accurate information
- **Process**: Update, review, test examples

### Performance Improvements
- **Priority**: Low
- **Requirements**: Benchmarks, comparison data
- **Process**: Profile, optimize, verify

## Development Workflow

### Setting Up Development Environment

1. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/home-manager.git
   cd home-manager
   ```

2. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/LitFill/home-manager.git
   ```

3. **Create development branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

### Making Changes

1. **Make small, focused changes**
2. **Test each change** before committing
3. **Write clear commit messages**:
   ```
   type(scope): description

   Examples:
   feat(nixvim): add rust language server support
   fix(shell): resolve nushell completion issue
   docs(readme): update installation instructions
   ```

4. **Keep commits atomic** - one logical change per commit

### Submitting Pull Requests

1. **Update your branch**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create pull request** with:
   - Clear title and description
   - Reference related issues
   - Testing instructions
   - Screenshots (if UI changes)

## Documentation Standards

### README.md Updates
- Keep **quick start** section current
- Update **feature list** for significant changes
- Maintain **compatibility information**

### CONFIGURATION.md Updates
- Document **new modules** thoroughly
- Provide **usage examples**
- Include **customization options**

### SETUP.md Updates
- Update **installation steps** if needed
- Add **troubleshooting** for new issues
- Maintain **system requirements**

## Contribution Priorities

### High Priority
- **Bug fixes** that affect core functionality
- **Security updates** and vulnerabilities
- **Breaking changes** (with proper migration)

### Medium Priority
- **New language support** (LSP, formatters)
- **Performance improvements**
- **Documentation enhancements**

### Low Priority
- **Cosmetic changes**
- **Personal preferences**
- **Experimental features**

## What Not to Contribute

### Out of Scope
- **Personal configurations** (user-specific settings)
- **Proprietary software** (unless freely available)
- **Large binary packages** (use system package manager)
- **Security-sensitive configurations** (keys, passwords)

### Quality Standards
- **Unmaintained packages** or abandoned projects
- **Poorly documented** features
- **Breaking changes** without migration path
- **Duplicate functionality** (unless significant improvement)

## Getting Help

### For Contributors
- **GitHub Issues**: For questions about contributing
- **Discussions**: For general questions and ideas
- **Code Review**: Feedback on pull requests

### For Users
- **Documentation**: Check existing docs first
- **Issues**: Report bugs or request features
- **Community**: Ask questions in discussions

## Code of Conduct

### Be Respectful
- **Treat everyone** with respect and professionalism
- **Welcome newcomers** and help them learn
- **Accept feedback** gracefully

### Be Constructive
- **Focus on what's best** for the community
- **Show empathy** towards other community members
- **Be collaborative** in problem-solving

### Be Professional
- **Use appropriate language** and tone
- **Stay on topic** in discussions
- **Follow GitHub's** terms of service

## Recognition

### Contributors
- **Attributed** in commit history
- **Listed** in contributors section
- **Recognized** in release notes

### Significant Contributions
- **Featured** in README
- **Highlighted** in announcements
- **Invited** to become maintainers (if interested)

## Resources

### Learning Resources
- [Nix Language Guide](https://nixos.org/learn.html)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixVim Documentation](https://github.com/nix-community/nixvim)

### Development Tools
- **Nix IDE**: VSCode extension for Nix development
- **nixfmt**: Nix code formatter
- **nil**: Nix language server

### Community
- [Nix Discourse](https://discourse.nixos.org/)
- [NixOS Reddit](https://www.reddit.com/r/NixOS/)
- [Home Manager GitHub](https://github.com/nix-community/home-manager)

---

Thank you for contributing to this Home Manager configuration! Your efforts
help make this setup better for everyone.
