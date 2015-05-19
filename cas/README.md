# Central Authentication Server (CAS)

## Local Setup

### Requirements

* [VirtualBox](https://www.virtualbox.org/)
* [Boot2Docker](http://boot2docker.io/)
  * [Port Forwarding](https://github.com/boot2docker/boot2docker/blob/master/doc/WORKAROUNDS.md#port-forwarding)
* [Docker Compose](https://docs.docker.com/compose/)

### Requirements Installation 

* Download and install VirtualBox [](https://www.virtualbox.org/wiki/Downloads); this adds `VBoxManage` to your path
* Download and install Boot2Docker [](http://boot2docker.io/); open a terminal and run `boot2docker`
* Download and install both docker and docker-compose [](https://docs.docker.com/compose/install/); this may ask you to export certain system variables 
  * typically this mean adding some `export {VAR}={path}` statements to your ~/.bashrc or ~/.bash_profile

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
  * make sure your working directory is XXX/docker-library/cas
  * `docker-compose pull`

### Manage the Environment

* Forward Local MongoDB Port to Boot2Docker {Host -> [Boot2Docker} -> Docker]
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
