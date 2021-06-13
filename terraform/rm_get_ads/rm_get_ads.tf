data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.compartment.region1..aaaaaaaa5z2cggq45vmvtph3hwem4p4sp4ui63cnrxrm7u5vrxpv72nygmga"
}
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.region1..aaaaaaaa5tiiq4wpo5ywqgwidmh4oz4ipiosyohh3jgvjjswbj4p7cjkkwla"
  region = "r1"
}
