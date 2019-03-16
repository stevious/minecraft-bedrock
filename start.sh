#!/bin/bash
useradd -u $PUID -g $PGID steve
chown -R $PUID:$PGID $DATA_PATH
chown -R $PUID:$PGID /opt/minecraft-bedrock

sudo -E -u steve /bin/bash << EOF

if [ ! -d "$DATA_PATH/worlds" ]; then
  mkdir -p $DATA_PATH/worlds
fi

if [ ! -f "$DATA_PATH/server.properties" ]; then
  cp $DEFAULTS_PATH/server.properties $DATA_PATH/server.properties
fi

if [ ! -f "$DATA_PATH/permissions.json" ]; then
  cp $DEFAULTS_PATH/permissions.json $DATA_PATH/permissions.json
fi

if [ ! -f "$DATA_PATH/whitelist.json" ]; then
  cp $DEFAULTS_PATH/whitelist.json $DATA_PATH/whitelist.json
fi

ln -s $DATA_PATH/worlds $SERVER_PATH/worlds
ln -s $DATA_PATH/server.properties $SERVER_PATH/server.properties
ln -s $DATA_PATH/permissions.json $SERVER_PATH/permissions.json
ln -s $DATA_PATH/whitelist.json $SERVER_PATH/whitelist.json

export LD_LIBRARY_PATH=.
exec $SERVER_PATH/bedrock_server

EOF
