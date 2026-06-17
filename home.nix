{ config, pkgs, ... }:

{
	home.username = "nille";
	home.homeDirectory = "/home/nille";

	home.stateVersion = "25.11"; # DONT CHANGE

	nixpkgs.config.allowUnfree = true;

	home.packages = [
		pkgs.neovim
		pkgs.gh
		pkgs.wofi
		pkgs.goxlr-utility
		pkgs.pavucontrol
		pkgs.streamcontroller
		pkgs.kdePackages.dolphin
		pkgs.hyprshot
		pkgs.prismlauncher
		pkgs.osu-lazer-bin
		pkgs.obs-studio
		pkgs.satisfactorymodmanager
		pkgs.wine
		pkgs.javaPackages.compiler.openjdk25
		pkgs.python315
		pkgs.cargo
		#additional nvim stuff
		pkgs.unzip
		pkgs.ltex-ls
		pkgs.texliveFull
		pkgs.texlab
		pkgs.zathura
		pkgs.go
		pkgs.lua53Packages.tree-sitter-cli
		pkgs.gcc
		pkgs.ripgrep
	];

	home.sessionVariables = {
	};

	xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/hypr";
	xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/nvim";

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
