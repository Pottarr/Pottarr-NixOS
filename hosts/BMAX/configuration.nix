# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
    wallpaper = ../../dotfiles/wallpaper/Background.png;
    # mouse_script = /etc/ELECOM.sh;
in {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;

    # keep only last N generations
    # system.autoUpgrade.enable = true;
    # system.autoUpgrade.allowReboot = false;
    # nix.gc.automatic = true;
    # nix.gc.dates = "weekly";
    # nix.gc.options = "--delete-older-than 30d";

    # boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "BMAX"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Bangkok";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = { LC_ADDRESS = "th_TH.UTF-8";
        LC_IDENTIFICATION = "th_TH.UTF-8";
        LC_MEASUREMENT = "th_TH.UTF-8";
        LC_MONETARY = "th_TH.UTF-8";
        LC_NAME = "th_TH.UTF-8";
        LC_NUMERIC = "th_TH.UTF-8";
        LC_PAPER = "th_TH.UTF-8";
        LC_TELEPHONE = "th_TH.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # Configure USB Mounting
    services = {
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
    };

    # Configure i3wm
    # services.xserver = {
    #     enable = true;
    #     displayManager.lightdm = {
    #         enable =  true;
    #         greeters.gtk = {
    #             enable = true;
    #             theme.name = "Adwaita-dark";
    #             cursorTheme.name = "Adwaita";
    #         };
    #         background = wallpaper;
    #     };
    #     windowManager.i3 = {
    #     enable = true;
    #     extraPackages = with pkgs; [ i3status i3lock i3blocks ];
    #     };
    # };

    # Configure Display Manager ly
    # services.displayManager = {
    #     # ly.enable = true;
    #     defaultSession = "none+i3";
    # };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.pottarr = {
        isNormalUser = true;
        description = "Pottarr";
        extraGroups = [ "networkmanager" "wheel" "storage" "plugdev" "input" ];
        # packages = with pkgs; [];
        shell = pkgs.zsh;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        # Added by Pottarr
        btop
        curl
        docker
        eza
        fastfetch
        fd
        fzf
        git
        lazydocker
        lazygit
        networkmanager
        ripgrep
        tree
        unzip
        yazi
    ];

    # DB
    # services = {
    #     postgresql = {
    #         enable = true;
    #         package = pkgs.postgresql;
    #     };
    #     mysql = {
    #         enable = true;
    #         package = pkgs.mysql80;
    #         dataDir = "/var/lib/mysql";
    #     };
    #     mongodb = {
    #          enable = true;
    #         package = pkgs.mongodb-ce;
    #         bind_ip = "127.0.0.1";
    #     };
    # };

    # services.libinput.touchpad.naturalScrolling = true;

    virtualisation.docker = {
        enable = true;
    };

    programs = {
        # ZSH
        zsh = {
            enable = true;
            ohMyZsh = {
                enable = true;
                theme = "robbyrussell";
            };
        };
        neovim = {
            enable = true;
        };
        # nix-ld = {
        #     enable = true;
        # };
        tmux.enable = true;
        zoxide.enable = true;
    };
    
    # Configure Keyboard Input fcitx
    # i18n.inputMethod = {
    #     enable = true;
    #     type = "fcitx5";
    #     fcitx5.addons = with pkgs; [ fcitx5-configtool fcitx5-m17n ];
    # };

    # NerdFont
    # fonts = {
    #     enableDefaultPackages = true;
    #     packages  = with pkgs; [
    #     # (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    #     nerd-fonts.caskaydia-cove
    #     ];
    # };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];
}
