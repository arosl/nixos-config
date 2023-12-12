{pkgs, ...}: {
  programs.password-store = {
    enable = true;
    settings = {
      # PASSWORD_STORE_DIR = "~/work/.password-store";
      PASSWORD_STORE_CLIP_TIME = "60";
      # PASSWORD_STORE_KEY = "";
    };
  };
}
