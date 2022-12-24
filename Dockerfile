FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libuv1-dev \
    libssl-dev \
    libhwloc-dev

# Clone the Xmrig repository and build it
RUN git clone https://github.com/xmrig/xmrig.git && \
    cd xmrig && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

# Copy the custom configuration file into the image
COPY config.json /xmrig/build/config.json

# Set the working directory to the build directory
WORKDIR /xmrig/build

# Run Xmrig with the custom configuration file when the container starts
CMD ["./xmrig", "--config=config.json"]
