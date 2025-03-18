# Use an Ubuntu base image
FROM ubuntu:latest

# Set the tools installation directory
ENV TOOLS /tools
RUN mkdir -p $TOOLS

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    unzip \
    bzip2 \
    build-essential \
    python3 \
    python3-pip \
    openjdk-11-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Install bwa-mem2 v2.2.1
RUN wget -O /tmp/bwa-mem2.tar.bz2 https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.2.1/bwa-mem2-2.2.1_x64-linux.tar.bz2 \
    && tar -xjf /tmp/bwa-mem2.tar.bz2 -C /tmp \
    && mv /tmp/bwa-mem2-2.2.1_x64-linux $TOOLS/bwa-mem2-2.2.1 \
    && rm /tmp/bwa-mem2.tar.bz2
ENV PATH="$TOOLS/bwa-mem2-2.2.1:$PATH"
ENV BWAMEM2="$TOOLS/bwa-mem2-2.2.1/bwa-mem2"

# Install samtools v1.17
RUN apt-get update && apt-get install -y samtools \
    && rm -rf /var/lib/apt/lists/*
ENV SAMTOOLS="/usr/bin/samtools"

# Install multiqc v1.17
RUN pip3 install --break-system-packages multiqc==1.17
ENV MULTIQC="/usr/local/bin/multiqc"

# Install picard v3.0.0
RUN wget -O $TOOLS/picard-3.0.0.jar https://github.com/broadinstitute/picard/releases/download/3.0.0/picard.jar
ENV PICARD="/usr/bin/java -jar $TOOLS/picard-3.0.0.jar"

# Set permissions
RUN chmod +x $TOOLS/bwa-mem2-2.2.1/bwa-mem2

# Set work directory
WORKDIR /data

# Default command
CMD ["/bin/bash"]

# Delete temporary files
RUN rm -rf /var/lib/apt/lists/* /tmp/*
