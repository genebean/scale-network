{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.scale-network.services.rsyslogd;

  inherit (lib.modules)
    mkIf
    ;

  inherit (lib.options)
    mkEnableOption
    ;
in
{
  options.scale-network.services.rsyslogd.enable = mkEnableOption "SCaLE network rsyslogd setup";

  config = mkIf cfg.enable {

    networking.firewall = {
      allowedTCPPorts = [ 514 ];
      allowedUDPPorts = [ 514 ];
    };

    environment.systemPackages = with pkgs; [ rsyslog ];

    services.rsyslogd = {
      enable = true;
      defaultConfig = ''
        module(load="imtcp")
        input(type="imtcp" port="514")

        module(load="imudp")
        input(type="imudp" port="514")

        $template RemoteLogs,"/persist/rsyslog/%HOSTNAME%/%PROGRAMNAME%.log"
        ?RemoteLogs

        $template RemoteLogs2,"/persist/rsyslog/%HOSTNAME%/messages.log"
        ?RemoteLogs2
      '';
    };
  };
}
