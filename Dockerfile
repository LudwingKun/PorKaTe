FROM kalilinux/kali-rolling:latest

# Combine all updates and installations in single layers to reduce size
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    # Core Kali tools (lightweight selection instead of full kali-linux-default)
    kali-tools-top10 \
    # Required packages
    vsftpd \
    hexedit \
    strongswan \
    libstrongswan-extra-plugins \
    dkms \
    lynx \
    s-nail \
    alien \
    nsis \
    httptunnel \
    net-tools \
    ettercap-common \
    ettercap-text-only \
    ptunnel \
    nmap \
    openssl \
    hashdeep \
    p7zip-full \
    apache2 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && find /var/log -type f -exec truncate -s 0 {} \;

# Set working directory
WORKDIR /root

# Keep container running
CMD ["/bin/bash"]
