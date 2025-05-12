{ pkgs, ... }: {
  home.packages = [
    pkgs.markdown-oxide
    pkgs.clang-tools # clangd
    pkgs.bear # gnerates compile_commands.json for clangd
    pkgs.rust-analyzer
    pkgs.nodePackages.typescript-language-server
  ];
}
