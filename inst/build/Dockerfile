ARG R_VERSION
ARG OS_VERSION

FROM renatosamperio/r-one-api:${OS_VERSION}-R${R_VERSION}
ARG R_VERSION

RUN ARCH=`uname -m` && \
    echo "ARCH: ${ARCH}"

# # install required packages
# RUN dnf -y update \
#  && dnf -y upgrade \
#  && dnf -y --allowerasing install \
#         ninja-build \
#         python312 \
#         spirv-tools-devel \
#   && dnf clean all

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo -O /etc/yum.repos.d/cuda-rhel9.repo \
  && dnf update -y \ 
  && dnf makecache \
  && dnf install -y \
        cuda \
        cuda-drivers \
  && dnf upgrade -y \
  && dnf module install -y nvidia-driver

CMD ["/bin/bash"]
WORKDIR /home/rmpuser
