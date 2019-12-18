# -*- mode: ruby -*-
# vi: set ft=ruby :

MASTER_IMAGE_NAME = "bionic_k8s_master"
WORKER_IMAGE_NAME = "bionic_k8s_worker"
NUMBER_OF_WORKERS = 6

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end
      
    config.vm.define "k8s-master" do |master|
        master.vm.box = MASTER_IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"
        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "master-playbook.yml"
            ansible.extra_vars = {
                node_ip: "192.168.50.10"
            }
        end
    end

    (1..NUMBER_OF_WORKERS).each do |i|
        config.vm.define "k8s-worker-#{i}" do |worker|
            worker.vm.box = WORKER_IMAGE_NAME
            worker.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            worker.vm.hostname = "k8s-worker-#{i}"
            worker.vm.provision "ansible" do |ansible|
                ansible.playbook = "worker-playbook.yml"
                ansible.extra_vars = {
                    node_ip: "192.168.50.#{i + 10}"
                }
            end
        end
    end
end