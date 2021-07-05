// Copyright (c) 2017, 2021, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

variable "tenancy_ocid" {
    default="ocid1.tenancy.region1..aaaaaaaa5tiiq4wpo5ywqgwidmh4oz4ipiosyohh3jgvjjswbj4p7cjkkwla"
}

variable "user_ocid" {
    default = "ocid1.user.region1..aaaaaaaaeabbzuneg4xdtwxfc46ciisfubxx2llha6td3g6y6pe64krzbp2a"
}

variable "fingerprint" {
    default = "41:a9:0a:55:2c:28:13:69:4f:e8:4b:c7:b5:5e:ec:14"
}

variable "region" {
    default = "r1"
}

variable "compartment_ocid" {
  default="ocid1.compartment.region1..aaaaaaaap4af444xs5zfenrudblsd7li3bi56ovmcb3akuqlr64cz52gf3jq"
}

variable "private_key_path" {
    default = "/home/rkisnah/.oci/compute_dev_us_grp-06-10-23-46.pem"
}


provider "oci" {
  tenancy_ocid = "ocid1.tenancy.region1..aaaaaaaa5tiiq4wpo5ywqgwidmh4oz4ipiosyohh3jgvjjswbj4p7cjkkwla"
  user_ocid = "ocid1.user.region1..aaaaaaaaeabbzuneg4xdtwxfc46ciisfubxx2llha6td3g6y6pe64krzbp2a"
  private_key_path = "/home/rkisnah/.oci/compute_dev_us_grp-06-10-23-46.pem"
  fingerprint = "41:a9:0a:55:2c:28:13:69:4f:e8:4b:c7:b5:5e:ec:14"
  region = "r1"
}


data "oci_identity_availability_domains" "test_availability_domains" {
  compartment_id = var.tenancy_ocid
}

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
  availability_domain = lower(
    data.oci_identity_availability_domains.test_availability_domains.availability_domains[0].name,
  )
  cidr_block        = "10.0.2.0/24"
  compartment_id    = var.compartment_ocid
  dhcp_options_id   = oci_core_vcn.test_vcn.default_dhcp_options_id
  display_name      = "TestSubnet"
  dns_label         = "dnslabel"
  route_table_id    = oci_core_route_table.test_route_table.id
  security_list_ids = [oci_core_vcn.test_vcn.default_security_list_id]
  vcn_id            = oci_core_vcn.test_vcn.id
}

resource "oci_core_internet_gateway" "ig1" {
  vcn_id         = oci_core_vcn.test_vcn.id
  compartment_id = var.compartment_ocid
  display_name   = "internet-gateway"
}

variable "InstanceImageOCID" {
  type = map(string)

  default = {
    // See https://docs.us-phoenix-1.oraclecloud.com/images/
    // Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaadjnj3da72bztpxinmqpih62c2woscbp6l3wjn36by2cvmdhjub6a"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaawufnve5jxze4xf7orejupw5iq3pms6cuadzjc7klojix6vmk42va"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaagbrvhganmn7awcr7plaaf5vhabmzhx763z5afiitswjwmzh7upna"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaajwtut4l7fo3cvyraate6erdkyf2wdk5vpk6fp6ycng3dv2y3ymvq"
  }
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
      availability_domain = data.oci_identity_availability_domains.test_availability_domains.availability_domains[0].name
      compartment_id      = var.compartment_ocid

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

      #ipxe_script = "ipxeScript"

      metadata = {
        "metadata" = "metadata"
      }

      shape = "BM.HPC2.36"

      source_details {
        boot_volume_size_in_gbs = "55"
        #image_id                = var.InstanceImageOCID[var.region]
        image_id = "ocid1.image.region1.sea.aaaaaaaagqyh62ysuqvzv4bn3bjmfvxpuj6r4cu2i5iqqgia536pwkn37j2q"
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
    availability_domain = data.oci_identity_availability_domains.test_availability_domains.availability_domains[0].name
    primary_subnet_id   = oci_core_subnet.test_subnet.id
  }
}

