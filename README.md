Creating a kubernetes cluster in a vagrant virtual environment

The following things are to be done

- list the steps to create the master base box
- list the steps to create the worker base box
- list the steps to use the master and worker in a Vagrantfile to bring up the servers

The following steps have been automated and can be done by running the create_base_images.sh script; check the K8S_DIRECTORY value in the script and set it to the right location
<pre>MY_CLUSTER_DIRECTORY=[path_to_your_cluster] sh create_base_images.sh</pre>

Creating the base boxes
- create a Vagrantfile with the base box
- use ansible provisioning for the necessary software
- start the vm and let ansible do the provisioning
- once provisioned, create the new base box
<pre>vagrant package --base k8s-master-base</pre>
- add the new box to vagrant
<pre>vagrant box add bionic_k8s_master package.box</pre>
- delete the vm
<pre>vagrant destroy k8s-master-base</pre>
- use the new box
<pre>(if you run into issues try "vagrant init bionic_k8s_master" and refer the created Vagrantfile)</pre>

Follow the same steps for creating the worker base box

Once the cluster is up, copy the kube config to your local context so that you can administer the cluster from your local box
<pre>scp -r vagrant@192.168.50.10:/home/vagrant/.kube/config ~/.kube/config</pre>