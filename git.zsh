autoload -Uz add-zsh-hook

git_guard() {
    local -a words; words=( ${(z)2} )
    local i

    for ((i=1; i<=${#words}; i++)); do
        local cmd="${(Q)words[i]}"

        if [[ "$cmd" == "git" || "$cmd" == */git ]]; then
            local w1="${words[i+1]}"
            local w2="${words[i+2]}"
            local sub1="" sub2=""

            if [[ "$w1" == \$\{*\} ]]; then
                local v1="${w1#\$\{}"; v1="${v1%\}}"; sub1="${(P)v1}"
            elif [[ "$w1" == \$* ]]; then
                local v1="${w1#\$}"; sub1="${(P)v1}"
            else
                sub1="${(Q)w1}"
            fi

            if [[ "$w2" == \$\{*\} ]]; then
                local v2="${w2#\$\{}"; v2="${v2%\}}"; sub2="${(P)v2}"
            elif [[ "$w2" == \$* ]]; then
                local v2="${w2#\$}"; sub2="${(P)v2}"
            else
                sub2="${(Q)w2}"
            fi

            local alias_val
            alias_val=$(command git config --get "alias.$sub1" 2>/dev/null)
            if [[ -n "$alias_val" ]]; then
                local -a alias_args; alias_args=( ${(z)alias_val} )
                sub1="${alias_args[1]}"
                [[ -n "${alias_args[2]}" ]] && sub2="${alias_args[2]}"
            fi

            if [[ "$sub1" == "checkout" || ("$sub1" == "reset" && "$sub2" == "--hard") ]]; then
                echo "Error: git checkout is banned." >&2
                kill -s INT $$
                return 1
            fi
        fi
    done
}

add-zsh-hook preexec git_guard
