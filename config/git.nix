{ config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = config.accounts.email.accounts."litfill".realName;
        email = config.accounts.email.accounts."litfill".address;
      };

      init.defaultBranch = "main";

      credential = {
        helper = "!/usr/bin/gh auth git-credential";
        useHttpPath = true;
      };

      difftool.prompt = false;
      pager.difftool = true;
      pull.ff = "only";

      diff = {
        tool = "difftastic";
      };

      alias = {
        cv = "commit -v";
      };
    };
  };
}
