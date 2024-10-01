# Vagrant install

## Don't rely on vagrant-libvirt package

```console
sudo apt purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt
sudo apt autoremove

vagrant plugin install vagrant-libvirt
```

Source: https://vagrant-libvirt.github.io/vagrant-libvirt/#installation

## Interract with libvirt without sudo

```console
sudo usermod -aG libvirt $USER
```
