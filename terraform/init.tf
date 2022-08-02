terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

variable socketpath {
  type        = string
  description = "path to the socket"
}

variable socket {
  type        = string
  default     = "libvirt-sock"
  description = "name of the socket"
}

variable storage_pool {
  type        = string
  description = "Location of the storage pool to create"
}

variable srcdir {
  type        = string
  description = "Location of the disk files"
}
