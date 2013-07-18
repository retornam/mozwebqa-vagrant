# Vagrant Configuration for MozWebQA Projects

To get you started with MozWebQA projects as soon and as easily as we can.

## Usage Guide

### Requirements

- [Vagrant][Vag] - you will need to Vagrant installed in your machine. Get 
  the latest version of Vagrant for your OS [here][VagDL].
- [VirtualBox][VB] - you will also need VirtualBox (or any other virtual 
  machine provider). Get VirtualBox [here][VBDL].

[Vag]: http://www.vagrantup.com/
[VagDL]: http://downloads.vagrantup.com/
[VB]: https://www.virtualbox.org/
[VBDL]: https://www.virtualbox.org/wiki/Downloads

### Usage Guide

```
# clone mozwebqa-vagrant from Github
git clone git@github.com:retornam/mozwebqa-vagrant.git

# get into the cloned project's directory
cd mozwebqa-vagrant

# use vagrant to start the VM with our configuration
vagrant up

# ssh into the VM to use it
vagrant ssh
```
