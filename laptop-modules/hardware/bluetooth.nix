{
  config,
  pkgs,
  ...
}: {
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "bredr";
      };
    };
  };
}
