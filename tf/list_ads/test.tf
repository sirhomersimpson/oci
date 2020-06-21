provider "oci" {
  tenancy_ocid ="ocid1.tenancy.oc1..aaaaaaaahndpl6fv47be4cvb2mwynk3yqiplx3f353johovykdtwr6mp6qwq"
  user_ocid = "ocid1.user.oc1..aaaaaaaadvuuitwxwday2wacx3hvd5eymqf5han2jvi6rwkcgoovrtuvdx6q"
  fingerprint = "8f:0d:95:f2:f6:70:72:44:fa:29:b7:54:46:d9:d2:df"
  region = "us-phoenix-1"
  private_key_path = "/Users/rkisnah/oci_api_key_public.pem"
}


# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads_1" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaahndpl6fv47be4cvb2mwynk3yqiplx3f353johovykdtwr6mp6qwq"
}

# Output the result
output "show-ads" {
  value = "${data.oci_identity_availability_domains.ads_1.compartment_id}"
}