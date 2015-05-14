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
  * *An existing port forward rule can be removed with the following command*
    * `VBoxManage controlvm "boot2docker-vm" natpf1 delete "tcp-port8443";`
* Download Docker Images
  * `docker-compose pull`

### Manage the Environment

* Create & Start Postgres & CAS Servers
  * `docker-compose up`
* Verify CAS is available
  * Browse to `https://localhost:8443`
* Terminate the current docker compose session (docker instances will be shutdown)
  * `CTRL+C`
* Start docker compose instances
  * `docker-compose start`
* Reattach and view current running docker compose logs
  * `docker-compose logs`
