# Custom functions, aliases, and other imperative commands can be placed here.
# Home-manager now manages most of the shell configuration declaratively.

use std/clip
use std null_device

def --env newdir [path : string] {
    mkdir $path
    cd $path
}
