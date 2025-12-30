# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
    wallpaper = ../../dotfiles/wallpaper/Background.png;
in {
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # Bootloader.
    # boot.loader.systemd-boot.enable = true;
    boot.loader.grub = {
        enable = true;
        device = "nodev"; # For UEFI systems
        # efiSupport = true;
        useOSProber = true;
    };

    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "ThinkPad"; # Define your hostname.
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
        displayManager.lightdm = {
            enable =  true;
            greeters.gtk = {
                enable = true;
                theme.name = "Adwaita-dark";
                cursorTheme.name = "Adwaita";
            };
            background = wallpaper;
        };
        windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [ i3status i3lock i3blocks ];
        };
    };

    # Configure Display Manager
    services.displayManager = {
        # ly.enable = true;
        defaultSession = "none+i3";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.pottarr = {
        isNormalUser = true;
        description = "Pottarr";
        extraGroups = [ "networkmanager" "wheel" "video" "storage" "plugdev" "input" ];
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
        bat
        blueman
        brightnessctl
        btop
        caligula
        curl
        dunst
        binutils
        discord
        digital
        docker
        eza
        fastfetch
        fd
        feh
        ffmpegthumbnailer
        font-manager
        #Fingerprint Scan
        fprintd
        fzf
        gcc
        gdb
        gf
        git
        glib
        google-chrome
        gparted
        i3lock-color
        i3-volume
        jdk
        jupyter
        lazydocker
        lazygit
        libvlc
        libxkbcommon
        libffi
        localsend
        lua5_4
        nasm
        networkmanager
        networkmanagerapplet
        # For neovim
        lua-language-server
        rust-analyzer
        nodejs_24
        obs-studio
        openssl
        pandoc
        pasystray
        pavucontrol
        pcmanfm
        poppler-utils
        playerctl
        pmutils
        postgresql
        postgresql.pg_config
        posting
        postman
        pulseaudioFull
        # python3Full
        python3Packages.pip
        python3Packages.tkinter
        ripgrep
        rofi
        rustup
        scrot
        skim
        spotify
        sqlite
        texliveFull
        tree
        ueberzugpp
        unetbootin
        unixtools.watch
        unzip
        v4l-utils
        vdirsyncer
        vlc
        volctl
        emote
        xclip
        # xfce.thunar
        # xfce.tumbler
        xfce.xfce4-settings
        xfce.xfconf
        xournalpp
        xss-lock
        yazi
        zathura
        zip
    ];

    services.libinput.touchpad.naturalScrolling = true;

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
        # i3lock
        i3lock.enable = true;
        neovim = {
            enable = true;
        };
        nix-ld = {
            enable = true;
        };
        tmux.enable = true;
        zoxide.enable = true;
    };

    services.fprintd.enable = true;

    security.polkit.enable = true;

    security.pam.services = {
        i3lock.allowNullPassword = false;
        i3lock-color.fprintAuth = true;
        lightdm.fprintAuth = true;
        sudo.fprintAuth = true;
    };
    
    # Configure Keyboard Input fcitx
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        # fcitx5.addons = with pkgs; [ fcitx5-configtool fcitx5-m17n ];
        fcitx5.addons = with pkgs; [ fcitx5-m17n ];
    };

    # NerdFont
    fonts = {
        enableDefaultPackages = true;
        packages  = with pkgs; [
        # noto-fonts-emoji
        # (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
        nerd-fonts.caskaydia-cove
        ];
    };

    boot.kernelParams = [ "sysrq_always_enabled" ];
    # boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.kernel.sysctl."kernel.sysrq" = 1;


    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
    ];

    boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    # Bluetooth
    hardware.bluetooth.enable = true;

    security.rtkit.enable = true;

    services.xserver.videoDrivers = [ "modesetting" ];

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
    networking.firewall.allowedTCPPorts = [
        80
        443
        22
    ];

    services = {
        postgresql = {
            enable = true;
            package = pkgs.postgresql;
        };
    };

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

    nix.settings = {
        experimental-features = [
            "nix-command"
                "flakes"
        ];
        cores = 0;
        max-jobs = "auto";
    };
}
