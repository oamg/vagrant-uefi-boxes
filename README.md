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
that the way our packer is setup right now, it will try to push this boxes to
the Vagrant Cloud registry, if you don't want that to happen, you can just
comment out the `vagrant-cloud` post-processor.

If you want to override any variables that are used in the build process, you
can do so by setting an environment variable before running the script, like:

```bash
./build ol9 -var="headless=false"
```

This will append the `-var="headless=false"` to the list of packer variables
that will be passed to the build. Any variable defined in both `centos.pkr.hcl`
and `ol.pkr.hcl` can be overrided like that.
