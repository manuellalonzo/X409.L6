packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "debian12" {
  ami_name      = "my_first_ami_${local.timestamp}"
  instance_type = "t2.micro"
  region        = "${var.my_region}"
  source_ami_filter {
    filters = {
      name                = "${var.source_ami_name}"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["136693071363"]
  }
  ssh_username = "admin"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.debian12",
  ]

  provisioner "file" {
    source      = "app_files"
    destination = "/home/admin/"
  }

  provisioner "shell" {
    inline = [
      "ls /home/admin",
      "echo 'Install packages'",
      "echo 'Install packages'",
      "sudo apt install python3 -y",
      "sudo apt update -y",
      "sudo apt install gcc -y",
      "sudo apt install git -y",
      "sudo apt install bash -y",
      "gcc -o /home/admin/app_files/dummyserv /home/admin/app_files/dummy_serv.c",
      "echo 'Setup the my app service with systemd'",
      "echo 'Setup the my app service with systemd'",
      "sudo cp /home/admin/app_files/dummy_serv.service /etc/systemd/system/dummy_serv.service",		
      "sudo systemctl enable dummy_serv",

    ]
  }



}

variable "my_region" {
  type    = string
  default = "us-east-2"
}

variable "source_ami_name" {
  type    = string
  default = "debian-12-amd64-*"
}
