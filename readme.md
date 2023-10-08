# Steps to run the fabric sample test network with 4 ORG

- Step 1: Start the Network

`$ ./network.sh` .

Open four new terminals for Universitiy, Compani , Student and Verifier. (CLI)

In Terminal 1: for Universitiy

`cd envVar && ./Universitiy.sh`

In Terminal 2: for Compani

`cd envVar && ./Compani.sh`

In Terminal 3: for Student

`cd envVar && ./Student.sh`

In Terminal 4: for Verifier

`cd envVar && ./Verifier.sh`

---

---

For easy access, export this parameter ORDERER_CA in all Four terminals.

- `export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem `

---

# Create the channelAll.block file (any Terminal)

- `peer channel create -o orderer.example.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channelall.tx --tls --cafile $ORDERER_CA`

Now a file channelall.block is created.

Join the Four peers to this channel and update the anchor peer for each peer.

- Universitiy Terminal:  
  `peer channel join -b channelall.block --tls --cafile $ORDERER_CA`

* `peer channel update -o orderer.example.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/UniversitiyMSPanchors_channelall.tx --tls --cafile $ORDERER_CA`

- Compani Terminal:  
  `peer channel join -b channelall.block --tls --cafile $ORDERER_CA`

- `peer channel update -o orderer.example.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CompaniMSPanchors_channelall.tx --tls --cafile $ORDERER_CA`

- Student Terminal:  
  `peer channel join -b channelall.block --tls --cafile $ORDERER_CA`

- `peer channel update -o orderer.example.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/StudentMSPanchors_channelall.tx --tls --cafile $ORDERER_CA`

- Verifier Terminal:  
  `peer channel join -b channelall.block --tls --cafile $ORDERER_CA`

- `peer channel update -o orderer.example.com:7050 -c channelall -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/VerifierMSPanchors_channelall.tx --tls --cafile $ORDERER_CA`

---

---

---

# Create the channel123.block file (any Terminal of Universitiy,Compani,Student)

- `peer channel create -o orderer.example.com:7050 -c channel123 -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/channel123.tx --tls --cafile $ORDERER_CA`

Now a file channel123.block is created.

Join the two peers to this channel and update the anchor peer for each peer.

- Universitiy Terminal:

- `peer channel join -b channel123.block --tls --cafile $ORDERER_CA`

- `peer channel update -o orderer.example.com:7050 -c channel123 -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/UniversitiyMSPanchors_channel123.tx --tls --cafile $ORDERER_CA`

- Compani Terminal

- `peer channel join -b channel123.block --tls --cafile $ORDERER_CA`

- `peer channel update -o orderer.example.com:7050 -c channel123 -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/CompaniMSPanchors_channel123.tx --tls --cafile $ORDERER_CA`

- Student Terminal

- `peer channel join -b channel123.block --tls --cafile $ORDERER_CA`

- `peer channel update -o orderer.example.com:7050 -c channel123 -f /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/StudentMSPanchors_channel123.tx --tls --cafile $ORDERER_CA`

---

# To install the chaincode, on each terminal,

By installing the chaincode, it loads the chaincode onto each peer. Note that chaincode is not yet useable until it is being instantiated.

Install The chaincode on all terminal

- `peer chaincode install -n sacc -p github.com/chaincode/sacc -v 1.0`

# Instantiate and Interact with Chaincode on ChannelAll

- On Universitiy Terminal, we instantiate the code on ChannelAll.



- `peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C channelall -c '{"Args":["a", "100"]}'  -n sacc -v 1.0 -P "OR('UniversitiyMSP.peer', 'CompaniMSP.peer', 'StudentMSP.peer', 'VerifierMSP.peer')"`

We will query the value of key “a” in ChannelAll.

- On Universitiy Terminal,

* `peer chaincode query -C channelall -n sacc -c '{"Args":["get","a"]}'`

- On Compani Terminal
- `peer chaincode query -C channelall -n sacc -c '{"Args":["get","a"]}'`

- On Student Terminal
- `peer chaincode query -C channelall -n sacc -c '{"Args":["get","a"]}'`

- On Verifier Terminal
- `peer chaincode query -C channelall -n sacc -c '{"Args":["get","a"]}'`

We now see that the Four peers has the same value obtained. They are sharing the same ledger.

---

# Instantiate and Interact with Chaincode on Channel12

Now we instantiate the same SACC on Channel123.

- On Universitiy Terminal
- `peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile $ORDERER_CA -C channel123 -c '{"Args":["b", "200"]}' -n sacc -v 1.0 -P "OR('UniversitiyMSP.peer', 'CompaniMSP.peer','StudentMSP.peer')"`

Then again we begin with Universitiy Terminal.

- Universitiy Terminal.
- `peer chaincode query -C channel123 -n sacc -c '{"Args":["get","b"]}'`

- Compani Terminal.
- `peer chaincode query -C channel123 -n sacc -c '{"Args":["get","b"]}'`

- Student Terminal.
- `peer chaincode query -C channel123 -n sacc -c '{"Args":["get","b"]}'`

And if we issue the same command on Verifier Terminal, we see access denied message. It is because Verifier is not in Channel123.

- Verifier Terminal.
- `peer chaincode query -C channel123 -n sacc -c '{"Args":["get","b"]}'`

---

If we try to get the value of key “a” on Channel123, we find that “a” is not defined. Each channel has its own ledger and the state is not shared.

On Universitiy or Compani or Student Terminal,

- `peer chaincode query -C channel12 -n sacc -c '{"Args":["get","a"]}'`

# Clean Up Everything

- `./down.sh`

After everything is complete, it is good practice to clean up everything, including the docker containers and those files generated for this demo.

To shutdown all containers and remove them, we use docker-compose to remove those created through the configuration files.

Finally we remove the whole directory of crypto-config. The directory will be created next time by the cryptogen.
