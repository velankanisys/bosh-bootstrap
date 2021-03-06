module Bosh::Bootstrap::NetworkProviders
  class OpenStack
    attr_reader :provider_client

    def initialize(provider_client)
      @provider_client = provider_client
    end

    def perform
      provider_client.create_security_group("ssh", "ssh", 22)
      provider_client.create_security_group("dns_server", "dns_server", protocol: "udp", ports: (53..53) )
      provider_client.create_security_group("bosh", "bosh", [4222, 6868, 25250, 25555, 25777] )
    end

  end
end
Bosh::Bootstrap::NetworkProviders.register_provider("openstack", Bosh::Bootstrap::NetworkProviders::OpenStack)
