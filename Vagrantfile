# Be aware that old versions are different to install and check if plugins are installed
# Not countaing that are people with such old Vagrant versions
# Read the disclaimer in case of doubt: https://github.com/hashicorp/vagrant/wiki/Available-Vagrant-Plugins#disclaimers

# Make sure required plugins are installed
# ex: required_plugins = %w({:name => "vagrant-hosts", :version => ">= 2.8.0"})

Vagrant.require_version ">= 2.2.2"

required_plugins = [
  {:name => "vagrant-hosts", :version => ">= 2.8.0"},
  {:name => "vagrant-vbguest", :version => ">= 0.16.0"},
  {:name => "vagrant-docker-compose", :version => ">= 1.3.0"},
  {:name => "vagrant-disksize", :version => ">=0.1.3"}
]
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin?(plugin[:name], plugin[:version]) }
if not plugins_to_install.empty?
    plugins_to_install.each { |plugin_to_install|
      puts "Installing plugin: #{plugin_to_install[:name]}, version #{plugin_to_install[:version]}"
      if system "vagrant plugin install #{plugin_to_install[:name]} --plugin-version \"#{plugin_to_install[:version]}\""
      else
        abort "Installation of one or more plugins has failed. Aborting."
      end
    }
    exec "vagrant #{ARGV.join(' ')}"
  end
  
# Ubuntu 18.04.3 LTS - Code Name Bionic - 64 Bits - EOL 2023-04
BOX_NIX     = "ubuntu/bionic64"
# BOX_VER     = "20191113.0.0"
GUI         = false
BOX_MEM     = 2048
BOX_CPU     = 1
BOX_HDD     = '20GB'
DOMAIN             = ".lc.inet"
NETWORK            = "192.168.200."
LASTOCTET          = "100"
NETMASK            = "255.255.255.0"
GEN_SET_ADV        = "bidirectional"

Vagrant.configure("2") do |config|
    config.vm.define "linuxconfig" do |lc|
        lc.vm.box = BOX_NIX
        # lc.vm.box_version = BOX_VER
        lc.disksize.size = BOX_HDD
        lc.vm.provider "virtualbox" do |vbox|
            vbox.gui = GUI
            vbox.memory = BOX_MEM
            vbox.cpus = BOX_CPU
            vbox.name = "linuxconfig"
            vbox.customize ["modifyvm", :id, "--clipboard", GEN_SET_ADV]
            vbox.customize ["modifyvm", :id, "--draganddrop", GEN_SET_ADV]
        end
        lc.vm.hostname = "linuxconfig" + DOMAIN
        lc.vm.network 'private_network', ip: NETWORK + LASTOCTET, netmask: NETMASK
        lc.vm.provision "shell", path: "vagrant/provision/master_#{BOX_NIX.gsub('/', '_')}.sh", args: [ NETWORK ]
        lc.vm.synced_folder "./config/", "/root", type: "rsync", rsync__auto: true
        lc.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
        lc.vm.provision :hosts, :sync_hosts => true
        lc.vm.provision :hosts, :add_localhost_hostnames => false
        lc.vm.provision "shell", inline: "sudo shutdown -r now"
    end
end