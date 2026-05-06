{ config, lib, pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix 
		inputs.home-manager.nixosModules.default
	];

	nix.settings.experimental-features = [ "nix-command" "flakes"];

	nixpkgs.config.allowUnfree = true;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "puppybox";

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Berlin";

	programs.hyprland.enable = true;


	services.udev.extraRules = ''
	  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
	'';

	
	i18n.inputMethod.enable = true;
	i18n.inputMethod.type = "fcitx5";
	i18n.inputMethod.fcitx5.addons = [pkgs.fcitx5-mozc];


	services.displayManager.ly.enable = true;

	hardware.nvidia = {
	    modesetting.enable = true;
	    powerManagement.enable = false;  # Optional: disable if issues
	    powerManagement.finegrained = false;
	    open = false;  # Use proprietary for Steam compatibility
	    nvidiaSettings = true;
	    package = config.boot.kernelPackages.nvidiaPackages.stable;  # Or .latest
	  };

	hardware.graphics.enable = true;

	  services.xserver.videoDrivers = [ "nvidia" ];

	programs.steam.enable = true;

	services.flatpak.enable = true;

	users.users.nille = {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" ];
		packages = with pkgs; [
			nordzy-cursor-theme
			nordzy-icon-theme
		];
	};

	home-manager = {
		extraSpecialArgs = {inherit inputs;};
		users = {
			"nille" = import ./home.nix;
		};
	};

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = with pkgs; [
		# Add any missing dynamic libraries for unpackaged programs
		# here, NOT in environment.systemPackages
	];

	environment.systemPackages = with pkgs; [
		git
		wget
		kitty
	];

	networking.firewall.enable = false;

	system.stateVersion = "26.05"; #DONT CHANGE UNLESS YOU KNOW WHAT YOURE DOING!
}
