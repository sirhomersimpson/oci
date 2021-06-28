resource "oci_core_vcn" "test_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "TestVcn"
  dns_label      = "dnslabel"
}

resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "TestRouteTable"
}

resource "oci_core_subnet" "test_subnet" {
  availability_domain = var.availability_domain
  cidr_block        = "10.0.2.0/24"
  compartment_id = var.compartment_ocid
  dhcp_options_id   = oci_core_vcn.test_vcn.default_dhcp_options_id
  display_name      = "TestSubnet"
  dns_label         = "dnslabel"
  route_table_id    = oci_core_route_table.test_route_table.id
  security_list_ids = [oci_core_vcn.test_vcn.default_security_list_id]
  vcn_id            = oci_core_vcn.test_vcn.id
}

resource "oci_core_network_security_group" "test_network_security_group1" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
}

resource "oci_core_instance_configuration" "test_instance_configuration" {
  compartment_id = var.compartment_ocid
  display_name   = "TestInstanceConfiguration"

  instance_details {
    instance_type = "compute"

    launch_details {
      availability_domain = var.availability_domain
      compartment_id = var.compartment_ocid

      create_vnic_details {
        assign_public_ip       = "true"
        display_name           = "backend-servers"
        hostname_label         = "hostnameLabel"
        nsg_ids                = [oci_core_network_security_group.test_network_security_group1.id]
        private_ip             = "privateIp"
        skip_source_dest_check = "false"
        subnet_id              = oci_core_subnet.test_subnet.id
      }

      display_name = "backend-servers"

      extended_metadata = {
        "extendedMetadata" = "extendedMetadata"
      }

      metadata = {
        ssh_authorized_keys = var.ssh_public_key
    }

      shape = "BM.HPC2.36"

      source_details {
        boot_volume_size_in_gbs = "50"
        image_id                = "ocid1.image.oc1..aaaaaaaazeefig7dqaoheiyoufmllolc3tuiv2c4xueecpr33dm3k4xjip3a"
        source_type             = "image"
      }
    }
  }

  source = "NONE"
}

resource "oci_core_cluster_network" "test_cluster_network" {
  compartment_id = var.compartment_ocid
  display_name   = "hpc-cluster-network"

  instance_pools {
    display_name              = "hpc-cluster-network"
    instance_configuration_id = oci_core_instance_configuration.test_instance_configuration.id
    size                      = "1"
  }

  placement_configuration {
    availability_domain = var.availability_domain
    primary_subnet_id   = oci_core_subnet.test_subnet.id
  }
}
