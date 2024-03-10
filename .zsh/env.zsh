# GO
export PATH=$PATH:/usr/lib/go/bin:$HOME/go/bin
export GOBIN=$HOME/go/bin

# RUST
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$(rustc --print sysroot)/lib/rustlib/src/rust/src

export _JAVA_AWT_WM_NONREPARENTING=1
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
