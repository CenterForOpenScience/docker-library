# Central Authentication Server (CAS)

## Local Setup

### Requirements

* [VirtualBox](https://www.virtualbox.org/)
* [Boot2Docker](http://boot2docker.io/)
  * [Port Forwarding](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md#port-forwarding)
* [Docker Compose](https://docs.docker.com/compose/)

### Setup Environment

* Clone Repository (https://github.com/CenterForOpenScience/cas-overlay.git)
* Forward Local MongoDB Port to Boot2Docker {Host -> [Boot2Docker} -> Docker}
  * `boot2docker ssh -vnNTR 27017:localhost:27017`
* Forward Exposed Docker Ports to the Host {Docker -> [Boot2Docker} -> Host]
  * `VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port8443,tcp,,8443,,8443";`
* Download Docker Images
  * `docker-compose pull`

### Run Environment

* Start Postgres & CAS Servers
  * `docker-compose up`
* Check CAS is Available
  * Browse to `https://localhost:8443`
