{
  i18n.defaultLocale = "fr_FR.UTF-8";
  time.timeZone = "Europe/Paris";

  users.users.vm = {
    isNormalUser = true;
    initialPassword = "vm";
    extraGroups = [ "wheel" ];
  };
  security.sudo.wheelNeedsPassword = false;

  services.displayManager.autoLogin = {
    enable = true;
    user = "vm";
  };
  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    desktopManager.xfce.enable = true;
  };

  programs = {
    git.enable = true;
    nix-ld.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
