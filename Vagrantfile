# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    #config.vm.box = "base-hd20-centos65"
    config.vm.box = "oid"
    config.vm.hostname = "oid.fico.com"

    # Forward Oracle ports
    config.vm.network :forwarded_port, guest: 1521, host: 1521
    config.vm.network :forwarded_port, guest: 1158, host: 1158

    config.vm.network :private_network, ip: "33.33.33.33"

    config.vm.synced_folder ".", "/vagrant"

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
    end

    #config.vm.provision "shell", path: "scripts/bootstrap.sh"

end
