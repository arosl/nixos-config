{
  config,
  pkgs,
  lib,
  ...
}: {
  sops.secrets.wireguard_3_priv = {
    owner = "systemd-network";
  };

  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
          MTUBytes = "1420";
        };
        # See also man systemd.netdev (also contains info on the permissions of the key files)
        wireguardConfig = {
          # File needs to be readable for the systemd-network user
          PrivateKeyFile = "${config.sops.secrets.wireguard_3_priv.path}";
          ListenPort = 51820;
        };
        wireguardPeers = [
          {
            wireguardPeerConfig = {
              PublicKey = "NcjDKFH7CEJg8PXbxZQTQmFXlax9x8+ao1/ZNXU0Rno=";
              AllowedIPs = [
                "10.0.0.0/10"
                "178.255.144.0/24"
                "91.220.196.0/24"
                "185.226.148.0/22"
                "193.58.250.0/24"
                "91.247.228.0/22"
                "195.35.109.0/24"
                "91.229.142.0/23"
                "195.43.63.34/32"
                "158.38.179.0/24"
                "158.39.52.0/24"
                "78.91.120.0/24"
                "151.252.14.100/32"
              ];
              Endpoint = "178.255.144.49:1199";
            };
          }
        ];
      };
    };

    networks.wg0 = {
      # See also man systemd.network
      matchConfig.Name = "wg0";
      # IP addresses the client interface will have
      address = ["10.17.150.3/24"];
      DHCP = "no";
      dns = ["10.47.47.50" "10.47.47.51"];
      networkConfig = {
        IPv6AcceptRA = false;
      };
      routes = [
        {
          routeConfig.Destination = "10.0.0.0/10";
        }
        {
          routeConfig.Destination = "91.220.196.0/24";
        }
        {
          routeConfig.Destination = "185.226.148.0/22";
        }
        {
          routeConfig.Destination = "193.58.250.0/24";
        }
        {
          routeConfig.Destination = "91.247.228.0/22";
        }
        {
          routeConfig.Destination = "195.35.109.0/24";
        }
        {
          routeConfig.Destination = "91.229.142.0/23";
        }
        {
          routeConfig.Destination = "195.43.63.34/32";
        }
        {
          routeConfig.Destination = "158.38.179.0/24";
        }
        {
          routeConfig.Destination = "158.39.52.0/24";
        }
        {
          routeConfig.Destination = "78.91.120.0/24";
        }
        {
          routeConfig.Destination = "151.252.14.100/32";
        }
      ];
    };
  };
}
