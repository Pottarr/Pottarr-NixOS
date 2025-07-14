# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "Siri"; # Define your hostname.
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
    services.xserver = {
        enable = true;
        windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [ i3status i3lock i3blocks ];
        };
    };

    # Configure Display Manager ly
    services.displayManager = {
        ly.enable = true;
        defaultSession = "i3+none";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.pottarr = {
        isNormalUser = true;
        description = "Pottarr";
        extraGroups = [ "networkmanager" "wheel" "video" "storage" "plugdev" ];
        # packages = with pkgs; [];
        shell = pkgs.zsh;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;


    nixpkgs.config.allowBroken = true;


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        # Added by Pottarr
        acpi
        alacritty
        arandr
        blueman
        brightnessctl
        curl
        dunst
        binutils
        discord
        fastfetch
        fd
        feh
        flatpak
        fzf
        gcc
        gdb
        git
        glib
        google-chrome
        gparted
        i3lock-color
        jdk
        lazygit
        lua5_4
        libvlc
        libxkbcommon
        minecraft
        nasm
        networkmanagerapplet
        # For neovim
        lua-language-server
        rust-analyzer
        nodejs_24
        obs-studio
        pasystray
        pavucontrol
        prismlauncher
        # pulseaudio
        python313Full
        python313Packages.pip
        # qt6.full
        # qtcreator
        ripgrep
        rofi
        rustup
        scrot
        spotify
        sqlite
        texliveFull
        tree
        unetbootin
        unixtools.watch
        unzip
        v4l-utils
        vlc
        vscode
        xclip
        xfce.thunar
        xfce.xfconf
        xss-lock
        zathura
    ];

    services.flatpak.enable = true;
    services.dbus.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdg.portal.config.common.default = "*";


    programs = {
        # ZSH
        zsh = {
            enable = true;
            ohMyZsh = {
                enable = true;
                theme = "robbyrussell";
            };
        };
        dconf = {
            enable = true;
        };
        # Brightness CLI light
        # light.enable = true;
        # i3lock
        i3lock.enable = true;
        neovim = {
            enable = true;
        };
        # obs-studio = {
        #     enable = true;
        #     enableVirtualCamera = true;
        # };
        steam.enable = true;
        tmux.enable = true;
    };

    security.pam.services.i3lock = {
        allowNullPassword = false;
    };
    
    # Configure Keyboard Input fcitx
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [ fcitx5-configtool fcitx5-m17n ];
    };

    # NerdFont
    fonts = {
        enableDefaultPackages = true;
        packages  = with pkgs; [
        # (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
        nerd-fonts.caskaydia-cove
        ];
    };

    # https://nixos.wiki/wiki/OBS_Studio


    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
    ];

    # boot.extraModprobeConfig = ''
    #     options v4l2loopback devices=1 video_nr=0 card_label="OBS Virtual Camera" exclusive_caps=1
    # '';


    #
    #
    # boot.extraModulePackages = with config.boot.kernelPackages; [
    #     v4l2loopback
    # ];
    # boot.kernelModules = [ "v4l2loopback" ];
    #
    #
    boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    #
    #
    #
    # boot.extraModprobeConfig = ''
    #     options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    # '';
    security.polkit.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true;


    services.pulseaudio.enable = false; # Disable PulseAudio
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true; # Optional, for JACK applications
    };


    services.xserver.videoDrivers = [ "modesetting" ];



    # hardware.graphics = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     vaapiIntel
    #     vaapiVdpau
    #     libvdpau-va-gl
    #   ];
    #   extraPackages32 = with pkgs.pkgsi686Linux; [
    #     vaapiIntel
    #     vaapiVdpau
    #     libvdpau-va-gl
    #   ];
    # };

    # services.xserver.videoDrivers = [ "nvidia" ];

    # hardware.nvidia = {
    #     modesetting.enable = true;
    #     # open = true; # For RTX / GTX 16xx and newer
    #     open = false;
    #     nvidiaSettings = true;
    #     prime = {
    #         sync.enable = true;
    #         intelBusId = "PCI:0:2:0";
    #         nvidiaBusId = "PCI:1:0:0";
    #     };
    # };

    # hardware.graphics.enable = true;
    # hardware.nvidia = {
    #   modesetting.enable = true; # Enable modesetting
    #   nvidiaSettings = true; # Enable Nvidia settings
    #   package = config.boot.kernelPackages.nvidiaPackages.stable; # Use the stable Nvidia package
    #   open = false; # Keep the proprietary drivers closed
    # };

    # services.xserver.videoDrivers = [ "nvidia" ]; # Add Nvidia to the video drivers list
    # services.xserver.videoDrivers = [ "nouveau" ]; # Add Nvidia to the video drivers list

    # boot.kernelModules = [ "nouveau" ];

    # hardware.nvidia.prime = {
    #   offload.enable = true; # Enable prime offload
    #   intelBusId = "PCI:0:2:0"; # Replace with your Intel bus ID
    #   nvidiaBusId = "PCI:88:0:0"; # Replace with your Nvidia bus ID
    # };
    #
    # hardware.nvidia-container-toolkit.enable = true;





    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

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
