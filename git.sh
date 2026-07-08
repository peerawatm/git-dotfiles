git() {
  case "$1" in
    reset)
      # Loop through arguments to robustly detect the exact '--hard' flag
      for arg in "$@"; do
        if [ "$arg" = "--hard" ]; then
          echo "Error: 'git reset --hard' is banned." >&2
          return 1
        fi
      done
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
