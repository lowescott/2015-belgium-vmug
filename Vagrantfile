# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# Require 'yaml' module
require 'yaml'

# Read YAML file to get VM configuration information
# Edit servers.yml to change VM configuration details
servers = YAML.load_file('servers.yml')

# Look for user-data and meta-data files in same directory
USER_DATA = File.join(File.dirname(__FILE__), "user-data")
META_DATA = File.join(File.dirname(__FILE__), "meta-data")

# Create and configure the VMs
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Use Vagrant's default insecure SSH key
  config.ssh.insert_key = false

  # Iterate through entries in YAML file to create VMs
  servers.each do |servers|

    # Configure the VMs per details in servers.yml
    config.vm.define servers["name"] do |srv|

      # Don't check for box updates
      srv.vm.box_check_update = false

      # Specify the hostname of the VM
      srv.vm.hostname = servers["name"]

      # Specify the Vagrant box to use
      srv.vm.box = servers["box"]

      # Disable default synced folder (not supported with Photon)
      srv.vm.synced_folder ".", "/vagrant", disabled: true

      # Configure VMs with RAM and CPUs per settings in servers.yml
      srv.vm.provider :vmware_fusion do |vmw|
        vmw.vmx["memsize"] = servers["ram"]
        vmw.vmx["numvcpus"] = servers["vcpu"]
      end # srv.vm.provider
    
      # Configure Photon boxes
      if srv.vm.box == "vmware/photon"
        srv.vm.provision "file", source: "#{USER_DATA}", destination: "/home/vagrant/user-data"
        srv.vm.provision "file", source: "#{META_DATA}", destination: "/home/vagrant/meta-data"
        srv.vm.provision "shell", path: "setup.sh", privileged: true
      end # if srv.vm.box
    end # config.vm.define
  end # servers.each
end # Vagrant.configure
