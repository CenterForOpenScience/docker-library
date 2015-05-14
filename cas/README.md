# Central Authentication Server (CAS)

## Local Setup

### Requirements

* [VirtualBox](https://www.virtualbox.org/)
* [Boot2Docker](http://boot2docker.io/)
  * [Port Forwarding](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md#port-forwarding)
* [Docker Compose](https://docs.docker.com/compose/)

### Start Environment

* Clone Repository (https://github.com/CenterForOpenScience/cas-overlay.git)
* Forward Exposed Docker Ports to the Host {Docker -> [VirtualBox} -> Host]
  * `VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port8443,tcp,,8443,,8443";`
* Update Docker Images
  * `docker-compose pull`
* Run the Environment
  * `docker-compose up`
