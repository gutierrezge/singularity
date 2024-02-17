FROM ubuntu:22.04

# Update system
RUN apt update && apt -y upgrade && apt -y autoremove
RUN apt install -y wget git vim \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    pkg-config \
    golang-go 

# Install singularity
RUN wget https://github.com/sylabs/singularity/releases/download/v4.1.1/singularity-ce_4.1.1-jammy_amd64.deb && \
    apt install -y ./singularity-ce_4.1.1-jammy_amd64.deb && \
    rm singularity-ce_4.1.1-jammy_amd64.deb

# Set working directory
WORKDIR /workspace

# Download Singularity, domain and solution files
RUN wget https://bitbucket.org/ipc2018-classical/team23/raw/0442832d7c4c0d8480841ddba7bc864ee5d0bb0f/Singularity && \
    wget https://bitbucket.org/ipc2018-classical/team23/src/ipc-2018-seq-opt/misc/tests/benchmarks/miconic/domain.pddl && \
    wget https://bitbucket.org/ipc2018-classical/team23/src/ipc-2018-seq-opt/misc/tests/benchmarks/miconic/s1-0.pddl

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Create test.sh file
RUN echo '#!/bin/bash' > /workspace/test.sh && \
    echo "singularity build planner.img Singularity" >> /workspace/test.sh && \
    echo "singularity run -C -H $RUNDIR planner.img domain.pddl s1-0.pddl sas_plan" >> /workspace/test.sh && \
    chmod +x /workspace/test.sh
    
CMD ["bash"]
