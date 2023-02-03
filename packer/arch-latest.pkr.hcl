variable "region" {
  type    = string
  default = "eu-central-1"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "sandbox-ami" {
  ami_name      = "rch-sandbox-image-${local.timestamp}"
  instance_type = "t2.micro"
  region        = var.region

  source_ami_filter {
    filters = {
      name                = "arch-linux-std-hvm-*.x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }

    most_recent = true
    owners      = ["647457786197"]
  }

  ssh_username = "arch"
}

build {
  sources = ["source.amazon-ebs.sandbox-ami"]

  provisioner "shell" {
    script = "./scripts/setup.sh"
  }
}
