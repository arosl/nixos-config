{
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (
      self: super: {
        weechat = super.weechat.override {
          configure = {...}: {
            scripts = with super.weechatScripts; [
              colorize_nicks
              url_hint
              weechat-autosort
              weechat-go
              weechat-grep
              weechat-notify-send
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
