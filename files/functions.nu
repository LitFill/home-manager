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

# Flatten a nested record or list into a table of key-value pairs.
export def to-kv [prefix: string = ""] {
    let input = $in
    let type = ($input | describe)

    if ($type =~ "record") {
        $input | transpose key value | each { |row|
            let new_key = if ($prefix | is-empty) { $row.key } else { $"($prefix).($row.key)" }
            $row.value | to-kv $new_key
        } | flatten
    } else if ($type =~ "list") {
        $input | enumerate | each { |item|
            let new_key = if ($prefix | is-empty) { $"($item.index)" } else { $"($prefix).($item.index)" }
            $item.item | to-kv $new_key
        } | flatten
    } else {
        [[key, value]; [$prefix, $input]]
    }
}

