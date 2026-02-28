# Nushell Utility Functions
# This file is managed by Home Manager and Conductor.

# Navigation Functions

# Create a directory and enter it.
export def --env mkcd [path: string] {
    mkdir $path
    cd $path
}

# Go up the directory tree.
export def --env up [] {
    cd ..
}

# Go back to the previous directory.
export def --env back [] {
    cd -
}

# Smart directory listing with focus on size, mode, and name.
export def lss [path: path = "."] {
    ls -l $path | select name type size mode modified
}

# Data Transformation Functions

# Trim whitespace and remove empty lines from input string or list.
export def clean-lines [] {
    $in | lines | str trim | where ($it | is-not-empty)
}

