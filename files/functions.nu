# Nushell Utility Functions
# This file is managed by Home Manager and Conductor.

# Navigation Functions

# Create a directory and enter it.
export def --env mkcd [path: string] {
    mkdir $path
    cd $path
}

