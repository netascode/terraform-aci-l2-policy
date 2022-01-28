terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "L2POL1"
}

data "aci_rest_managed" "l2IfPol" {
  dn = "uni/infra/l2IfP-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "l2IfPol" {
  component = "l2IfPol"

  equal "name" {
    description = "name"
    got         = data.aci_rest_managed.l2IfPol.content.name
    want        = module.main.name
  }
}
