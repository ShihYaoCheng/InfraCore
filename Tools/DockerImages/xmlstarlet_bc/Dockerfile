FROM bitnami/git

RUN apt update && apt install xmlstarlet -y && apt install bc -y && apt-get autoremove -y && apt-get clean

ENTRYPOINT ["/bin/bash"]