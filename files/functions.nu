# Nushell Utility Functions
# This file is managed by Home Manager and Conductor.

# --- Navigation Functions ---

# Create a directory and enter it.
#
# Examples:
#   mkcd new_project
#
# ```nu
#   mkcd temp_dir
# ```
export def --env mkcd [
    path: string # The path of the directory to create and enter
] {
    mkdir $path
    cd $path
}

# Go up the directory tree by one level.
#
# Examples:
#   up
export def --env up [] {
    cd ..
}

# Go back to the previous working directory.
#
# Examples:
#   back
export def --env back [] {
    cd -
}

# --- File Management Functions ---

# Smart directory listing with focus on size, mode, and name.
#
# Examples:
#   lss
#   lss /tmp
export def lss [
    path: path = "." # The path to list
] {
    ls -l $path | select name type size mode modified
}

# --- Data Transformation Functions ---

# Trim whitespace and remove empty lines from input.
#
# Examples:
#   "  line 1  \n\n  line 2  " | clean-lines
export def clean-lines [] {
    $in | lines | str trim | where ($it | is-not-empty)
}

# Flatten a nested record or list into a table of key-value pairs.
#
# Examples:
#   {a: {b: 1}} | to-kv
#   [1, {c: 2}] | to-kv
export def to-kv [
    prefix: string = "" # Optional prefix for keys
] {
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

# --- Git Status Idioms ---

# Get a structured table of git status.
#
# Examples:
#   gst
#   gst | where status == "M "
export def gst [] {
    git status --short | lines | parse --regex '^(?<status>..) (?<file>.+)'
}
