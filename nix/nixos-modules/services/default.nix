{ ... }:
{
  imports = [
    ./bind-master
    ./bind-slave.nix
    ./gitlab.nix
    ./kea-master.nix
    ./monitoring.nix
    ./ntp.nix
    ./prometheus.nix
    ./rsyslogd.nix
    ./signs.nix
    ./ssh.nix
  ];
}
