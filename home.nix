{ config, pkgs, ... }:

{
	home.username = "nille";
	home.homeDirectory = "/home/nille";

	home.stateVersion = "25.11"; # DONT CHANGE

	nixpkgs.config.allowUnfree = true;

	home.packages = [
		pkgs.firefox
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
		pkgs.javaPackages.compiler.openjdk21
		pkgs.python315
		pkgs.tor-browser
		pkgs.jetbrains.idea
		pkgs.r2modman # mods for lethal company
		pkgs.libreoffice
		pkgs.cargo
		#additional nvim stuff
		pkgs.unzip
		pkgs.ltex-ls
		pkgs.texliveFull
		pkgs.texlab
		pkgs.zathura
	];

	home.sessionVariables = {
	};

	xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/hypr";
	xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dots/nvim";

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
