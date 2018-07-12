# vagrant-tripleo-quickstart

The `Vagrantfile` helps to automatically configure a virtual Libvirt lab environment for setting up a TripleO cloud. It can be used with the [TripleO Quickstart](https://docs.openstack.org/tripleo-quickstart/latest/ project) or a [manual installation of TripleO](https://ekultails.github.io/rootpages/openstack.html#id6).

## Usage

Copy the desired Vagrant file to use.

```
$ cp Vagrantfile_single_node Vagrantfile
```

```
$ cp Vagrantfile_multi_node Vagrantfile
```

## Disk Space

tripleo-quickstart requires 120GB of disk space and vagrant-libvirt cannot automatically resize file systems so this needs to be done manually.

* Create all of the virtual machines.

```
$ vagrant up
```

* Stop the virtual machine to be able to resize the file system.

```
$ vagrant halt
```

* Resize the root file system for the CentOS box.

```
$ sudo qemu-img create -f qcow2 /var/lib/libvirt/images/vagrant-tripleo-quickstart_tripleo.imgNEW 120G
$ sudo virt-resize --expand /dev/vda3 --LV-expand /dev/VolGroup00/LogVol00 /var/lib/libvirt/images/vagrant-tripleo-quickstart_tripleo.img /var/lib/libvirt/images/vagrant-tripleo-quickstart_tripleo.imgNEW
$ sudo rm -f /var/lib/libvirt/images/vagrant-tripleo-quickstart_tripleo.img
$ sudo mv /var/lib/libvirt/images/vagrant-tripleo-quickstart_tripleo.imgNEW /var/lib/libvirt/images/vagrant-tripleo-quickstart_tripleo.img
```

## Network Interfaces

* The first network interface should also be removed from the Overcloud virtual machines. This is automatically created by the `vagrant-libvirt` plugin for management.

```
$ sudo bash remove_eth0.sh
```

* Then start the "undercloud" virtual machine only.

```
$ vagrant up undercloud
```

## Installation

The Undercloud can now be accessed for installation and setup.

```
$ vagrant ssh undercloud
```
