# Configure the Oracle Cloud Infrastructure provider with an API Key
provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaahndpl6fv47be4cvb2mwynk3yqiplx3f353johovykdtwr6mp6qwq"
  user_ocid = "ocid1.user.oc1..aaaaaaaadvuuitwxwday2wacx3hvd5eymqf5han2jvi6rwkcgoovrtuvdx6q"
  fingerprint = "8f:0d:95:f2:f6:70:72:44:fa:29:b7:54:46:d9:d2:df"
  private_key_path = "/Users/rkisnah/.oci/oci_api_key.pem"
  region = "us-phoenix-1"
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaadmtdep3rn7qwjgwjektj4cz7t4x5d5ejhvru6xvsqiqio5vfn6ha"
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}
