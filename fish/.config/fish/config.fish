if status is-interactive
    alias k=kubectl
    alias imgcat='wezterm imgcat'
    alias ghs='gh copilot suggest'
    alias ghe='gh copilot suggest'
end

function fish_user_key_bindings
    bind -k nul forward-word
end
