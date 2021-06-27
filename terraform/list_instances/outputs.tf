output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

output "list-availability-domains-in-your-compartment" {
  value = data.oci_core_instances.test_instances.instances
}
