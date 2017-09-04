# クラウドプロバイダーの指定
provider "ibmcloud" {
  ibmid                    = "${var.ibmid}"
  ibmid_password           = "${var.ibmidpw}"
  softlayer_account_number = "${var.softlayer_account_num}"
}

#子ユーザーの追加
resource "ibm_compute_user" "add_user" {
  address1     = "19-21"
  city         = "Nihonbashi Hakozaki-cho"
  company_name = "IBM PoC - IBM Japan"
  country      = "JP"
  email        = "${var.email}"
  first_name   = "${var.first_name}"
  last_name    = "${var.last_name}"
  permissions  = [
    "ACCESS_ALL_GUEST",
    "ACCESS_ALL_HARDWARE",
    "SERVER_ADD",
    "SERVER_CANCEL",
    "RESET_PORTAL_PASSWORD"
  ]
  state        = "OT"
  timezone     = "JST"
}
