FROM ubuntu:20.04

RUN apt-get update && TZ='Asia/Tokyo' DEBIAN_FRONTEND=noninteractive apt-get install -y \
	g++-aarch64-linux-gnu \
	curl \
	wget \
	build-essential \
	qemu-system-aarch64
	
RUN useradd -m docker
USER docker

# Setup rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh /dev/stdin -y

ENV PATH /home/docker/.cargo/bin:$PATH

RUN rustup target add aarch64-unknown-linux-gnu
RUN cargo install cargo-binutils
RUN rustup component add llvm-tools-preview

# Copy template project
WORKDIR /home/docker
COPY --chown=docker aarch64-linux-gnu_template_project ./aarch64-linux-gnu_template_project


