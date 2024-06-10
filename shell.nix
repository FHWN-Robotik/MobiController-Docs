{ pkgs ? import <nixpkgs> { } }:

let
  jekyll_env = pkgs.bundlerEnv rec {
    name = "jekyll_env";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    zlib
    ruby
    jekyll_env
  ];
}
