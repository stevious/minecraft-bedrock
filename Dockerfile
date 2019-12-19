FROM ubuntu:19.10

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y apt-utils sudo unzip curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV SERVER_PATH="/opt/minecraft-bedrock"
ENV DEFAULTS_PATH="${SERVER_PATH}/defaults"
ENV DATA_PATH="/config"

RUN curl https://minecraft.azureedge.net/bin-linux/bedrock-server-1.14.1.4.zip --output bedrock-server.zip
RUN mkdir -p ${DEFAULTS_PATH} ${DATA_PATH}
RUN unzip bedrock-server.zip -d ${SERVER_PATH}
RUN rm bedrock-server.zip $SERVER_PATH/server.properties $SERVER_PATH/whitelist.json $SERVER_PATH/permissions.json

COPY start.sh ${SERVER_PATH}
COPY defaults/server.properties ${DEFAULTS_PATH}
COPY defaults/whitelist.json ${DEFAULTS_PATH}
COPY defaults/permissions.json ${DEFAULTS_PATH}

VOLUME ${DATA_PATH}

WORKDIR ${SERVER_PATH}
EXPOSE 19132/udp 19133/udp

RUN chmod +x start.sh
CMD ./start.sh
