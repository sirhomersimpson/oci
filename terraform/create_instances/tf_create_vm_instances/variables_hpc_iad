variable "tenancy_ocid" {
    default="ocid1.tenancy.oc1..aaaaaaaax3q5jcmovrv7qxbops55wzrjeutinobtayaykdasoygtnpko7buq"
}

variable "user_ocid" {
    default = "ocid1.user.oc1..aaaaaaaajkcbaezta7ighc25mbddntdwsagzbedzvri246ugswijolzvhhna"
}

variable "fingerprint" {
    default = "d5:a6:ec:b5:43:f6:ef:5b:25:af:c1:c4:e9:b3:e1:49"
}

variable "region" {
    default = "us-ashburn-1"
}

variable "compartment_ocid" {
  default="ocid1.compartment.oc1..aaaaaaaa65lmc4zqcmimxsppeezftp3ll5gjupjjklqlq6jktlsi6fknbpkq"
}

variable "ssh_public_key" {
    default="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCZlL2MR02JWdTPM06ZWebmJI4h30/D8syQDmoTRFiDpU1DzqJTUM/cWPz+DSZM/8CtJtrlVuUvM4iiDw2a9wwjjg4JESFTMe5s2x9Ece+KEfgDo/24NF94WGMzXurtCuMj8+z56c23KyDHyeArXu+K2WnxIpCtB9lZOk5jSImza2dXyO7iiHNAdbnbzTDp+Zbb5105jTMjicmITnAhwCpt9ywj7fDiuF2i0eTGMNeBRja9yXHESfh2+UEus9UsojQjxEclueLGzY24sYFgG5WiXGKmZJ7WmD0jAjQawlSwRdk+jo/IJJnvpMulL2sJaae9ZcXfFamFcsnTH0EmoWFfvSO3m3Wea1PMR+T/fripGduLAUO9ytP8uIPxdF0q/9ug9tizChIKFPMXkhTF2FyfciqfO0AWKWD9gYUywaIy/NSWujGIzMGpfVOWaAj9msvaLdAejMN9levZFhaQMZuw+KhCbpast1vpOTgN7UKpC+twWWCysR6koxhdC2rQdh8= rkisnah@rkisnah-mac"
}

# Defines the number of instances to deploy
variable "num_instances" {
  default = "1"
}

variable "instance_shape" {
  default = "VM.Standard.E3.Flex"
}

variable "instance_ocpus" {
  default = 1
}

variable "instance_shape_config_memory_in_gbs" {
  default = 1
}

variable "instance_image_ocid" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"  
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaaoqj42sokaoh42l76wsyhn3k2beuntrh5maj3gmgmzeyr55zzrwwa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaitzn6tdyjer7jl34h2ujz74jwy5nkbukbh55ekp6oyzwrtfa4zma"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa32voyikkkzfxyo4xbdmadc2dmvorfxxgdhpnk6dw64fa3l4jh7wa"
  }
}

variable "flex_instance_image_ocid" {
  type = map(string)
  default = {
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaa6hooptnlbfwr5lwemqjbu3uqidntrlhnt45yihfj222zahe7p3wq"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaa6tp7lhyrcokdtf7vrbmxyp2pctgg4uxvt4jz4vc47qoc2ec4anha"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaadvi77prh3vjijhwe5xbd6kjg3n5ndxjcpod6om6qaiqeu3csof7a"
    uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaaw5gvriwzjhzt2tnylrfnpanz5ndztyrv3zpwhlzxdbkqsjfkwxaq"
  }
}

variable "db_size" {
  default = "50" # size in GBs
}

variable "tag_namespace_description" {
  default = "Just a test"
}

variable "tag_namespace_name" {
  default = "testexamples-tag-namespace"
}
