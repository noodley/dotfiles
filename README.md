# dotfiles
## Opt-in state NixOS configuration
### Helpful reference guides and repositories:
* https://github.com/kjhoerr/dotfiles
* https://github.com/Misterio77/nix-config
* https://guekka.github.io/nixos-server-1
### Helpful commands
```
nixos-rebuild --flake '.#e490' build
```

### Config Layout
* Config patterend after: https://github.com/jakehamilton/config
* * Based on snowfwall-lib: https://github.com/snowfallorg/lib
* Each host is defined nix/systems/<architecture>/<hostname>
* nix/nixos/modules/archetypes/workstation - Workstation config
* nix/nixos/modules/archetypes/server - Server config
* nix/nixos/modules/suites/common - Config hsared across all hosts

### Todo
