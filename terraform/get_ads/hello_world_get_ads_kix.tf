data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaqcpcykitsyx3n6yzdhinej5evcmhzhjbvidkcp6xmc7nsyot5rpq"
}
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaabgbm264ykbrfrs2manqytigyh6wiwcg3s7wsgzaw7qmscquzr5qq"
  user_ocid = "ocid1.user.oc1..aaaaaaaapwgd6gl3yjjjmidy32wsc4iapgg62q7c5fsg2ezd2vpt3aswwlga"
  private_key_path = "/home/rkisnah/.oci/oci_api_key.pem"
  fingerprint = "8f:0d:95:f2:f6:70:72:44:fa:29:b7:54:46:d9:d2:df"
  region = "ap-osaka-1"
}
