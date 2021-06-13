# Purpose
I have a VM. I want to export it in a qcow format and import it into OCI as a Custom Image. <br/>

## Step 1. Create a qcow within the VM
(ref: https://askubuntu.com/questions/853160/create-image-with-dd-command-cow2) <br/>

```qemu-img convert -O qcow2 /dev/sda /home/ubuntu/image.qcow2```

## Step 2. Import it as QCOW in OCI <br/>
```https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/imageimportexport.htm```
