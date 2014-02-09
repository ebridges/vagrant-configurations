# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Define and configure private servers
  private_servers = { 
    :private010 => '10.0.0.10',
    :private011 => '10.0.0.11'
  }

  private_servers.each do |private_server_name, private_server_ip|
    config.vm.define private_server_name do |private_server_config|
      private_server_config.vm.box = "precise64"
      private_server_config.vm.host_name = private_server_name.to_s
      private_server_config.vm.network :private_network, ip: private_server_ip
      private_server_config.vm.provision "shell", inline: "echo provisioning private server"
    end
  end

  # Configure public server
  config.vm.define :public100 do |public_server_config|
    public_server_config.vm.box = "precise64"
    public_server_config.vm.host_name = "public100"
    # public interface on the network, using dhcp
    public_server_config.vm.network :public_network
    # private interface on the network
    public_server_config.vm.network :private_network, ip: "10.0.0.100"
    public_server_config.vm.provision "shell", inline: "echo provisioning public server"
  end
end
