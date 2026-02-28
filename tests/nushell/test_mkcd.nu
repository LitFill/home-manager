# Test mkcd function
# Note: This script assumes 'mkcd' is defined in the environment.

source ../../files/functions.nu

def test_mkcd [] {
    let test_dir = "/tmp/nushell_test_mkcd"
    if ($test_dir | path exists) {
        rm -rf $test_dir
    }

    # Execute mkcd
    # This should FAIL if mkcd is not defined.
    mkcd $test_dir

    # Check if directory was created
    if ($test_dir | path exists) {
        # Check if current working directory is test_dir
        if ($env.PWD == $test_dir) {
            print "SUCCESS: mkcd created directory and changed into it."
        } else {
            error make {msg: $"FAILURE: mkcd created directory but did not change into it. CWD is ($env.PWD)"}
        }
    } else {
        error make {msg: "FAILURE: mkcd did not create the directory."}
    }

    # Clean up: move out of the test directory before deleting it.
    cd /tmp
    rm -rf $test_dir
}

test_mkcd
