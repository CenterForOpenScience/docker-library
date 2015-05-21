# Central Authentication Server (CAS)

## Local Setup

### Requirements

* [Homebrew](http://brew.sh/)
  * Install autossh `brew install autossh`
* [VirtualBox](https://www.virtualbox.org/)
* [Boot2Docker](http://boot2docker.io/)
  * [Port Forwarding](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md#port-forwarding)
* [Docker Compose](https://docs.docker.com/compose/)

### Setup Environment

* Clone Docker Library Repository (https://github.com/CenterForOpenScience/docker-library.git)
* Forward Exposed Docker Ports to the Host {Docker -> [Boot2Docker} -> Host]
  * `VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port8443,tcp,,8443,,8443";`
  * `VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port8080,tcp,,8080,,8080";`
  * *An existing port forward rule can be removed with the following command*
    * `VBoxManage controlvm "boot2docker-vm" natpf1 delete "tcp-port8443";`
* Start Boot2Docker and initialize shell environment variables
  * `boot2docker up`
  * `$(boot2docker shellinit)`
* Download Docker Images
  * `docker-compose pull`

### Manage the Environment

* Start Boot2Docker
  * `boot2docker up`
* Forward Local MongoDB Port to Boot2Docker {Host -> [Boot2Docker} -> Docker]
  * `autossh -M 20000 -N docker@localhost -R 27017:localhost:27017 -i ~/.ssh/id_boot2docker -p $(boot2docker config 2>&1 | awk '/SSHPort/ {print $3}') -C`

    *or*

  * `boot2docker ssh -vnNTR 27017:localhost:27017`
* Navigate to the `cas` folder in the Docker Library
  * `cd <docker library>/cas`
* Create & Start Postgres & CAS Servers
  * `cd <docker library>/cas`
  * `docker-compose up`
* Verify CAS is available
  * Browse to `https://localhost:8443`
* Terminate the current docker compose session (docker instances will be shutdown)
  * `CTRL+C`
* Start docker compose instances
  * `docker-compose start`
* Reattach and view current running docker compose logs
  * `docker-compose logs`
