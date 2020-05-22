echo "==> Installing missing dependencies..."
apt-get update
# Change US keyboard on Virtual Box Ubuntu Box to PT
sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="pt"/' /etc/default/keyboard
# Install puttygen (Create PPK automatically)
apt-get -y install putty-tools
# Convert .PEM to .PPK
# sudo puttygen /home/vagrant/.vagrant/machines/linuxconfig/virtualbox/private_key -o /home/vagrant/.vagrant/machines/linuxconfig/virtualbox/private-linuxconfig-vagrant.ppk -O private

