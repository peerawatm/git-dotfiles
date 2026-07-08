git() {
  case "$1" in
    reset)
      # Block hard resets to protect local uncommitted changes
      if [[ " $* " == *" --hard "* ]]; then
        echo "Error: 'git reset --hard' is banned." >&2
        return 1
      fi
      command git "$@"
      ;;

    checkout)
      # Force use of modern, safer alternatives: switch and restore
      echo "Error: 'git checkout' is banned. Use 'git switch' (branches) or 'git restore' (files)." >&2
      return 1
      ;;

    *)
      # Pass through all other git commands
      command git "$@"
      ;;
  esac
}
