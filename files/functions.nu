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

