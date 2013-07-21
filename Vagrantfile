# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Box config
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # mozilla-projects directory is synced and made available in the VM
  config.vm.synced_folder './mozilla-projects', '/home/vagrant/mozilla-projects'

  # Puppet config for provisioning the VM
  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base.pp"
  end
end
