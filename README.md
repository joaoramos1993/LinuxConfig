<!-- TABLE OF CONTENTS -->
## Table of Contents
- [LinuxConfig](#linuxconfig)
  - [Vagrant](#vagrant)
    - [Download](#download)
    - [Vagrant Setup](#vagrant-setup)
    - [Objective of Vagrant in Linuxconfig Project](#objective-of-vagrant-in-linuxconfig-project)
    - [Use Vagrant File](#use-vagrant-file)
      - [Change keyboard layout through virtualbox GUI on the terminal](#change-keyboard-layout-through-virtualbox-gui-on-the-terminal)
    - [SSH Client](#ssh-client)
    - [What does this Box contain](#what-does-this-box-contain)
      - [Linux Config Dev Machine](#linux-config-dev-machine)
    - [Vagrant User Experience Deployment](#vagrant-user-experience-deployment)


# LinuxConfig
Configurations of Vim Screen and Bashrc
Test

In order to use copy the files using, located in __config__:
```
cp .bashrc ~/.bashrc
cp .vimrc ~/.vimrc
cp .screenrc ~/.screenrc
```

:warning: No need to copy the above :warning:
It's synced with the vagrant machine.

Change to root user and check linux configuration files. 
Check if your changes in Vim/Vi editor and your bash [runcom](http://www.catb.org/jargon/html/R/rc-file.html) file with root are as intended.

## Vagrant

Vagrant is a tool for building and managing virtual machine environments in a single workflow. With an easy-to-use workflow and focus on automation, Vagrant lowers development environment setup time, increases production parity, and makes the "works on my machine" excuse a relic of the past.

- [Get started with Vagrant](https://www.vagrantup.com/intro/getting-started/index.html "Get started with Vagrant")
- [Vagrant Documentation](https://www.vagrantup.com/docs/ "Vagrant Documentation")

### Download

[Download Location](https://www.vagrantup.com/downloads.html)

### Vagrant Setup

- Virtualbox (Provider)
- Vagrant > 2.2.2

### Objective of Vagrant in Linuxconfig Project

This will help deploy a Linux machine to test out linux user environment configurations. Deploying what is on the repo and making it available directly on the machine.


### Use Vagrant File

This was tested in Windows Host.\
In your IDE (VSCode) or in your OS host shell interpreter, open the terminal on the root folder where vagrant file is located and run the following:

```sh
vagrant up
```

This will start the project and build the needed environment.
[For more information, click here](https://www.vagrantup.com/docs/cli/up.html)\
Vagrant File is written in Ruby syntax standard. Ruby and [DSL's](https://en.wikipedia.org/wiki/Domain-specific_language).

:warning::warning::warning: __Warning__ :warning::warning::warning: \
Don't run the following:

```sh
vagrant provision
```

This file was not made to provision the same stuff twice due to duplication settings on the virtual machine. Follow the initial steps again by doing the following.\
After stopping the machine (manually) in virtualbox or with:

```sh
vagrant halt
```

To delete the machine:

```sh
vagrant destroy
```

#### Change keyboard layout through virtualbox GUI on the terminal

The keyboard configurationin the box is in English. This will only seen if using virtualbox GUI to access the VM.

```sh
sudo dpkg-reconfigure keyboard-configuration
```

Altough the above is taken care of to use the shell output through the Virtualbox GUI with the PT keyboard layout the above instruction will predure in the readme for future configurations if ever need change, due to multiple setup workstation that may be involved in ALTRAN and in any development circunstances.

Through putty your keyboard setting will be as your system is configured to. Since putty is a shell interpreter on another layer.

### SSH Client

We recommend putty and the below configuration part.\
But you are free to add your own key to the server and use any client that supports OpenSSH-2 PEM with RSA type (with the key vagrant generates).

You can also use:

```sh
vagrant ssh
```

With the terminal of your favourite IDE or powershell in the root folder where __Vagrantfile__ is located to connect to your new provision machine.\
For more information check the [documentation](https://www.vagrantup.com/docs/cli/ssh.html).

### What does this Box contain

#### Linux Config Dev Machine

- Already syncing the git repository folder __config__ with root home folder. 
  
- Content:
  - [Ubuntu Bionic 18.04 LTS (64)](https://app.vagrantup.com/ubuntu/boxes/eoan64) - EOL 2023-04
    - Syncing the main 3 files of the Project
      - bashrc
      - screenrc
      - vimrc
    - US Layout changed to PT on VB GUI Usage

- Note:
  - There is a reboot to apply keyboard layout and GUI at the end of the installation

- Virtualized Components:
  - CPU: 1 Core
  - RAM: 2048 MB
  - Machine Domain: lc.inet
  - Host Only Virtual Network Adapter IP: 192.168.200.100
  - DISK Size: 20 GB (without this parameter the default is 10 GB)
  - Bidrectional clipboard & drag and drop enabled


For more information in customizable Virtual Box settings through Vagrant:
- <https://www.virtualbox.org/manual/ch08.html>

### Vagrant User Experience Deployment

This is a user experience and the time taken of Vagrant local deployment.
This was achieved prepending the command time as follows to the command to run in vagrant.

Installation Time: __'6 minutes'__

__Virtual Box Version:__  5.2.34 r133893 (Qt5.6.2)
__Vagrant Version:__ 2.2.6

```sh
time vagrant up
```
__Deploy:__
- real    6m2,688s