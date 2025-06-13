# config.nu
#
# Installed by:
# version = "0.104.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
$env.config.show_banner = false
$env.EDITOR = "nvim"
$env.config = {
    # main configuration
}


cat ~/.cache/wal/sequences

# pre shell load configurations

oh-my-posh init nu --config ~/wal-hul10.omp.toml --print | save ~/.oh-my-posh.nu --force
source ~/.oh-my-posh.nu

use ~/.config/nushell/modules/conda.nu
source ~/.zoxide.nu

# Zoxide integration


# some other config and script loading
# aliases
alias l = ls
alias ll = ls -l
alias la = ls -a
alias lla = ls -la
alias rfw = sudo systemctl reboot --firmware
alias fash = ~/scripts/fastwallsh
alias pwal = ~/scripts/pywal
alias lwarp = ~/scripts/launch_warp.sh
alias fash = ~/scripts/fastwallsh
alias update = do { sudo pacman -Syu; paru -Syu }
alias vi = vim
alias vim = nvim
alias _nvim = NVIM_APPNAME=adventnvim nvim
alias cd = z

fash
