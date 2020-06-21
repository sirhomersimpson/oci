provider "oci" {
  tenancy_ocid ="ocid1.tenancy.oc1..TBD"
  user_ocid = "ocid1.user.oc1..TBD"
  fingerprint = "TBD"
  region = "us-phoenix-1"
  private_key_path = "/Users/TBD/oci_api_key_public.pem"
}


# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads_1" {
  compartment_id = "ocid1.tenancy.oc1..TBD"
}

# Output the result
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads_1.compartment_id}"
}
