# Use the Ubuntu base image
FROM ubuntu:latest

# Install OpenSSH server and curl
RUN apt-get update && apt-get install -y openssh-server curl && apt-get clean

# Create the SSH user
RUN useradd -ms /bin/bash ubuntu

# Set up SSHD config to allow key authentication
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin no' >> /etc/ssh/sshd_config

# Create privilege separation directory
RUN mkdir -p /run/sshd

# Fetch the public key and place it in the appropriate directory
RUN mkdir -p /home/ubuntu/.ssh && \
    curl -L https://github.com/0xBennyV.keys -o /home/ubuntu/.ssh/authorized_keys && \
    chown ubuntu:ubuntu /home/ubuntu/.ssh/authorized_keys && \
    chmod 600 /home/ubuntu/.ssh/authorized_keys

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
