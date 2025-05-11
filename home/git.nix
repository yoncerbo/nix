{ ... }: {
  programs.git = {
    enable = true;
    userName = "meersen";
    userEmail = "<>";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}
