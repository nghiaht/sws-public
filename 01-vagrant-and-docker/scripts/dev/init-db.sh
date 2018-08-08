#!/bin/bash

## MongoDB
echo " => Initializing database ... "
docker-compose -p dev -f docker-compose.yml exec -d mongo mongo --nodb --eval 'var conn; try { conn = new Mongo("localhost:27017");}
  catch(Error) { } while(conn===undefined) { try { conn = new Mongo("localhost:27017"); } catch(Error) { } sleep(100); }'

echo " => Creating database users ... "
docker-compose -p dev -f docker-compose.yml exec -d mongo mongo admin --eval "db.createUser({ user: 'root', pwd: 'root', roles: [ 'root' ] });"
docker-compose -p dev -f docker-compose.yml exec -d mongo mongo admin -u root -p root --eval "db.getSiblingDB('testdb').createUser({ user: 'test', pwd: 'test', roles: [ 'dbOwner' ] });"
