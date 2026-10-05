{
  # Tooling that is only needed while working on a project, not while reading
  # mail, so it lives in `nix develop` instead of `config/packages.nix`.
  pkgs,
  ...
}:
let
  # Systems every Common Lisp project ends up needing. `sbcl.withPackages`
  # wires them into ASDF through CL_SOURCE_REGISTRY, so `(asdf:load-system
  # :bordeaux-threads)` resolves without a Quicklisp download. `swank` is the
  # REPL backend conjure's Common Lisp client talks to.
  commonLispSystems =
    ps: with ps; [
      alexandria
      babel
      bordeaux-threads
      caveman2
      cl-ppcre
      dexador
      fiveam
      swank
      trivial-backtrace
      trivial-gray-streams
      trivial-utf-8
    ];
in
{
  name = "litfill-dev";

  packages = [
    (pkgs.sbcl.withPackages commonLispSystems)
  ];

  # Conjure's Common Lisp client talks to swank on 127.0.0.1:4005; this line is
  # the whole workflow.
  shellHook = ''
    echo "Common Lisp: sbcl, then (require :asdf) (asdf:load-system :swank) (swank:create-server :port 4005 :interface \"127.0.0.1\" :dont-close t); :ConjureConnect in Neovim"
  '';
}