{
  description = "My flake templates";
  outputs = { self }: {
    templates = {
      shell = {
        path = ./shell;
        description = "A flake that sets up the devShell";
      };
      vscode = {
        path = ./vscode;
        description = "A flake that sets up the devShell with vscode";
      };
      ocaml5 = {
        path = ./ocaml5;
        description = "A flake that sets up the devShell with ocaml 5";
      };
    };
  };
}
