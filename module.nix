self: {
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.cockroachdb22;
in {
  options.services.cockroachdb22 = {
    enable = mkEnableOption "CockroachDB";
    package = mkOption {
      type = types.package;
      default = self.packages.${pkgs.system}.default;
      description = "CockroachDB package to use.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.cockroachdb22 = {
      description = "Starts CockroachDB.";
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = "${cfg.package}/bin/cockroach start-single-node --http-addr :9090 --listen-addr=localhost";
    };
  };
}