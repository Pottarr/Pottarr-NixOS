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
    # boot.loader.systemd-boot.enable = true;
    boot.tmp.cleanOnBoot = true;
    boot.loader.grub = {
        enable = true;
        device = "nodev"; # For UEFI systems
        efiSupport = true;
        useOSProber = true;
        copyKernels = false;
        configurationLimit = 10;
    };

    # keep only last N generations
    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = false;
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 30d";

    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "IdeaPad"; # Define your hostname.
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
        LC_TIME = "en_GB.UTF-8";
        # LC_TIME = "en_CUSTOM.UTF-8/UTF-8:./locales/en_custom";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # Configure USB Mounting
    services = {
        acpid.enable = true;
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
    };

    # services.logind.extraConfig = ''
    #     HandleLidSwitch=ignore
    #     HandleLidSwitchExternalPower=ignore
    #     HandleLidSwitchDocked=ignore
    # '';

    services.logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
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

    # Configure Display Manager ly
    services.displayManager = {
        # ly.enable = true;
        defaultSession = "none+i3";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.pottarr = {
        isNormalUser = true;
        description = "Pottarr";
        extraGroups = [ "networkmanager" "wheel" "video" "storage" "plugdev" "input" "docker" "libvirtd" "kvm" ];
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
        abook
        acpi
        alacritty
        arandr
        bat
        binutils
        blueman
        brightnessctl
        btop
        calcure
        calibre
        caligula
        # ciscoPacketTracer8
        cudatoolkit
        cudaPackages.cuda-samples
        curl
        dbgate
        digital
        discord
        docker
        docker-compose
        dunst
        emote
        eza
        fastfetch
        fd
        feh
        ffmpegthumbnailer
        flatpak
        font-manager
        fusuma
        fzf
        gcc_multi
        gdb
        gf
        gimp
        git
        glibc
        gnome-builder
        gnumake
        google-chrome
        gparted
        gtk4
        i3lock-color
        i3-volume
        jdk
        jupyter
        kdePackages.kdenlive
        lazydocker
        lazygit
        libgcc
        libreoffice
        libvlc
        libxkbcommon
        libffi
        localsend
        lua5_4
        luminance
        man
        man-pages
        man-pages-posix
        # minecraft
        mongodb-compass
        mongodb-tools
        mongosh
        mpv
        nasm
        ncspot
        # ncurses
        networkmanager
        networkmanagerapplet
        # For neovim
        lua-language-server
        rust-analyzer
        nodejs_24
        obs-studio
        # (obs-studio.override { plugins = [ obs-linuxbrowser ]; })
        # obs-studio-plugins.obs-webkitgtk
        openssl
        pandoc
        pasystray
        pavucontrol
        pcmanfm
        poppler-utils
        pgadmin4
        pgcli
        pmutils
        pnpm
        postgresql
        postgresql.pg_config
        posting
        postman
        prismlauncher
        projectlibre
        pulseaudioFull
        # python3Full
        # python313Full
        python3Packages.pip
        python3Packages.pyside6
        python3Packages.shiboken6
        python3Packages.tkinter
        qemu
        virt-manager
        qt6.qttools
        # qtcreator
        ripgrep
        rofi
        rustup
        rustc
        cargo
        rustfmt
        clippy
        scrot
        showmethekey
        skim
        skyemu
        snapshot
        spotify
        sqlite
        stdenv.cc
        swtpm
        telegram-desktop
        texliveFull
        thunderbird
        tigervnc
        tree
        ueberzugpp
        unetbootin
        unixtools.watch
        unzip
        v4l-utils
        vdirsyncer
        vlc
        volctl
        vscode
        wine
        # webkitgtk
        xcb-util-cursor
        xclip
        xdot
        # xfce.thunar
        # xfce.tumbler
        xfce.xfce4-settings
        xfce.xfconf
        pkgs.xorg.libxcb
        xorg.xcbutilwm
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        xournalpp
        xss-lock
        yazi
        yosys
        zathura
        zip
        zoom-us
    ];

    # DB
    services = {
        postgresql = {
            enable = true;
            package = pkgs.postgresql;
        };
        mysql = {
            enable = true;
            package = pkgs.mysql80;
            dataDir = "/var/lib/mysql";
        };
        mongodb = {
             enable = true;
            package = pkgs.mongodb-ce;
            bind_ip = "127.0.0.1";
        };
    };

    services.flatpak.enable = true;
    services.dbus.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdg.portal.config.common.default = "*";

    environment.sessionVariables.XDG_DATA_DIRS = lib.mkForce [
        "/home/pottarr/.nix-profile/share"
        "/etc/profiles/per-user/pottarr/share"
        "/run/current-system/sw/share"
        "/usr/local/share"
        "/usr/share"
        "/var/lib/flatpak/exports/share"
        "/home/pottarr/.local/share/flatpak/exports/share"
    ];

    services.libinput.touchpad.naturalScrolling = true;

    virtualisation = {
        docker = {
            enable = true;
        };
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
        nix-ld = {
            enable = true;
            # libraries = with pkgs; [
            #     glib
            # ];
        };
        # obs-studio = {
        #     enable = true;
        #     enableVirtualCamera = true;
        # };
        steam.enable = true;
        tmux.enable = true;
        zoxide.enable = true;
    };

    security.polkit.enable = true;

    security.pam.services.i3lock = {
        allowNullPassword = false;
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
        # (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
        nerd-fonts.caskaydia-cove
        ];
    };

    # https://nixos.wiki/wiki/OBS_Studio

    boot.kernelParams = [
        "sysrq_always_enabled"
    ];

    # boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.kernel.sysctl."kernel.sysrq" = 1;


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

    # Bluetooth
    hardware.bluetooth.enable = true;
    hardware.opentabletdriver.enable = true;


    # services.pulseaudio.enable = false; # Disable PulseAudio
    security.rtkit.enable = true;
    # services.pipewire = {
    #     enable = true;
    #     alsa.enable = true;
    #     alsa.support32Bit = true;
    #     pulse.enable = true;
    #     # jack.enable = true; # Optional, for JACK applications
    # };


    # services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        powerManagement.enable = false;
        prime = {
            offload.enable = true;
            offload.enableOffloadCmd = true;

            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
    };



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
