FROM bitnami/git

RUN apt update && apt install wget -y && apt-get autoremove -y && apt-get clean

RUN wget https://github.com/mikefarah/yq/releases/download/v4.11.1/yq_linux_amd64 -O /usr/bin/yq &&
chmod +x /usr/bin/yq

ENTRYPOINT ["/bin/bash"]