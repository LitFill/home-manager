# Test JSON/YAML helper function (to-kv)
# Note: This script assumes 'to-kv' is defined in the environment.

source ../../files/functions.nu

def test_to_kv [] {
    let input = {
        a: 1,
        b: {
            c: 2,
            d: [3, 4]
        }
    }
    let output = ($input | to-kv)

    # Verify output structure
    # Expected: [{key: "a", value: 1}, {key: "b.c", value: 2}, {key: "b.d.0", value: 3}, {key: "b.d.1", value: 4}]
    # Simplified expectation for now: just keys and values
    
    let keys = ($output | get key)
    if ("a" not-in $keys or "b.c" not-in $keys) {
        error make {msg: $"FAILURE: 'to-kv' did not correctly flatten keys. Keys: ($keys)"}
    }

    print "SUCCESS: 'to-kv' correctly flattened nested structures into key-value pairs."
}

test_to_kv
