{
    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "LitFill";
                email = "marrazzy54@gmail.com";
            };

            init.defaultBranch = "main";

            "credential \"https://github.com\"" = {
                helper = "!/usr/bin/gh auth git-credential";
            };

            "credential \"https://gist.github.com\"" = {
                helper = "!/usr/bin/gh auth git-credential";
            };

            difftool.prompt = false;
            pager.difftool = true;
            pull.ff = "only";

            diff = {
                tool = "difftastic";
                external = "difft";
            };

            alias = {
                cv = "commit -v";
            };
        };
    };
}
