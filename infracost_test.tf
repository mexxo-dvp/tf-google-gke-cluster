provider "google" {
  region  = "europe-west1"
  project = "civil-pattern-466501-m8"
}

resource "google_compute_instance" "my_instance" {
  zone         = "europe-west1-b"
  name         = "infracost-demo"

  machine_type = "n1-standard-16" # потім поміняєш на n1-standard-32 для дифа

  network_interface {
    network = "default"
    access_config {}
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  scheduling {
    preemptible = true
  }

  # необов'язково; залиш, якщо хочеш ще один диф за акселератором
  guest_accelerator {
    type  = "nvidia-tesla-t4"     # потім змінити на nvidia-tesla-p4 для дифа
    count = 4
  }

  labels = {
    environment = "production"
    service     = "web-app"
  }
}
