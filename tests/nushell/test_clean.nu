# Test data cleaner function (clean-lines)
# Note: This script assumes 'clean-lines' is defined in the environment.

source ../../files/functions.nu

def test_clean_lines [] {
    let input = "  line 1  

  line 2  

line 3"
    let output = ($input | clean-lines)

    let expected = ["line 1", "line 2", "line 3"]
    if ($output != $expected) {
        error make {msg: $"FAILURE: 'clean-lines' did not correctly clean the input. Output: ($output), Expected: ($expected)"}
    }

    print "SUCCESS: 'clean-lines' correctly trimmed and filtered empty lines."
}

test_clean_lines
