../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE12} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_TWO_NAME12}.tx -channelID $CHANNEL_TWO_NAME12 -asOrg UniversitiyMSP
../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE12} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_TWO_NAME12}.tx -channelID $CHANNEL_TWO_NAME12 -asOrg CompaniMSP