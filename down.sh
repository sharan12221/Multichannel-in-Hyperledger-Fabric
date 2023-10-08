docker-compose -f docker-compose.yaml down
docker ps -a
docker rm $(docker ps -aq)
rm -r channel-artifacts
rm -r crypto-config