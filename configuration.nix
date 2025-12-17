{
  pkgs,
  ...
}:
{
  console.keyMap = "fr";
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
    desktopManager.xfce.enable = true;
    enable = true;
  };

  programs = {
    git.enable = true;
    nano.enable = true;
    nix-ld.enable = true;
    vim.enable = true;
  };
  environment.systemPackages = with pkgs; [
    curl
    gedit
    stdenv
    uv
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
