# Output the private and public IPs of the instance

output "instance_private_ips" {
    value = [oci_core_instance.test_instance.*.private_ip]
}

output "instance_public_ips" {
    value = [oci_core_instance.test_instance.*.public_ip]
}

# Output the boot volume IDs of the instance
output "boot_volume_ids" {
    value = [oci_core_instance.test_instance.*.boot_volume_id]
}

output "instance_ids" {
    value = [oci_core_instance.test_instance[0].id]
}

