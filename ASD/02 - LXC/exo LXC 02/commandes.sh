#creation des 3 noeuds du cluster
multipass launch -n exo1 -c 1 -m 2G -d 50G --network name='cluster2' --cloud-init=multipass-01.yaml
multipass launch -n exo2 -c 1 -m 2G -d 50G --network name='cluster2' --cloud-init=multipass-02.yaml
multipass launch -n exo3 -c 1 -m 2G -d 50G --network name='cluster2' --cloud-init=multipass-03.yaml

######################
###### Sur exo1 ######
###################### 
#configuration initale de LXD
sudo lxd init

#generation des token
lxc cluster add 10.0.2.110
lxc cluster add 10.0.2.110

##############################
###### Sur exo2 et exo3 ######
##############################

cat lxd-init.yaml | sudo lxd init --preseed

######################
###### Sur exo1 ######
###################### 
lxc storage create --target 10.0.2.100 data zfs source=/dev/sdb
lxc storage create --target 10.0.2.110 data zfs source=/dev/sdb
lxc storage create --target 10.0.2.120 data zfs source=/dev/sdb
lxc storage create data zfs

#copie locale de l'image
lxc image copy images:ubuntu/jammy/cloud local: --alias ubuc --auto-update

#création des profils
lxc profile create mariadb
lxc profile create eth-db1
lxc profile create eth-db2
lxc profile create eth-db3

#creation du profil réseau pour les container
lxc profile edit mariadb
lxc profile edit eth-db1
lxc profile edit eth-db2
lxc profile edit eth-db3


#creations des réseaux
lxc network create mariadb --target 10.0.2.100
lxc network create mariadb --target 10.0.2.110
lxc network create mariadb --target 10.0.2.120
lxc create network mariadb

#changment de l'adresse du réseau en 10.0.3.1/24
lxc network edit mariadb

#Lancement des containers
lxc launch ubuc db1 --target 10.0.2.100 -p mariadb -p eth-db1
lxc launch ubuc db2 --target 10.0.2.110 -p mariadb -p eth-db2
lxc launch ubuc db3 --target 10.0.2.120 -p mariadb -p eth-db3





