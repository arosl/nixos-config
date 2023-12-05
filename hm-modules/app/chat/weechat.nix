{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    (
      self: super: {
        weechat = super.weechat.override {
          configure = {availablePlugins, ...}: {
            scripts = with super.weechatScripts; [
              colorize_nicks
              url_hint
              weechat-autosort
              weechat-go
              weechat-grep
              weechat-matrix
              weechat-notify-send
              # weechat-otr
            ];
          };
        };
      }
    )
  ];

  home.packages = with pkgs; [
    weechat
  ];
}
