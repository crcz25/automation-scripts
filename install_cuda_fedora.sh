# To install nvidia drivers, cuda and nvidia-container-toolkit on Fedora 39
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora39/x86_64/cuda-fedora39.repo
sudo dnf module install nvidia-driver:latest-dkms

# To install cuda toolkit
sudo dnf install cuda-toolkit

# To install nvidia-container-toolkit
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo

sudo yum install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker

sudo systemctl restart docker

docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
