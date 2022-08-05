# Vagrant UEFI Boxes

This project is intended to be used to generate vagrant boxes that has UEFI
support enabled by default.

Supported systems so far:

| CentOS Linux  | Oracle Linux | Rocky Linux | Alma Linux |
|---------------|--------------|-------------|------------|
| 6             | 6            | 6           | 6          |
| 7 ✅          | 7            | 7           | 7          |
| 8 ✅          | 8            | 8           | 8          |


## Building the boxes

To build the boxes is really simple, the only thing you need to have installed
on your system is the latest packer binary available.

Once you have that set, you can run the following command in your terminal:

```bash
./build centos8
```

This will generate a new centos8 vagrant boxes with UEFI enabled. Keep in mind
that the way our packer is setup right now, it will try to push this boxes to
the Vagrant Cloud registry, if you don't want that to happen, you can just
comment out the `vagrant-cloud` post-processor.
