#Generate the Certificates for Organizations, Administrators and Users
../bin/cryptogen generate --config=./crypto-config.yaml

#Generate the Configuration Transactions for the Channels
mkdir channel-artifacts

#Creating the genesis.block
../bin/configtxgen -profile OrdererGenesis -outputBlock ./channel-artifacts/genesis.block

#define environment variables.
export CHANNEL_ONE_NAME=channelall
export CHANNEL_ONE_PROFILE=ChannelAll
export CHANNEL_TWO_NAME=channel123
export CHANNEL_TWO_PROFILE=Channel123
export CHANNEL_TWO_NAME12=channel12
export CHANNEL_TWO_PROFILE12=Channel12

#generate the configuration transaction for channels.
#creating channelall.tx
../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME

#creating channel123.tx
../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME

#creating channel12.tx
../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE12} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME12}.tx -channelID $CHANNEL_TWO_NAME12

./1channelAll.sh
./2channel123.sh
./3channel12.sh
#for bringing up the network and docker compose
docker-compose -f docker-compose.yaml up -d