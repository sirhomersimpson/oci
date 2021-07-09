# Use session to create profile
ref: https://learn.hashicorp.com/tutorials/terraform/oci-build?in=terraform/oci-get-started <br/>

```oci session authenticate```

# oci cli / jq
```
#list all instances

oci compute instance list --compartment-id ocid1.compartment.oc1..aaaaaaaadmtdep3rn7qwjgwjektj4cz7t4x5d5ejhvru6xvsqiqio5vfn6ha

#detach a vnic

oci compute instance detach-vnic --compartment-id ocid1.compartment.oc1..aaaaaaaadmtdep3rn7qwjgwjektj4cz7t4x5d5ejhvru6xvsqiqio5vfn6ha --vnic-id ocid1.vnic.oc1.phx.abyhqljt34pd5sre3za34b2wtcyxii5zm5rkw62aneil3yg75jrdl2jes4iq --wait-for-state DETACHED --force

#List all vnics

oci compute instance list-vnics --compartment-id ocid1.compartment.oc1..aaaaaaaadmtdep3rn7qwjgwjektj4cz7t4x5d5ejhvru6xvsqiqio5vfn6ha --instance-id ocid1.instance.oc1.phx.anyhqljt6if7otacsotd3ub6sadva7lywaov7dflf2ly5ztnf65knzgcwklq

#Get vnic

oci compute instance list-vnics --compartment-id ocid1.compartment.oc1..aaaaaaaadmtdep3rn7qwjgwjektj4cz7t4x5d5ejhvru6xvsqiqio5vfn6ha --instance-id ocid1.instance.oc1.phx.anyhqljt6if7otacsotd3ub6sadva7lywaov7dflf2ly5ztnf65knzgcwklq |jq .data[0].id

#Attach vnic

oci compute instance attach-vnic --instance-id ocid1.instance.oc1.phx.anyhqljt6if7otacsotd3ub6sadva7lywaov7dflf2ly5ztnf65knzgcwklq --subnet-id ocid1.subnet.oc1.phx.aaaaaaaakofdgupw6ixycifnp3pgkxd55wvkzbtwpamdvhoy3engqzekyfha

#List vnics

oci compute instance list-vnics --compartment-id ocid1.compartment.oc1..aaaaaaaadmtdep3rn7qwjgwjektj4cz7t4x5d5ejhvru6xvsqiqio5vfn6ha --instance-id ocid1.instance.oc1.phx.anyhqljt6if7otacsotd3ub6sadva7lywaov7dflf2ly5ztnf65knzgcwklq |jq '.data[] | select(."is-primary" == false)' | jq -r '.id'

#Get vnic

vnic=`oci compute instance list-vnics --compartment-id ocid1.compartment.oc1..aaaaaaaadmtdep3rn7qwjgwjektj4cz7t4x5d5ejhvru6xvsqiqio5vfn6ha --instance-id ocid1.instance.oc1.phx.anyhqljt6if7otacsotd3ub6sadva7lywaov7dflf2ly5ztnf65knzgcwklq |jq '.data[] | select(."is-primary" == false)' | jq -r '.id'
```
# get display name
 oci compute instance list -c $C | jq '.data[0]."display-name"'

# Get cluster information
```
oci compute-management cluster-network list | jq .data[].id
oci compute-management cluster-network list | jq .data[].\"display-name\"
```

# Object store

```
oci os bucket list
{
}
```
