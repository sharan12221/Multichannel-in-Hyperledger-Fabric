#specifying the environment variables for Verifier
docker exec -e "CORE_PEER_LOCALMSPID=VerifierMSP" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Verifier.example.com/peers/peer0.Verifier.example.com/tls/ca.crt" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Verifier.example.com/users/Admin@Verifier.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.Verifier.example.com:7051" -it cli bash

#For easy access, exporting PATH orderer tlsca.example.com-cert.pem
#export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
