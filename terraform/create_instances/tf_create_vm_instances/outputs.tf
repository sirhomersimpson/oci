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

# Output all the devices for all instances
output "instance_devices" {
  value = [data.oci_core_instance_devices.test_instance_devices.*.devices]
}

# Output the chap secret information for ISCSI volume attachments. This can be used to output
# CHAP information for ISCSI volume attachments that have "use_chap" set to true.
#output "IscsiVolumeAttachmentChapUsernames" {
#  value = [oci_core_volume_attachment.test_block_attach.*.chap_username]
#}
#
#output "IscsiVolumeAttachmentChapSecrets" {
#  value = [oci_core_volume_attachment.test_block_attach.*.chap_secret]
#}

/*
output "attachment_instance_id" {
  value = data.oci_core_boot_volume_attachments.test_boot_volume_attachments.*.instance_id
}
*/


