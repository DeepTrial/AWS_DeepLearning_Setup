#!/bin/bash

# stop on error
set -e
############################################
# install into /mnt/bin
sudo mkdir -p /mnt/bin
sudo chown ubuntu:ubuntu /mnt/bin

# install the required packages
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install linux-headers-$(uname -r) linux-image-extra-`uname -r`
sudo apt-get install git

# install cuda 8.0
CUDA_FILE=cuda-repo-ubuntu1404_8.0.61-1_amd64.deb
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/${CUDA_FILE}
sudo dpkg -i ${CUDA_FILE}
rm ${CUDA_FILE}
sudo apt-get update
sudo apt-get install -y cuda-8-0

# get cudnn 6.0
CUDNN_FILE=cudnn-8.0-linux-x64-v6.0.tgz
wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/${CUDNN_FILE}
tar xvzf ${CUDNN_FILE}
rm ${CUDNN_FILE}
sudo cp cuda/include/cudnn.h /usr/local/cuda/include # move library files to /usr/local/cuda
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
rm -rf cuda

# set the appropriate library path
echo 'export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda
export PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64
' >> ~/.bashrc

# install anaconda3 4.4 (python3.6)
ANACONDA_FILE=Anaconda3-4.4.0-Linux-x86_64.sh
wget https://repo.continuum.io/archive/${ANACONDA_FILE}
bash ${ANACONDA_FILE} -b -p /mnt/bin/anaconda3
rm ${ANACONDA_FILE}
echo 'export PATH="/mnt/bin/anaconda3/bin:$PATH"' >> ~/.bashrc

# install tensorflow-gpu 1.3
#TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-1.3.0-cp35-cp35m-linux_x86_64.whl
/mnt/bin/anaconda3/bin/pip install tensorflow-gpu==1.3
/mnt/bin/anaconda3/bin/pip install theano
#install keras
/mnt/bin/anaconda3/bin/pip install keras
/mnt/bin/anaconda3/bin/pip install opencv-python



# install monitoring programs
sudo wget https://git.io/gpustat.py -O /usr/local/bin/gpustat
sudo chmod +x /usr/local/bin/gpustat
sudo nvidia-smi daemon
sudo apt-get -y install htop

# reload .bashrc
exec bash
