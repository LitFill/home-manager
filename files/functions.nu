# Nushell Utility Functions
# This file is managed by Home Manager and Conductor.

# --- Navigation Functions ---

# Create a directory and enter it.
#
# Examples:
#   mkcd new_project
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

# Fuzzy find a directory and cd into it.
#
# Examples:
#   lcd
#   lcd /tmp
export def --env lcd [
    path: path = "." # The path to search for directories
] {
    let dirs = (ls $path | where type == "dir" | sort-by name)

    if ($dirs | is-empty) {
        print $"(ansi yellow)No directories found in '(ansi green)($path)(ansi yellow)'.(ansi reset)"
        return
    }

    let prompt = $"(ansi cyan)Select a directory in (ansi green)($path)(ansi cyan) to cd into:(ansi reset)"
    let selection = (
        $dirs | input list --fuzzy --display {
            |it| $"(ansi yellow)($it.name)(ansi reset)"
        } $prompt
    )

    if $selection != null {
        cd $selection.name
    }
}

# List directories with indices and cd into the selected number.
#
# Examples:
#   ncd
export def --env ncd [
    path: path = "." # The path to list directories from
] {
    let dirs = (ls $path | where type == "dir" | sort-by name)

    if ($dirs | is-empty) {
        print $"(ansi yellow)No directories found in '(ansi green)($path)(ansi yellow)'.(ansi reset)"
        return
    }

    $dirs | select name modified | print

    let choice = (input $"(ansi yellow)Enter the directory index: (ansi reset)")

    if ($choice | is-empty) {
        return
    }

    try {
        let idx = ($choice | into int)
        let selection = ($dirs | get $idx | get name)
        cd $selection
    } catch {
        print $"(ansi red_bold)Error:(ansi reset) Invalid index '($choice)'."
    }
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

# Show indented content of a file.
#
# Examples:
#   show README.md
export def show [
    fname: path # The file to display
] {
    let content = (
        open --raw $fname
        | lines
        | each { |line| $"    ($line)" }
        | str join "\n"
    )
    $"($fname):\n\n($content)\n"
}

# Show content of all files in the current directory recursively.
#
# Examples:
#   glimpse
export def glimpse [] {
    ls **/*
    | where type == file
    | get name
    | par-each { |file| show $file }
    | str join "\n"
}

# --- Data Transformation Functions ---

# Trim whitespace and remove empty lines from input.
#
# Examples:
#   "  line 1  \n\n  line 2  " | clean-lines
export def clean-lines [] {
    $in | lines | str trim | where ($it | is-not-empty)
}

# Join a list of strings with newlines.
#
# Examples:
#   ['a', 'b'] | unlines
export def unlines [] : list<string> -> string {
    $in | str join "\n"
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

# --- Development Tools ---

# Initialize opam environment.
#
# Examples:
#   load-opam
#   load-opam --version 4.14.0
export def --env load-opam [
    --version: string = "" # The opam switch version to load
] {
    let switch = if ($version | is-empty) { "default" } else { $version }
    let opam_env = (opam env --switch=($switch) --shell=powershell | parse "$env:{key} = '{val}'" | transpose -rd)
    load-env $opam_env
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
