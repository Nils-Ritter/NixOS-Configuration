{ config, pkgs, ... }:

{
	home.username = "nille";
	home.homeDirectory = "/home/nille";

	home.stateVersion = "25.11"; # DONT CHANGE

	nixpkgs.config.allowUnfree = true;

	home.packages = [
		pkgs.neovim
		pkgs.gh
		pkgs.goxlr-utility
		pkgs.pavucontrol
		pkgs.kdePackages.dolphin
		pkgs.prismlauncher
		pkgs.obs-studio
		pkgs.satisfactorymodmanager
		pkgs.wine
		pkgs.javaPackages.compiler.openjdk25
		pkgs.python315
		#additional nvim stuff
		pkgs.unzip
		pkgs.go
		pkgs.lua53Packages.tree-sitter-cli
		pkgs.gcc
		pkgs.ripgrep
		pkgs.anki
		#pkgs.vesktop
		pkgs.discord
		pkgs.alacritty
		pkgs.tmux
		pkgs.tor-browser
		pkgs.android-tools
		pkgs.godot
		pkgs.mpv
		pkgs.rustup
		pkgs.nodejs_26
	];

	home.sessionVariables = {};

	xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/hypr";
	xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/nvim";
	xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/kitty";

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
