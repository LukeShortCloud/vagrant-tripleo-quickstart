for node in control01 compute01; do
  virsh detach-interface vagrant-tripleo-quickstart_${node} network --persistent --mac `virsh dumpxml vagrant-tripleo-quickstart_${node} | grep -B4 vagrant-libvirt | grep mac | cut -d "'" -f2`
done
