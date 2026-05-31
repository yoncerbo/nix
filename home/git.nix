{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.email = "<>";
      user.name = "meersen";
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}
