# The latest (at the time) nixpkgs url revision hash was fetched with the command 'nix-prefetch-url https://github.com/NixOS/nixpkgs'
# More info can be found here: https://nixos.wiki/wiki/FAQ#How_do_I_install_a_specific_version_of_a_package_for_build_reproducibility_etc..3F
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/891f607d5301d6730cb1f9dcf3618bcb1ab7f10e.tar.gz") {} }:

with pkgs;

mkShell {
  buildInputs = [
    go
    delve
  ];

  shellHook = ''
    export GOROOT="$(dirname $(which go))"
    export PATH=$GOROOT:$PATH
    export GOPATH="$(pwd)/.go"
    export GOCACHE=""
    export GO111MODULE=on
    export GOFLAGS=-mod=vendor
    if ! [[ -f "$(pwd)/go.mod" ]]; then
      go mod init go_ads_cli
      go mod tidy
    fi
  '';
}
