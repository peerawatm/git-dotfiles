autoload -Uz add-zsh-hook

git_guard() {
    if [[ "$1" == "git reset --hard"* || "$1" == "git checkout"* ]]; then
        echo "Error: Intercepted. Command is banned." >&2
        kill -s INT $$
    fi
}

add-zsh-hook preexec git_guard
