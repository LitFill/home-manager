# Test navigation shortcuts
# Note: This script assumes 'up' and 'back' are defined in the environment.

source ../../files/functions.nu

def test_nav [] {
    let start_dir = $env.PWD
    let parent_dir = ($start_dir | path dirname)

    # Test 'up'
    up
    if ($env.PWD != $parent_dir) {
        error make {msg: $"FAILURE: 'up' did not change to parent directory. CWD is ($env.PWD), expected ($parent_dir)"}
    }
    print "SUCCESS: 'up' changed to parent directory."

    # Test 'back'
    # Need to go back to start_dir
    back
    if ($env.PWD != $start_dir) {
        error make {msg: $"FAILURE: 'back' did not change to previous directory. CWD is ($env.PWD), expected ($start_dir)"}
    }
    print "SUCCESS: 'back' changed to previous directory."
}

test_nav
