if status is-interactive
    # Commands to run in interactive sessions can go here
end

pokemon-colorscripts -r --no-title

starship init fish | source



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/nathan/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/home/nathan/Downloads/google-cloud-sdk/path.fish.inc'; end
alias dotfiles='/usr/bin/git --git-dir=/home/nathan/.dotfiles/ --work-tree=/home/nathan'
