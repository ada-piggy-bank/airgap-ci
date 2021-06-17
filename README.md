# airgap-ci
Teamcity config and docker compose for running airgap node actions

This project will enable you to install teamcityu on an airgapped node and bootstrap a block producer.
Additionally there are the scripts for updating your node and rotating your KES.

Any data that needs to be exported to your BP is created as both an artifact and a qr code.
The QR code allows you to transfer data between your BP and cold environment without the constant switching of USB, I use a handheld USB QR scanner with a USB switch for the 2 computers.

There are bluetooth software scanners that you could install on your phone, but I found them difficult to set up and just spent £20 on a scanner instead.

## Prerequisites
Download the cardano-cli from a trusted source. I wouldn't get it from a third party an neither should you.
install qrencode on your hot environment / relay. This will allow the scripts to generate a qr code for your balance, transaction ids etc.
install docker and docker-compose on your cold environment

## Install the scripts on your relay
Copy the scripts in the relay-scripts to yoru relay node
Update the payment.addr file to incluide your payment address if you have one.
If you don't have one, one will be generated on the cold environment.

## Install the dockerised teamcity server and agent
create the following directories inside teamcity-compose (The build has some permission issues when it creates them so it's easier to di it manually)
```bash
├── server
│   ├── data_dir
│   └── log_dir
├── cli-agent
    ├── lib
    ├── conf
    ├── keys
    └──certs
```
Copy the cardano-cli into the cli-agent/lib directory
run "docker-compose up --no-start && docker-compose start" (this will run as a daemon instead of tty)

## Install the Teamcity Build
Login to your server on the airgap machine http://localhost:8111
You should be prompted to create an admin user
Import the TeamcityAirgapNodeActipons.zip file (Administration/Projects Import)

## Setting your custom parameters
You will need to set your custom parameter values

Air Gap Node Actions - Parameters (Change network Config --Mainnet | --testnet-magic 1097911063) 
Air Gap Node Actions - Templates - Create Pool Certificate - Parameters (Your pool specific parameters)



## Running the builds
There are 2 main build chains. 
  Register Pool
  Create node certificate.

Running these will also run their dependencies. Any keys that don't exist will be created, any that already do will be reused, You will need to manually delete keys if you want to regenerate.

You can also run the builds in order, they are numbered in an order that will satisfy all dependencies, but you can let the chain do the work.


## Keys and Certs directory Structure
The keys and certs will be written/read from the following directory structure
```bash
└── cli-agent
    ├── keys
    │   ├── cold
    │   │   ├──node.counter
    │   │   ├──node.skey
    │   │   └──node.vkey
    │   ├── kes
    │   │   ├──kes.skey
    │   │   └──kes.vkey
    │   ├── payment
    │   │   ├──payment.addr
    │   │   ├──payment.skey
    │   │   └──payment.vkey
    │   ├── stake
    │   │   ├──stake.addr
    │   │   ├──stake.skey
    │   │   └──stake.vkey
    │   └── vrf
    │       ├──vrf.skey
    │       └──vrf.vkey
    └── certs
        ├── deleg.cert
        ├── node.cert
        ├── pool.cert
        ├── stake.cert
        └── stakepoolid.txt
```



