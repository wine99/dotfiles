{ pkgs, ... }: {
  programs.git = {
    enable = true;
    ignores = [
      ''
        # VSCode
        .vscode/*
        !.vscode/settings.json
        !.vscode/tasks.json
        !.vscode/launch.json
        !.vscode/extensions.json
        *.code-workspace
        # Local History for Visual Studio Code
        .history/

        .idea

        .direnv

        # Debug logs
        *.log

        # Editor artifacts
        *.swp
        *~

        # Common credential files
        **/credentials.json
        **/client_secrets.json
        **/client_secret.json
        *creds*
        *.dat
        *password*
        *.httr-oauth*

        # Private Files
        *.json
        *.csv
        *.csv.gz
        *.tsv
        *.tsv.gz
        *.xlsx

        # OS files
        Thumbs.db
        .DS_Store

        # Environments
        .env
        .venv
        env/
        venv/
        ENV/
        env.bak/
        venv.bak/
      ''
    ];

    # https://www.howtogeek.com/816878/how-to-back-up-and-restore-gpg-keys-on-linux/
    # https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/
    includes = [
      {
        contents = {
          user = {
            name = "Zijun Yu";
            email = "zijun.yu.joey@gmail.com";
            signingKey = "99B8DCACDF1042FD92328F9F5E5A013CFD481871";
          };
          commit.gpgSign = true;
          # github.user = "wine99";
          core.sshCommand = "ssh -i ~/.ssh/personal";
        };
      }
    ];
  };

  programs.ssh = {
    enable = true;
    # IdentitiesOnly, otherwise git will try with only the key that is in ssh-agent (`ssh-add -l`)
    extraConfig = ''
      AddKeysToAgent yes
      IgnoreUnknown UseKeychain
      UseKeychain yes
      IdentitiesOnly yes
    '';
  };
}
