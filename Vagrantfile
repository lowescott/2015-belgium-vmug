# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version '>= 1.6.0'
VAGRANTFILE_API_VERSION = '2'

# Require 'yaml' module
require 'yaml'

# Read YAML file with VM details (box, CPU, RAM, IP addresses)
# Edit machines.yml to change VM configuration details
machines = YAML.load_file(File.join(File.dirname(__FILE__), 'machines.yml'))

# Look for user-data and meta-data files in same directory
USER_DATA = File.join(File.dirname(__FILE__), 'user-data')
META_DATA = File.join(File.dirname(__FILE__), 'meta-data')

# Create and configure the VMs
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Always use Vagrant's default insecure key
  config.ssh.insert_key = false

  # Iterate through entries in YAML file to create VMs
  machines.each do |machine|

    # Configure the VMs per details in machines.yml
    config.vm.define machine['name'] do |srv|

      # Don't check for box updates
      srv.vm.box_check_update = false

      # Specify the hostname of the VM
      srv.vm.hostname = machine['name']

      # Specify the Vagrant box to use (use VMware box by default)
      srv.vm.box = machine['vmw_box']

      # Disable default synced folder (not supported with Photon)
      srv.vm.synced_folder '.', '/vagrant', disabled: true

      # Configure CPU & RAM per settings in machines.yml (Fusion)
      srv.vm.provider 'vmware_fusion' do |vmw|
        vmw.vmx['memsize'] = machine['ram']
        vmw.vmx['numvcpus'] = machine['vcpu']
      end # srv.vm.provider 'vmware_fusion'
    
      # Configure CPU & RAM per settings in machines.yml (VirtualBox)
      srv.vm.provider 'virtualbox' do |vb, override|
        vb.memory = machine['ram']
        vb.cpus = machine['vcpu']
        override.vm.box = machine['vb_box']
      end # srv.vm.provider 'virtualbox'

      # Configure Photon boxes
      if srv.vm.box == 'vmware/photon'
        srv.vm.provision 'file', source: "#{USER_DATA}", destination: '/home/vagrant/user-data'
        srv.vm.provision 'file', source: "#{META_DATA}", destination: '/home/vagrant/meta-data'
        srv.vm.provision 'shell', path: 'setup.sh', privileged: true
      end # if srv.vm.box
    end # config.vm.define
  end # machines.each
end # Vagrant.configure
