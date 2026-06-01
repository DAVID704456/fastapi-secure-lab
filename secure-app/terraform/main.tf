terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  # Переменные будут взяты из окружения (YC_TOKEN, YC_CLOUD_ID, YC_FOLDER_ID)
}

resource "yandex_vpc_network" "fastapi_network" {
  name = "fastapi-network"
}

resource "yandex_vpc_subnet" "fastapi_subnet" {
  name           = "fastapi-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.fastapi_network.id
  v4_cidr_blocks = ["10.2.0.0/16"]
}

resource "yandex_compute_instance" "fastapi_vm" {
  name = "fastapi-terraform-vm"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8m5jck9arbd28e3mo8"  # Ubuntu 22.04 LTS
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.fastapi_subnet.id
    nat       = true
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      runcmd:
        - apt-get update
        - apt-get install -y docker.io git curl
        - systemctl start docker
        - systemctl enable docker
        - git clone https://github.com/DAVID704456/fastapi-secure-lab.git /opt/fastapi
        - cd /opt/fastapi/secure-app
        - docker build -t fastapi-secure .
        - docker run -d -p 80:8000 fastapi-secure
    EOF
  }
}

output "public_ip" {
  value = yandex_compute_instance.fastapi_vm.network_interface[0].nat_ip_address
}