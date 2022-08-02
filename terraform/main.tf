locals {
  uri = "qemu:///session?socket=/libvirt-sock"
}



provider "libvirt" {
  ## Configuration options
  #uri = "qemu:///system"
  #alias = "server2"
  uri   = local.uri
}