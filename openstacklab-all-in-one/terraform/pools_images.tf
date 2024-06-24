resource "libvirt_cloudinit_disk" "deployment" {
  name           = "deployment.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  
}


resource "libvirt_cloudinit_disk" "compute-cloud_init" {
  name           = "compute-${count.index + 1}.iso"
  count          = var.compute_count
  user_data      = data.template_file.compute_user_data[count.index].rendered
  network_config = data.template_file.network_config.rendered
  
}

resource "libvirt_cloudinit_disk" "controller-cloud_init" {
  name           = "controller-${count.index + 1}.iso"
  count          = var.controller_count
  user_data      = data.template_file.controller_user_data[count.index].rendered
  network_config = data.template_file.network_config.rendered
  
}

resource "libvirt_volume" "baseimage-qcow2" {
  name = "baseimage-qcow2"
  source = var.baseimage_image_url
  format = "qcow2"
}