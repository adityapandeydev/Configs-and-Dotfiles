# Professional Neovim & Tmux Setup Plan

You requested a fluent, professional developer setup tailored for web/backend/systems programming, with 13 sequential backward-dated commits. 

## Solved Your Errors!
I investigated the errors you mentioned, and I found the culprits:
1. **The `\` (Backslash) Error:** Your Neo-tree explorer is mapped to the `\` key. On Windows, `\` is the folder separator. So when you try to type a path like `E:\Aditya`, Neovim thinks you are pressing the Neotree hotkey! **Fix:** I will remap your file explorer to the standard `<leader>e` (Space + e) keybind to completely eliminate this conflict.
2. **The Terminal CWD Error:** Your `Snacks.terminal` is launching PowerShell without explicitly passing the current working directory, causing PowerShell to fallback to your User `~` directory. **Fix:** I will configure the `<C-/>` keybind to explicitly pass `cwd = vim.fn.getcwd()` so the terminal always opens directly inside your active project.

## User Review Required
> [!IMPORTANT]
> Please review the plan below. I will execute the 13 commits backward in time as requested.

## Existing Features You Already Have
I reviewed your `main` branch `nvim` configuration. Here is what is already waiting for you:
- **VSCode-like Terminal**: You already have `snacks.terminal` installed! It is mapped to `<C-/>` (Ctrl + /). Pressing this will slide a floating/bottom terminal up, exactly like VSCode.
- **VSCode-like Folder Explorer**: You already have `neo-tree.nvim`. It will be remapped to `<leader>e`. 
- **Fuzzy Finder**: You have `telescope` mapped to `<leader>sf` (Search Files) and `<leader>sg` (Search Grep). 
- **LSP / Autocomplete**: Fully configured for Lua, C, C++, Rust, Python, Go, etc.

## Proposed Additions

### 1. Animated Cursor Movement
Since you already have `mini.nvim` installed, I will simply enable `mini.animate`. This will add smooth cursor trails and smooth scrolling between lines and files.

### 2. Tmux Setup (The Missing Piece)
While you have an in-editor terminal (`<C-/>`), professional setups rely on Tmux for terminal multiplexing and session persistence (if your computer crashes, your workspaces and servers keep running).
I will create a completely new `tmux/tmux.conf` with:
- **Prefix**: Changed from the awkward `Ctrl+b` to `Ctrl+a`.
- **Theme**: Catppuccin Mocha to match your Hyprland/Neovim aesthetic.
- **Vim Navigation**: Keybinds (`Ctrl+h/j/k/l`) to seamlessly jump between Neovim splits and Tmux panes as if they were the same program.
- **Session Manager**: `tmux-resurrect` so you can save and restore your exact terminal layouts.

### 3. Execution Strategy (13 Commits)
To show a detailed commit history over 13 days, I will implement and commit the features one by one with the requested backward dates:

1. **(13 days ago)**: Setup initial directory structure for tmux.
2. **(12 days ago)**: Add basic `tmux.conf` configuration.
3. **(11 days ago)**: Configure Tmux prefix to `Ctrl+a`.
4. **(10 days ago)**: Integrate Tmux Catppuccin theme.
5. **(9 days ago)**: Add Tmux pane splitting keybinds (similar to Hyprland).
6. **(8 days ago)**: Install `tmux-plugin-manager` configuration.
7. **(7 days ago)**: Add vim-tmux-navigator integration script.
8. **(6 days ago)**: Add Tmux-resurrect for session saving.
9. **(5 days ago)**: Enable `mini.animate` in Neovim for cursor animations.
10. **(4 days ago)**: Fix Neo-tree Windows backslash conflict (map to `<leader>e`).
11. **(3 days ago)**: Fix terminal spawning in user directory instead of working directory.
12. **(2 days ago)**: Polish Neo-tree visual aesthetics.
13. **(Today)**: Final polish and synchronization of dotfiles.

## Teaching & Walkthrough
After completion, I will generate a highly detailed `walkthrough.md` artifact acting as your personal "cheat sheet". It will contain exact workflows for backend/web development.
