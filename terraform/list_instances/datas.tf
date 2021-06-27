data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaqcpcykitsyx3n6yzdhinej5evcmhzhjbvidkcp6xmc7nsyot5rpq"
}

data "oci_core_instances" "test_instances" {
    #Required
    compartment_id = "ocid1.compartment.oc1..aaaaaaaaqcpcykitsyx3n6yzdhinej5evcmhzhjbvidkcp6xmc7nsyot5rpq"
}