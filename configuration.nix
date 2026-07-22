{ config, lib, pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix 
		inputs.home-manager.nixosModules.default
	];

	nixpkgs.config.permittedInsecurePackages = [
                "electron-40.10.5"
	];

	programs.appimage.enable = true;
	programs.appimage.binfmt = true;

	nixpkgs.overlays = [ inputs.millennium.overlays.default ];

	nix.settings.experimental-features = [ "nix-command" "flakes"];

	nixpkgs.config.allowUnfree = true;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "puppybox";

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Berlin";

	services.desktopManager.plasma6.enable = true;

	services.udev.extraRules = ''
	  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
	'';
	services.displayManager.ly.enable = true;

	hardware.nvidia = {
	    modesetting.enable = true;
	    powerManagement.enable = false;  # Optional: disable if issues
	    powerManagement.finegrained = false;
	    open = false;  # Use proprietary for Steam compatibility
	    nvidiaSettings = true;
	    package = config.boot.kernelPackages.nvidiaPackages.stable;  # Or .latest
	};

	i18n.inputMethod = {
		enable = true;
		type = "fcitx5";

		fcitx5.addons = with pkgs; [
			fcitx5-mozc
			fcitx5-gtk
		];
	};

	hardware.graphics.enable = true;
	services.xserver.videoDrivers = [ "nvidia" ];

	programs.steam = {
		enable = true;
		package = pkgs.millennium-steam;
	};
	programs.helium.enable = true;
	services.flatpak.enable = true;

	users.users.nille = {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" "audio" ];
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
		fontconfig
		freetype
	];

	environment.systemPackages = with pkgs; [
		git
		wget
		kitty
		inputs.concord.packages.${pkgs.system}.default
	];

	  services.pipewire = {
	    enable = true;
	    pulse.enable = true;
	    alsa.enable = true;
	    alsa.support32Bit = true;
	    wireplumber.enable = true;
	  };

	networking.firewall.enable = false;

	system.stateVersion = "26.05"; #DONT CHANGE UNLESS YOU KNOW WHAT YOURE DOING!
}
