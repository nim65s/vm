# VM

Create a VirtualBox VM from the .ova file available on `nix build`
or on the latest [release](https://github.com/nim65s/vm/releases) of this repo.

## Use

Basic development tools are available, but if you need anything else you can use nix, eg.:
```
nix run nixpkgs#vscodium
```

## Update

Once in the VM, you can get this repo and modify the configuration of the vm to suit your needs:

```
git clone https://github.com/nim65s/vm
cd vm
# edit configuration.nix as you want
sudo nixos-rebuild switch --flake .
```

## Fork

To keep your modifications you can fork this repo.
By pushing a new tag to your fork, you can use github actions to create your own personalized .ova file
in the release section of your fork, and be able to create fresh VMs as you want

But beware of the 2.0G size limit for github release assests

## Sync with nixpkgs

To get latest updates from https://github.com/NixOS/nixpkgs/:

```
nix flake update --commit-lock-file
```
