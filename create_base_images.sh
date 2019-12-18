#!/bin/bash

# assumed that the following are installed
# - vagrant
# - ansible
# the respective commands should be available in the path

if [ -z "$MY_CLUSTER_DIRECTORY" ]
then
      echo "usage: MY_CLUSTER_DIRECTORY=<path_to_your_cluster> sh create_base_images.sh"
      exit
else
      echo "Using $MY_CLUSTER_DIRECTORY as the cluster directory"
fi
# MY_CLUSTER_DIRECTORY=~/workspace/vagrant/kubernetes_cluster

vagrant box remove bionic_k8s_master
vagrant box remove bionic_k8s_worker

cd $MY_CLUSTER_DIRECTORY/master_base/
vagrant up
vagrant package --base k8s-master-base
vagrant box add bionic_k8s_master package.box
vagrant destroy -f

cd $MY_CLUSTER_DIRECTORY/worker_base/
vagrant up
vagrant package --base k8s-worker-base
vagrant box add bionic_k8s_worker package.box
vagrant destroy -f



