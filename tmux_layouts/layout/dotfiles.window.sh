# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
#window_root "~/Projects/dotfiles"

# Create new window. If no argument is given, window name will be based on
# layout file name.
window_root "$DOTFILES"
new_window "dotfiles"

split_h 50

run_cmd "fv" 1
run_cmd "git status" 2

select_pane 1

# Split window into panes.
#split_v 20
#split_h 50

# Run commands.
#run_cmd "top"     # runs in active pane
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
#select_pane 0
