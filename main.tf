##############################################################################
# IBM Cloud Provider
##############################################################################
# See the README for details on ways to supply these values
provider "ibmcloud" {
  ibmid                    = "${var.ibmid}"
  ibmid_password           = "${var.ibmidpw}"
  softlayer_account_number = "${var.slaccountnum}"
}

##############################################################################
# Variables
##############################################################################
# Required for the IBM Cloud provider
variable ibmid {
  type = "string"
  description = "Your IBM-ID."
}

# Required for the IBM Cloud provider
variable ibmidpw {
  type = "string"
  description = "The password for your IBM-ID."
}

# Required to target the correct SL account
variable slaccountnum {
  type = "string"
  description = "Your Softlayer account number."
}

variable datacenter {
  description = "The datacenter to create resources in."
}

variable public_key {
  description = "Your public SSH key material."
}

variable key_label {
  description = "A label for the SSH key that gets created."
}

variable key_note {
  description = "A note for the SSH key that gets created."
}

variable hostname {
  description = "Your VM's hostname."
}

variable domain {
  type = "string"
  description = "Your VM's domain."
}

##############################################################################
# IBM SSH Key: For connecting to VMs
##############################################################################
resource "ibmcloud_infra_ssh_key" "ssh_key" {
  label = "${var.key_label}"
  notes = "${var.key_note}"
  # Public key, so this is completely safe
  public_key = "${var.public_key}"
}

##############################################################################
# Virtual Instance: Create VM
##############################################################################
resource "ibmcloud_infra_virtual_guest" "bmx_schematics_sample" {
    hostname = "${var.hostname}"
    domain = "${var.domain}"
    os_reference_code = "REDHAT_LATEST"
    datacenter = "${var.datacenter}"
    network_speed = 100
    hourly_billing = true
    private_network_only = false
    cores = 1
    memory = 1024
    disks = [25, 10]
    user_metadata = "{\"prod\":\"true\"}"
    dedicated_acct_host_only = true
    local_disk = false
    ssh_key_ids = ["${ibmcloud_infra_ssh_key.ssh_key.id}"]
    # public_vlan_id = <Public NetworkのVLAN ID>
    # private_vlan_id = <Private NetworkのVLAN ID>
}

##############################################################################
# Outputs
##############################################################################
output "ssh_key_id" {
  value = "${ibmcloud_infra_ssh_key.ssh_key.id}"
}

output "ipv4_address" {
  value = "${ibmcloud_infra_virtual_guest.bmx_schematics_sample.ipv4_address}"
}

output "ipv4_address_private" {
  value = "${ibmcloud_infra_virtual_guest.bmx_schematics_sample.ipv4_address_private}"
}
