module "aci_l2_policy" {
  source = "netascode/l2-policy/aci"

  name       = "L2POL1"
  vlan_scope = "portlocal"
  qinq       = "edgePort"
}
