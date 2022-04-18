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
    };
  };
}
