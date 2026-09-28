{ pkgs, lib, ... }:
let
  # Flake ref the prebuild tracks. Keep it in sync with the profile's
  # `Original flake URL` (`nix profile list`) so the store path built here is
  # exactly the one `nix profile upgrade` links.
  ompFlake = "github:can1357/oh-my-pi#default";

  # Skip on battery: the build saturates every core for the better part of an
  # hour. A machine with no BAT* glob makes grep fail on the literal
  # unexpanded path (hence -s, and -q to keep the journal quiet), so desktops
  # build normally. Exit 1 makes systemd skip the unit, exit 0 lets it run.
  onAc = "grep -qs Discharging /sys/class/power_supply/BAT*/status && exit 1; exit 0";
in
{
  # oh-my-pi itself is NOT a Home Manager package: it lives in the standalone
  # `nix profile` (see `nix profile list`). Upstream pushes no binary cache, so
  # every upgrade compiles from source — the release build alone takes 35m45s
  # (`Finished release profile [optimized] target(s)` in `nix log`) on 4 cores.
  #
  # Prebuilding the flake's default output nightly moves that ~40 minutes off
  # the upgrade path: the store path is already valid, so
  # `nix profile upgrade oh-my-pi` only evaluates the flake and swaps the
  # profile link, which takes seconds.
  #
  # NOTE: this Home Manager revision exposes unit sections freeform, so options
  # land under their real systemd section ([Unit] / [Service] / [Timer]).
  # Values must stay on one line: systemd's ini parser reads every unescaped
  # newline in a value as the start of a new section.
  systemd.user.services.omp-prebuild = {
    Unit = {
      Description = "Prebuild oh-my-pi so profile upgrades only relink";
    };

    Service = {
      Type = "oneshot";
      ExecCondition = "${pkgs.runtimeShell} -c '${onAc}'";
      ExecStart = "${lib.getExe pkgs.nix} build ${ompFlake} --no-link";
      Environment = [
        "PATH=${
          lib.makeBinPath [
            pkgs.nix
            pkgs.coreutils
            pkgs.git
            pkgs.gnused
          ]
        }"
      ];
      # A full cargo release build outlasts any default start timeout.
      TimeoutStartSec = "2h";
      # Give interactive work priority over the nightly build.
      Nice = 10;
    };
  };

  systemd.user.timers.omp-prebuild = {
    Unit = {
      Description = "Nightly oh-my-pi prebuild";
    };

    Timer = {
      Unit = "omp-prebuild.service";
      OnCalendar = "*-*-* 04:00:00";
      # Laptop asleep at 04:00 runs it on the next wake instead of skipping.
      Persistent = true;
      RandomizedDelaySec = "30m";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
