#specifying the environment variables for Compani 
docker exec -e "CORE_PEER_LOCALMSPID=CompaniMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Compani.example.com/peers/peer0.Compani.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Compani.example.com/users/Admin@Compani.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.Compani.example.com:7051" -it cli bash

#For easy access, exporting PATH orderer tlsca.example.com-cert.pem
#export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
