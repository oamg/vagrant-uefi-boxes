# Vagrant UEFI Boxes

This project is intended to be used to generate vagrant boxes that has UEFI
support enabled by default.

Supported systems so far:

| CentOS Linux  | Oracle Linux | Rocky Linux | Alma Linux |
|---------------|--------------|-------------|------------|
| 6             | 6            | N/A         | N/A        |
| 7 ✅          | 7 ✅         | N/A         | N/A        |
| 8 ✅          | 8.6 - 8.7 ✅ | 8           | 8          |
| 8 Stream      | 9 ✅         | 9           | 9          |
| 9 Stream      | N/A          | N/A         | N/A        |

## Preparation

For using this setup, you will need to do a couple of things first to ensure
that everything will run smoothly.

First, you need to install [packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli), as it is the main application needed to generate the builds.
Also install packer [QEMU plugin](https://developer.hashicorp.com/packer/integrations/hashicorp/qemu) and 
[Vagrant plugin](https://developer.hashicorp.com/packer/integrations/hashicorp/vagrant) needed for building vagrant boxes.

If you don't have `libvirt` installed, you can follow this guide on [fedora project](https://developer.fedoraproject.org/tools/virtualization/installing-libvirt-and-virt-install-on-fedora-linux.html) to install it.

After installing packer, add yourself to the `libvirt` group in your system,
you can follow [Computing for Geeks guide](https://computingforgeeks.com/use-virt-manager-as-non-root-user/) if you're not sure on how to do that.


## Building the boxes

To build the boxes is really simple, the only thing you need to have installed
on your system is the latest packer binary available.

Once you have that set, you can run the following command in your terminal:

```bash
./build ol9
```

This will generate a new centos8 vagrant boxes with UEFI enabled. Keep in mind
that the way our packer is setup right now, it *will try to push this boxes to
the Vagrant Cloud registry*, if you don't want that to happen, you can just
comment out the `vagrant-cloud` post-processor.

If you want to override any variables that are used in the build process, you
can do so by setting an environment variable before running the script, like:

```bash
./build ol9 -var="headless=false"
```

This will append the `-var="headless=false"` to the list of packer variables
that will be passed to the build. Any variable defined in both `centos.pkr.hcl`
and `ol.pkr.hcl` can be overrided like that.

## Release to Vagrant Cloud registry
As the repository is set now, it will in the default state try to push to the registry.
For doing that successfully, you need to set cloud token. Yon can do that by providing
it as variable to the script:
 ```bash
./build ol9 -var="cloud_token=<your-token>"
```
or directly in the `.hcl` file of the platform you want by adding it to the variable 
`cloud_token` as default variable.

In the `build` script do not forget to update the version related to the all boxes
you want to release, e.g. for `centos79`: `-var="version=7.9.2009` change to
`-var="version=7.9.2009.1"`

## Testing the box
The `./build <system_version>` should build `.box` file in the root of this repo. 
If you decide to test it locally, you need to add the box to the vagrant library,
prepare Vagrant file with UEFI support and run the box.

1. Add to vagrant library
In the root folder, run:
```
vagrant box add ./<name_of_the_box>.box --name=<your_selected_name>
```
2. Prepare Vagrant file
In some another folder (e.g. `/tmp/vagrant-test`) run `Vagrant init`
and change content of the generated `Vagrantfile` to (or create the
file direcly) to contain:
```
Vagrant.configure("2") do |config|
  config.vm.box = "<your_selected_name>"
  config.vm.provider :libvirt do |libvirt|
    libvirt.loader = "/usr/share/edk2/ovmf/OVMF_CODE.fd"
  end
end
```
