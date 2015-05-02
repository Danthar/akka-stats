# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "akka-stats"
  config.vm.box = "chef/ubuntu-14.04"

  config.vm.network "forwarded_port", guest: 3000, host: 3000 #grafana
  config.vm.network "forwarded_port", guest: 8125, host: 8125, protocol: 'tcp' #statsd
  config.vm.network "forwarded_port", guest: 8125, host: 8125, protocol: 'udp' #statsd
  config.vm.network "forwarded_port", guest: 80, host: 8080 #graphite

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      
    }

    chef.run_list = [  
      "recipe[akka-stats::default]"
    ]
  end

end
