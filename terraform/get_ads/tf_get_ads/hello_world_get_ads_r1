data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.compartment.region1..aaaaaaaa5z2cggq45vmvtph3hwem4p4sp4ui63cnrxrm7u5vrxpv72nygmga"
}
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.region1..aaaaaaaa5tiiq4wpo5ywqgwidmh4oz4ipiosyohh3jgvjjswbj4p7cjkkwla"
  user_ocid = "ocid1.user.region1..aaaaaaaaeabbzuneg4xdtwxfc46ciisfubxx2llha6td3g6y6pe64krzbp2a"
  private_key_path = "/home/rkisnah/.oci/compute_dev_us_grp-06-10-23-46.pem"
  fingerprint = "41:a9:0a:55:2c:28:13:69:4f:e8:4b:c7:b5:5e:ec:14"
  region = "r1"
}
