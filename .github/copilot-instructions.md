# Copilot / AI Agent Instructions

Purpose
- Provide quick, actionable guidance for AI assistants working on this NixOS flake-based configuration.

Big picture
- This repository is a single Nix flake (see `flake.nix`) exposing `nixosConfigurations` and `homeConfigurations`.
- System-wide defaults are in `machines/base.nix`; machine-specific configs live under `machines/<name>/` and always import a `hardware-configuration.nix` next to them.
- Reusable pieces live in `modules/` (e.g. `network-storage.nix`, `bluetooth.nix`, `sunshine.nix`).
- Home-manager profiles are under `profiles/` and referenced from `homeConfigurations` in `flake.nix`.

Key files to inspect
- `flake.nix` — entrypoints for `nixosConfigurations` and `homeConfigurations`.
- `machines/base.nix` — shared system defaults (users, nix settings, `system.stateVersion`).
- `machines/<name>/<name>.nix` + `machines/<name>/hardware-configuration.nix` — per-machine customization.
- `modules/*` — small reusable NixOS modules composed into machines.
- `profiles/*` — home-manager modules for user profiles.
- `secrets/smbsecrets` — plaintext CIFS credentials used by `modules/network-storage.nix`.

Common patterns & conventions
- Each NixOS machine is built via `nixpkgs.lib.nixosSystem { modules = [ ./machines/<...> ... ]; }` in `flake.nix`.
- `machines/base.nix` defines `users.users.colin` and common settings; machine files augment this by setting `users.users.colin.extraGroups`.
- Hardware-specific files are kept next to each machine and included with `imports = [ ./hardware-configuration.nix ]`.
- `system.stateVersion` is pinned to `23.05` in `machines/base.nix` — do not change without careful migration.
- Unfree packages are allowed via `nixpkgs.config.allowUnfree = true` in `machines/base.nix`.

Developer workflows (use exact commands)
- Build or switch a machine configuration (from repo root):
  - `sudo nixos-rebuild switch --flake .#go`  # replace `go` with the nixosConfiguration key
  - The `go` machine defines a convenience alias in the interactive shell: `nixbuild` → `sudo nixos-rebuild switch --flake /etc/nixos#go`.
- Show flake outputs: `nix flake show /etc/nixos` or `nix flake show .`.
- Build a single system artifact: `nix build .#nixosConfigurations.go.config.system.build.toplevel`.
- Home-manager update (example): `home-manager switch --flake .#colin@go` or `home-manager switch --flake .#colin@desktop`.

Secrets & external integrations
- CIFS mounts use `/etc/nixos/secrets/smbsecrets` (see `modules/network-storage.nix`) — avoid committing secrets elsewhere.
- External inputs are defined in `flake.nix` (`nixpkgs`, `home-manager`, `hardware`).

How to add a new machine (example)
- Create `machines/<name>/hardware-configuration.nix` (from `nixos-generate-config --root` or copy an existing one).
- Add `machines/<name>/<name>.nix` that imports `./hardware-configuration.nix` and composes `./machines/base.nix` and needed `modules/*`.
- Add an entry in `flake.nix` under `nixosConfigurations = { <name> = nixpkgs.lib.nixosSystem { modules = [ ./machines/<name>/<name>.nix ./machines/base.nix ./modules/...] ; }; }`.

What to watch for
- Avoid changing `system.stateVersion` without migration testing.
- Many machine customizations rely on augmenting `users.users.colin` rather than duplicating user definitions.
- Secrets are referenced by absolute path `/etc/nixos/secrets/...` — ensure any automation preserves that path.

If anything in these notes is unclear or incomplete, tell me which area (architecture, workflows, files) to expand or where you'd like examples added.
