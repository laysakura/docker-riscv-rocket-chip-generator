FROM laysakura/docker-riscv-rocket-tools:latest

WORKDIR /setup

# Configure apt and install packages
RUN apt update \
    #
    # Install Verilator's dependencies
    && apt -y install default-jre python wget \
    #
    # Clean up
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Clone rocket-chip repo.
RUN git clone https://github.com/chipsalliance/rocket-chip.git \
    && cd rocket-chip \
    && git submodule update --init

# Install Verilator.
RUN cd rocket-chip/emulator \
    && make \
    && make debug

WORKDIR /setup/rocket-chip/emulator

CMD ["bash"]
