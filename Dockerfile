FROM ubuntu:24.10

RUN apt update && apt install -y wget curl jq ca-certificates curl apt-transport-https lsb-release gnupg npm postgresql-client

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.asc \
    && apt update -y \
    && apt install google-cloud-sdk google-cloud-cli-gke-gcloud-auth-plugin -y

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash && apt update && apt install -y azure-cli

RUN wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | tee /etc/apt/trusted.gpg.d/server-7.0.asc && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list && \
    apt update && \
    apt install -y mongodb-mongosh mongodb-database-tools zstd

RUN apt autoremove && apt clean && rm /var/lib/apt/lists/*_dists_*

RUN npm install elasticdump -g
