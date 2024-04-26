## Check if the computer support Virtualization Tech
```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
```
If the output is zero then go to bios settings and enable VT-x (Virtualization Technology Extension) for Intel processor and AMD-V for AMD processor.

## Install QEMU and Virtual Machine Manager
```bash
sudo apt install qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y
```
note:
- qemu-kvm: the emulator it self
- libvirt-daemon: runs virtualization in background
- bridge-utils: important networking dependencies
- virt-manager: the graphical program we'll use to work with VMs


then verify that Libvirtd service is started
```bash
sudo systemctl status libvirtd.service
```

## Start Default Network for Networking
VIRSH is a command to directly interact with our VMs from terminal. We use it to list networks, vm-status and various other tools when we need to make tweaks. Here is how we start the default and make it auto-start after reboot.
```bash
sudo virsh net-start default

# sudo virsh net-destroy default
# sudo virsh net-undefine default
# sudo systemctl restart libvirtd
```

Network default started
```bash
sudo virsh net-autostart default
```

Check status with
```bash
sudo virsh net-list --all
```

## Add User to libvirt to Allow Access to VMs
```bash
sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER
```

reboot and we are finished

添加 intel_iommu=on 和 iommu=pt 到 Grub 配置中的目的是启用 Intel 的 IOMMU
（Input-Output Memory Management Unit）功能，并将 IOMMU 设置为 "passthrough" 模式。

解释一下这两个参数的作用：

intel_iommu=on： 启用 Intel 的 IOMMU 功能。IOMMU 是用于虚拟化和硬件设备直通的技术，它可以提供更好的设备隔离和更高的系统性能。

iommu=pt： 将 IOMMU 设置为 "passthrough" 模式。"passthrough" 意味着虚拟机可以直接访问主机系统上的硬件设备，
而无需通过主机操作系统的中介。这对于需要更接近原生性能的虚拟化场景非常有用，特别是对于图形加速等要求较高的应用。

这两个参数通常在启用硬件虚拟化（如 KVM 虚拟化）时使用，以改善虚拟机性能和提供更好的设备支持。
然而，使用这些参数之前，请确保你的硬件和软件支持这些功能，并且你已经了解了相关的安全和性能影响。