# Build from Debian based python image
FROM python:3.10.15-slim-bullseye
# Set working directory
WORKDIR /semaphore

# Install required packages
RUN apt-get -y update && apt-get -y install git wget gettext sshpass
# Install Ansible
RUN git clone https://github.com/kubernetes-sigs/kubespray /tmp/kubespray
RUN cd /tmp/kubespray && pip install -U -r requirements.txt
# Download and install semaphore
RUN cd /tmp && wget https://github.com/ansible-semaphore/semaphore/releases/\
download/v2.10.35/semaphore_2.10.35_linux_amd64.deb
RUN dpkg -i /tmp/semaphore_2.10.35_linux_amd64.deb
# Copy semaphore config
COPY config_template.json /semaphore/config_template.json
COPY entrypoint.sh /semaphore/entrypoint.sh
RUN chmod +x /semaphore/entrypoint.sh

# Define environment variables with default values (optional)
ENV SEMAPHORE_DB_USER=${SEMAPHORE_DB_USER:-semaphore}
ENV SEMAPHORE_DB_PASS=${SEMAPHORE_DB_PASS:-semaphore}
ENV SEMAPHORE_DB_HOST=${SEMAPHORE_DB_HOST:-mysql}
ENV SEMAPHORE_DB_PORT=${SEMAPHORE_DB_PORT:-3306}
ENV SEMAPHORE_DB_DIALECT=${SEMAPHORE_DB_DIALECT:-mysql}
ENV SEMAPHORE_DB=${SEMAPHORE_DB:-semaphore}
ENV SEMAPHORE_PLAYBOOK_PATH=${SEMAPHORE_PLAYBOOK_PATH:-/tmp/semaphore/}
ENV SEMAPHORE_ADMIN_NAME=${SEMAPHORE_ADMIN_NAME:-admin}
ENV SEMAPHORE_ADMIN_EMAIL=${SEMAPHORE_ADMIN_EMAIL:-admin@localhost}
ENV SEMAPHORE_ADMIN=${SEMAPHORE_ADMIN:-admin}

# Clean up
RUN rm -rf /tmp/kubespray && rm -rf /tmp/semaphore_2.10.35_linux_amd64.deb
# Startup process
ENTRYPOINT ["/semaphore/entrypoint.sh"]
