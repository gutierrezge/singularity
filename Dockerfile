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

# Download example
RUN wget https://bitbucket.org/ipc2018-classical/team1/raw/ipc-2018-seq-sat/Singularity && \
    git clone https://bitbucket.org/ipc2018-classical/demo-submission.git

# Set environment variables
ENV RUNDIR="/workspace/demo-submission/misc/tests/benchmarks/miconic"
ENV DOMAIN="$RUNDIR/domain.pddl"
ENV PROBLEM="$RUNDIR/s1-0.pddl"
ENV PLANFILE="$RUNDIR/sas_plan"
ENV COSTBOUND="42"
ENV DEBIAN_FRONTEND=noninteractive

# Set resource limits
RUN ulimit -t 1800 && ulimit -v 8388608

# Create test.sh file
RUN echo '#!/bin/bash' > /workspace/test.sh && \
    echo "singularity build planner.img Singularity" >> /workspace/test.sh && \
    echo "singularity run -C -H $RUNDIR planner.img $DOMAIN $PROBLEM $PLANFILE $COSTBOUND" >> /workspace/test.sh && \
    chmod +x /workspace/test.sh
    
CMD ["bash"]
