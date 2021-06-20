// Copyright (c) 2017, 2021, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

resource "oci_core_instance" "test_instance" {
  count               = var.num_instances
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "TestInstance${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.test_subnet.id
    display_name              = "Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "exampleinstance${count.index}"
  }

  source_details {
    source_type = "image"
    source_id = var.flex_instance_image_ocid[var.region]
    # Apply this to set the size of the boot volume that is created for this instance.
    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    #boot_volume_size_in_gbs = "60"
  }

  # Apply the following flag only if you wish to preserve the attached boot volume upon destroying this instance
  # Setting this and destroying the instance will result in a boot volume that should be managed outside of this config.
  # When changing this value, make sure to run 'terraform apply' so that it takes effect before the resource is destroyed.
  #preserve_boot_volume = true

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  freeform_tags = {
    "freeformkey${count.index}" = "freeformvalue${count.index}"
  }

  preemptible_instance_config {
    preemption_action {
      type = "TERMINATE"
      preserve_boot_volume = false
    }
  }

  timeouts {
    create = "60m"
  }
}

# Define the volumes that are attached to the compute instances.

resource "oci_core_volume" "test_block_volume" {
  count               = var.num_instances * var.num_iscsi_volumes_per_instance
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "TestBlock${count.index}"
  size_in_gbs         = var.db_size
}

resource "oci_core_volume_attachment" "test_block_attach" {
  count           = var.num_instances * var.num_iscsi_volumes_per_instance
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.test_instance[floor(count.index / var.num_iscsi_volumes_per_instance)].id
  volume_id       = oci_core_volume.test_block_volume[count.index].id
  device          = count.index == 0 ? "/dev/oracleoci/oraclevdb" : ""

  # Set this to enable CHAP authentication for an ISCSI volume attachment. The oci_core_volume_attachment resource will
  # contain the CHAP authentication details via the "chap_secret" and "chap_username" attributes.
  use_chap = true
  # Set this to attach the volume as read-only.
  #is_read_only = true
}

resource "oci_core_volume" "test_block_volume_paravirtualized" {
  count               = var.num_instances * var.num_paravirtualized_volumes_per_instance
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "TestBlockParavirtualized${count.index}"
  size_in_gbs         = var.db_size
}

resource "oci_core_volume_attachment" "test_block_volume_attach_paravirtualized" {
  count           = var.num_instances * var.num_paravirtualized_volumes_per_instance
  attachment_type = "paravirtualized"
  instance_id     = oci_core_instance.test_instance[floor(count.index / var.num_paravirtualized_volumes_per_instance)].id
  volume_id       = oci_core_volume.test_block_volume_paravirtualized[count.index].id
  # Set this to attach the volume as read-only.
  #is_read_only = true
}


resource "oci_core_vcn" "test_vcn" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "TestVcn"
  dns_label      = "testvcn"
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "TestInternetGateway"
  vcn_id         = oci_core_vcn.test_vcn.id
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.test_vcn.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.test_internet_gateway.id
  }
}

resource "oci_core_subnet" "test_subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.1.20.0/24"
  display_name        = "TestSubnet"
  dns_label           = "testsubnet"
  security_list_ids   = [oci_core_vcn.test_vcn.default_security_list_id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.test_vcn.id
  route_table_id      = oci_core_vcn.test_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.test_vcn.default_dhcp_options_id
}

