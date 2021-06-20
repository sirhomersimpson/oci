/*
# Gets the boot volume attachments for each instance
data "oci_core_boot_volume_attachments" "test_boot_volume_attachments" {
  depends_on          = [oci_core_instance.test_instance]
  count               = var.num_instances
  availability_domain = oci_core_instance.test_instance[count.index].availability_domain
  compartment_id      = var.compartment_ocid

  instance_id = oci_core_instance.test_instance[count.index].id
}
*/

data "oci_core_instance_devices" "test_instance_devices" {
  count       = var.num_instances
  instance_id = oci_core_instance.test_instance[count.index].id
}


data "oci_identity_availability_domain" "ad" {
 compartment_id = var.tenancy_ocid
 ad_number      = 1
}

