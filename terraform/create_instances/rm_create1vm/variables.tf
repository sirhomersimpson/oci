
    // Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.
    // Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
    
      variable "compartment_ocid" {}
      variable "tenancy_ocid" {}
      variable "region" {}
      
      variable "instance_display_name" {}
      variable "preserve_boot_volume" {}
      variable "boot_volume_size_in_gbs" {}
      variable "shape" {}
      variable "assign_public_ip" {}
      variable "vnic_name" {}
      variable "hostname_label" {}
      variable "private_ip" {}
      variable "subnet_ocid" {}
      variable "ssh_public_key" {}
      variable "user_data" {}
      variable "instance_timeout" {}
      variable "block_storage_size_in_gbs" {}
      variable "attachment_type" {}
      variable "resource_platform" {}
      
      provider "oci" {
        tenancy_ocid     = var.tenancy_ocid
        region           = var.region
        version          = 3.66
      }
    
