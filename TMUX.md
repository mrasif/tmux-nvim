# T-mux

It is a Tmux user guide. Tmux and VIM works awesome for development.

## Shell Command
1. Create new session           ->> `tmux new -s <session-name>`
2. List session                 ->> `tmux list-sessions`
3. Attach session               ->> `tmux attach-session -t <session-name>`
4. Detach session               ->> `Ctrl+b -> d`

## Short-cuts

1. Ctrl+b                       ->> Activate keybinding
2. Ctrl+b   -> [                ->> Activate Scrolling
3. Ctrl+b   -> [ -> Ctrl+Space  ->> Activate selection mode
4. Alt+w    ->                  ->> Copy selected text
5. Ctrl+b   -> ]                ->> Paste copied text
6. Ctrl+b   -> Number-1-9       ->> Switch between windows
7. Ctrl+b   -> n                ->> Next window
8. Ctrl+b   -> p                ->> Previous window
9. Ctrl+b   -> Ctrl+s           ->> Save tmux session
10. Ctrl+b  -> Ctrl+r           ->> Restore session


## Commands
1. Rename session name          -> `:rename-session <new-session-name>`
2. Rename window name           -> `:rename-window <new-window-name>`
3. Create window                -> `:new-window -n <window-name>`
4. Re-order window              -> `:swap-window -s <source-win-no> -t <target-win-no>`
5. Kill Session                 -> `:kill-session`

