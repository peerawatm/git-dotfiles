# Git Config Dotfiles

This repository contains:
* [config.template](./config.template) - Global Git configuration template with custom aliases.
* [hooks/pre-push](./hooks/pre-push) - Hook script that intercepts and blocks force-pushing.
* [git.zsh](./git.zsh) - Shell wrapper that intercepts and blocks `git reset --hard` and `git checkout` at the Zsh level.
