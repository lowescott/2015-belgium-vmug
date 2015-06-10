# Files for 2015 Belgium VMUG

The files in this GitHub repository are in support of demos given at the Belgium VMUG, 11 June 2015.

## Contents

* **LICENSE**: All files in this directory are licensed under the MIT License, the details for which are found in this file.

* **meta-data**: This file is used by `cloud-init` to customize the VMware Photon instances created by Vagrant.

* **README.md**: The file you're reading right now.

* **servers.yml**: This YAML file contains the specific configuration details for all the VMs that will be created, accessed, and destroyed using Vagrant. You can edit this file to create more VMs (simply ensure each entry contains information for name, box, RAM, and vCPUs to be assigned, following YAML syntax), or you can edit this file to change the details for any of the VMs.

* **setup.sh**: This Bash shell script prepares VMware Photon to use `cloud-init` for customization, as well as upgrades VMware Photon to use the latest Docker Engine version.

* **user-data**: This `cloud-init` file provides the instructions on what customizations to perform to VMware Photon.

* **Vagrantfile**: This file is used by Vagrant to create, access, power off, and destroy the VMs in this environment. There is no configuration data in this file; all the configuration data is stored elsewhere (primarily in `servers.yml`).

## Instructions

To use these files on your own system, you'll need:

1. To install a virtualization solution (this was tested with VMware Fusion 6.0.5, but should work with Fusion or Workstation)
2. To install Vagrant (this was tested with Vagrant 1.7.2, the latest available version; you'll need Vagrant 1.6 or later)
3. To install the Vagrant VMware plugin, if using a VMware desktop virtualization solution
4. To use `vagrant box add` to install the VMware Photon ("vmware/photon") Vagrant box
5. To copy these files down into a directory on your system, either using `git clone` or by downloading a ZIP archive of the GitHub repository
6. Internet connectivity when you run `vagrant up`, so that the setup script (`setup.sh`) can download the latest Docker Engine for your VMware Photon VMs

When using `vagrant up` to instantiate the VMs defined in `servers.yml` via Vagrant, please note that VMware Photon won't process the `cloud-init` customizations when it is first turned up. You'll want to run `vagrant halt` to shut all the VMs down, then `vagrant up` against to restart them (or individually reboot each VM).

Enjoy!
