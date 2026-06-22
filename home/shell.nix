{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake .#nixos";
      btop = "btop --force-utf";
      ff = "fastfetch";
      c = "clear";
      q = "exit";
      ".." = "cd ..";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      ls = "lsd";
      lst = "lsd --tree";
      ga = "git add .";
      cat = "bat";
      lg = "lazygit";
      v = "nvim";
      nv = "nvim .";
      y = "yazi";
      gs = "git status";
      gd = "git diff";
      gco = "git checkout";
      gcb = "git checkout -b";
      gp = "git push";
      gl = "git pull";
      glog = "git log --oneline -n 10";
      dps = "docker ps";
      dpa = "docker ps -a";
      di = "docker images";
      dcu = "docker compose up -d";
      dcd = "docker compose down";
      path = "echo -e \${PATH//:/\\\\n}";
    };

    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      share = true;
    };

    initContent = ''
      # zsh plugins and completions setup
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu select
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      # Transient prompt configuration for starship
      TRANSIENT_PROMPT_PROMPT='$(starship prompt --terminal-width="$COLUMNS" --keymap="''${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="''${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="''${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
      TRANSIENT_PROMPT_RPROMPT='$(starship prompt --right --terminal-width="$COLUMNS" --keymap="''${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="''${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="''${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
      TRANSIENT_PROMPT_TRANSIENT_PROMPT='$(starship module character)'

      # fzf
      eval "$(fzf --zsh)"

      # custom commit function
      gc() {
        git commit -m "$*"
      }
      
      export PATH=$HOME/.local/bin:$PATH
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  
  # Inject the starship config natively via TOML text
  xdg.configFile."starship.toml".text = ''
    "$schema" = 'https://starship.rs/config-schema.json'

    palette = 'catppuccin_mocha'

    format = """
    [](red)\
    $os\
    $username\
    [](bg:peach fg:red)\
    $directory\
    [](bg:yellow fg:peach)\
    $git_branch\
    $git_status\
    [](fg:yellow bg:teal)\
    $c\
    $rust\
    $golang\
    $nodejs\
    $php\
    $java\  
    $kotlin\
    $haskell\
    $python\
    $dart\
    $dotnet\
    $deno\
    $cmake\
    $gleam\
    $erlang\
    $elixir\
    $gradle\
    $zig\
    $nix_shell\
    [](fg:teal bg:blue)\
    $docker_context\
    $conda\
    [](fg:blue bg:lavender)\
    $time\
    [ ](fg:lavender)\
    $line_break$character"""

    [os]
    disabled = false
    style = "bg:red fg:crust"

    [os.symbols]
    Windows = ""
    Ubuntu = "󰕈"
    SUSE = ""
    Raspbian = "󰐿"
    Mint = "󰣭"
    Macos = "󰀵"
    Manjaro = ""
    Linux = "󰌽"
    Gentoo = "󰣨"
    Fedora = "󰣛"
    Alpine = ""
    Amazon = ""
    Android = ""
    Arch = "󰣇"
    CachyOS = "󰣇"
    Artix = "󰣇"
    CentOS = ""
    Debian = "󰣚"
    Redhat = "󱄛"
    RedHatEnterprise = "󱄛"

    [username]
    show_always = true
    style_user = "bg:red fg:crust"
    style_root = "bg:red fg:crust"
    format = '[ $user ]($style)'

    [directory]
    style = "fg:crust bg:peach"
    format = "[ $path ]($style)"
    truncation_length = 1
    truncation_symbol = "…/"

    [directory.substitutions]
    "Documents" = "󰈙 "
    "Downloads" = " "
    "Music" = " "
    "Pictures" = " "

    [git_branch]
    symbol = ""
    style = "bg:yellow"
    format = '[[ $symbol $branch ](fg:crust bg:yellow)]($style)'

    [git_status]
    disabled = false
    style = "bg:yellow fg:crust"
    format = '[[($all_status$ahead_behind )](fg:crust bg:yellow)]($style)'
    up_to_date = '[ ✓](bg:yellow fg:green)'
    untracked = '[?($count)](bg:yellow fg:crust)'
    stashed = '[$](bg:yellow fg:crust)'
    modified = '[!($count)](bg:yellow fg:crust)'
    renamed = '[»($count)](bg:yellow fg:crust)'
    deleted = '[✘($count)](bg:yellow fg:crust)'
    staged = '[++($count)](bg:yellow fg:crust)'
    ahead = '[⇡($count)](bg:yellow fg:crust)'
    diverged = '⇕[(bg:yellow fg:crust)[⇡($ahead_count)](bg:yellow fg:crust)[⇣($behind_count)](bg:yellow fg:crust)](bg:yellow fg:crust)'
    behind = '[⇣($count)](bg:yellow fg:crust)'

    [nodejs]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [c]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [rust]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [golang]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [php]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [java]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [kotlin]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [haskell]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [python]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [dart]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [dotnet]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [deno]
    symbol = "🦕"
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [cmake]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [gleam]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [erlang]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [elixir]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [gradle]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [zig]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [nix_shell]
    symbol = ""
    style = "bg:teal"
    format = '[[ $symbol( $version) ](fg:crust bg:teal)]($style)'

    [docker_context]
    symbol = ""
    style = "bg:blue"
    format = '[[ $symbol( $context) ](fg:crust bg:blue)]($style)'

    [conda]
    symbol = " "
    style = "bg:blue"
    format = '[[ $symbol( $environment) ](fg:crust bg:blue)]($style)'

    [time]
    disabled = false
    time_format = "%R"
    style = "bg:lavender"
    format = '[[  $time ](fg:crust bg:lavender)]($style)'

    [line_break]
    disabled = false

    [character]
    disabled = false
    success_symbol = '[[➜](bold fg:green) ❯](peach)'
    error_symbol = '[[➜](bold fg:red) ❯](peach)'
    vimcmd_symbol = '[](bold fg:green)'
    vimcmd_replace_one_symbol = '[](bold fg:red)'
    vimcmd_replace_symbol = '[](bold fg:red)'
    vimcmd_visual_symbol = '[](bold fg:peach)'

    [palettes.catppuccin_mocha]
    rosewater = "#f5e0dc"
    flamingo = "#f2cdcd"
    pink = "#f5c2e7"
    mauve = "#cba6f7"
    red = "#f38ba8"
    maroon = "#eba0ac"
    peach = "#fab387"
    yellow = "#f9e2af"
    green = "#a6e3a1"
    teal = "#94e2d5"
    sky = "#89dceb"
    sapphire = "#74c7ec"
    blue = "#89b4fa"
    lavender = "#b4befe"
    text = "#cdd6f4"
    subtext1 = "#bac2de"
    subtext0 = "#a6adc8"
    overlay2 = "#9399b2"
    overlay1 = "#7f849c"
    overlay0 = "#6c7086"
    surface2 = "#585b70"
    surface1 = "#45475a"
    surface0 = "#313244"
    base = "#1e1e2e"
    mantle = "#181825"
    crust = "#11111b"
  '';
}
