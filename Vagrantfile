Vagrant.configure("2") do |config|
    config.vm.provider :libvirt do |libvirt|
        libvirt.machine_type = "q35"
        libvirt.cpu_mode = "host-passthrough"
        libvirt.driver = "kvm"
    end
end
