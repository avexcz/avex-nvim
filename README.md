#                                Avex Neovim 
![avex-dashboard](./screenshots/dashboard.png)
A high performance, fast and modular Neovim configuration built for developers who crave speed, simplicity and clean UI.
Built from scratch and is a lightweight, modular and open-source. Whether you are a minimalist or a power user, Avex neovim
provides a bridge between terminal and the modern Text editor IDE. Certain features are give below.

# Key-features
1. <b><u>Avex Dashboard</u></b>: A custom coded start screen using alpha-nvim with a "Avex" ASCII logo and shortcuts which lets you find, edit and work efficiently.
2. <b><u>Nightfly Colorscheme</u></b>: A deep, high-contrast professional theme optimized for long coding sessions.
3. <b><u>Custom Statusline</u></b>: A clean, informative bottom bar. Added shortcut to display diagnostics.
4. <b><u>Your favourite shortcuts</u></b>: Available visual shortcut hints made neovim easier. Space bar acting as a powerful leader key.
5. <b><u>Integrated terminal</u></b>: Built for fast, efficient, and a high-performance terminal accessible with a single keystroke. Perfect for managing scripts, viewing outputs and more.


### Screenshots


# Requirements
1. <b>Nerd Font</b>
A [nerd font](https://www.nerdfonts.com/font-downloads) is required to install so that it renders the custom icons in the dashboard, file explorer, and status line. Without it, icons will appear as broken boxes or question marks. Please do check if nerd font installed.
Recommended: JetBrainsMono Nerd Font

2. <b>Terminal emulator</b>
This neovim config is optimized for [ghostty](https://ghostty.org) fast rendering and native image support. It is GPU-accelerated to ensure the UI remains snappy during load.

NOTE: Mason is used to install and manage LSP servers, DAP servers, linters, and formatters via the `:Mason` command.


# Installation Method I
1. Clone the repository
Clone avex-nvim into your standard Neovim config directory:
```bash
git clone https://github.com/avexcz/avex-nvim.git ~/.config/nvim
```

## Using Packer to install plugins
2. Install Packer
Secondly, install the packer manager so that neovim notice the plugin-setup. 
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```


3. Install Plugins
Open Neovim. You may see some initial errors and this is normal as plugins aren't installed yet. Run the following command:
```vim
:PackerSync
```
Note: You may need to restart Neovim after the sync finishes for all UI elements to load correctly.



# Get Healthy
open neovim via `nvim` on terminal and enter the following:
```vim
:checkhealth
```
It is normal to have warnings. I'll update them, so don't worry and stay in touch!


# Installation Method II (Shortcut)
1. Docker
Install docker via [website](docker.com/products/docker-desktop) and sign-up.
 
2. Run Avex
Once Docker is running, you don't need to clone this repo or install plugins manually. Simply run the following command in your terminal:
```bash
docker run -it --rm devXam/avex-nvim

```

3. # This command copies the config from the Docker image to your local machine
```docker run --rm -v ~/.config/nvim:/install_destination devXam/avex-nvim \
       -c "cp -rv /root/.config/nvim/. /install_destination"```

WARNING: Add a "Backup" Warning

    🛑 WARNING: Running the install command will overwrite your existing Neovim configuration. If you have an existing config, back it up first:
    ```mv ~/.config/nvim ~/.config/nvim_backup```

    Note: Alpine linux's neovim is capped to 0.11.7 version which might cause tree-sitter an error after running `:checkhealth`. So it is best to ditch my configuration to your local machine and update your neovim's version:
    
    ### MacOS:
    ```bash
    brew upgrade neovim
    ```

    ### Windows:
    ```bash
    winget upgrade Neovim.Neovim
    ```

    ### Linux:

    Ubuntu/Debian:
    ```bash
    sudo apt update
    sudo apt upgrade neovim
    ```


    Arch:
    ```bash
        sudo pacman -Syu neovim
    ```

    Fedora:
    ```
    sudo dnf upgrade neovim
    ```


    If it fails, try manual installation from [github](https://github.com/neovim/neovim)

## Recommended Version
Neovim >= 0.11 is recommended for modern configurations.
