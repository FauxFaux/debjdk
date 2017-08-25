```
faux@astoria:~/code/fbuilder% P=$(<./data/all-build-deps-amd64.txt fgrep default-jdk | cut -d' ' -f 1 | sed 's/$/.pkg/')
make -j8 ${=P}
bzcat reproducible.json.bz2 | jq -r '.[]|select(.architecture=="amd64" and .status != "reproducible" and .status != "unreproducible" and .suite=="unstable")|.package'  > .jenkins
diff -u <(ls -1 *.fail | sed 's/.pkg.fail$//') .jenkins | egrep '^-' > .broken
```


ec2: i3.8xlarge

```
#sudo mdadm --create --verbose /dev/md0 --level=stripe --raid-devices=2 /dev/xvdb /dev/xvdc && \
sudo mdadm --create --verbose /dev/md0 --level=stripe --raid-devices=4 /dev/nvme?n1 && \
sudo mkfs.xfs -K /dev/md0 && \
sudo mkdir /mnt/data && \ 
sudo mount -o nobarrier /dev/md0 /mnt/data
```

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
sudo apt update && \
sudo apt install -y docker-ce git wget equivs tmux && \
sudo systemctl stop docker
```

```
sudo mv /var/lib/docker /mnt/data/ &&
sudo ln -s /mnt/data/docker /var/lib
```

```
git clone https://github.com/FauxFaux/debjdk9 && \
cd debjdk9 && \
wget https://b.goeswhere.com/default-jdk-dependencies-2017-08-22.lst
```

... copy artifacts

```
tmux
:>base/apt.conf && \
make -j $(nproc) $(cat default-jdk-dependencies-*)
```
