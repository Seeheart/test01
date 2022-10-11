#!/bin/bash
mkdir -p /mongodb/2801{7..9}/{conf,data,log}
mkdir -p /mongodb/28020/{conf,data,log}

cat >/mongodb/28017/conf/mongod.conf <<EOF
systemLog:
  destination: file
  path: /mongodb/28017/log/mongodb.log
  logAppend: true
storage:
  journal:
    enabled: true
  dbPath: /mongodb/28017/data
  directoryPerDB: true
  #engine: wiredTiger
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1
      directoryForIndexes: true
    collectionConfig:
      blockCompressor: zlib
    indexConfig:
      prefixCompression: true
processManagement:
  fork: true
net:
  bindIp: 192.168.1.202,127.0.0.1
  port: 28017
replication:
  oplogSizeMB: 2048
  replSetName: my_repl
EOF

\cp  /mongodb/28017/conf/mongod.conf  /mongodb/28018/conf/
\cp  /mongodb/28017/conf/mongod.conf  /mongodb/28019/conf/
\cp  /mongodb/28017/conf/mongod.conf  /mongodb/28020/conf/

sed -i 's/28017/28018/g' /mongodb/28018/conf/mongod.conf
sed -i 's/28017/28019/g' /mongodb/28019/conf/mongod.conf
sed -i 's/28017/28020/g' /mongodb/28020/conf/mongod.conf

chown -R mongod:mongod /mongodb

/bin/mongod -f /mongodb/28017/conf/mongod.conf
/bin/mongod -f /mongodb/28018/conf/mongod.conf
/bin/mongod -f /mongodb/28019/conf/mongod.conf
/bin/mongod -f /mongodb/28020/conf/mongod.conf

mongo -port 28017 admin
config = {_id: 'my_repl', members: [
                          {_id: 0, host: '192.168.1.202:28017'},
                          {_id: 1, host: '192.168.1.202:28018'},
                          {_id: 2, host: '192.168.1.202:28019',"arbiterOnly":true}]
          }                
rs.initiate(config)

