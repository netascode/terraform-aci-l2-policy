terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name       = "L2POL1"
  vlan_scope = "portlocal"
  qinq       = "edgePort"
}

data "aci_rest" "l2IfPol" {
  dn = "uni/infra/l2IfP-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "l2IfPol" {
  component = "l2IfPol"

  equal "name" {
    description = "name"
    got         = data.aci_rest.l2IfPol.content.name
    want        = module.main.name
  }

  equal "vlanScope" {
    description = "vlanScope"
    got         = data.aci_rest.l2IfPol.content.vlanScope
    want        = "portlocal"
  }

  equal "qinq" {
    description = "qinq"
    got         = data.aci_rest.l2IfPol.content.qinq
    want        = "edgePort"
  }
}
