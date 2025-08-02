{ pkgs, ... }:
{
    programs.obs-studio = {
        enable = true;

        # optional Nvidia hardware acceleration
        # package = (
        #   pkgs.obs-studio.override {
        #     cudaSupport = true;
        #   }
        # );

        plugins = with pkgs.obs-studio-plugins; [
        obs-linuxbrowser
        # wlrobs
        # obs-backgroundremoval
        # obs-pipewire-audio-capture
        # obs-vaapi #optional AMD hardware acceleration
        # obs-gstreamer
        # obs-vkcapture
        ];
    };
}
