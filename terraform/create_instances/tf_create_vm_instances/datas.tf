data "oci_identity_availability_domain" "ad" {
    compartment_id = var.tenancy_ocid
    ad_number      = 1
}

data "oci_core_instance" "test_instance" {
    instance_id = oci_core_instance.test_instance[0].id 
}
