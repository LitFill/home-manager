# Test smart directory listing function (lss)
# Note: This script assumes 'lss' is defined in the environment.

source ../../files/functions.nu

def test_lss [] {
    # Execute lss
    let output = (lss)

    # Verify output is a table
    if ($output | describe) !~ "table" {
        error make {msg: $"FAILURE: 'lss' did not return a table. Output: ($output)"}
    }

    # Verify columns
    let columns = ($output | columns)
    if ("name" not-in $columns or "size" not-in $columns or "mode" not-in $columns) {
        error make {msg: $"FAILURE: 'lss' table is missing required columns. Columns: ($columns)"}
    }

    print "SUCCESS: 'lss' returned a table with required columns."
}

test_lss
