data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaa65lmc4zqcmimxsppeezftp3ll5gjupjjklqlq6jktlsi6fknbpkq"
}

data "oci_core_instances" "test_instances" {
    #Required
    compartment_id = "ocid1.compartment.oc1..aaaaaaaa65lmc4zqcmimxsppeezftp3ll5gjupjjklqlq6jktlsi6fknbpkq"
    state = "RUNNING"
}
