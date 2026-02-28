# Test Git status summary function (gstat)
# Note: This script assumes 'gstat' is defined in the environment.

source ../../files/functions.nu

def test_gst [] {
    # Execute gst
    let output = (gst)

    # Verify output is a table
    if ($output | describe) !~ "table" {
        error make {msg: $"FAILURE: 'gst' did not return a table. Output: ($output)"}
    }

    # Verify columns
    let columns = ($output | columns)
    if ("status" not-in $columns or "file" not-in $columns) {
        error make {msg: $"FAILURE: 'gst' table is missing required columns. Columns: ($columns)"}
    }

    print "SUCCESS: 'gst' returned a structured table of Git status."
}

test_gst
