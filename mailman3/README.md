# mailman3

Dockerfile and configuration as applicable for the OSF.

> #### Incomplete

> - Move postgres to an external container
> - Consolidate configuration options for mailman3, mailman-bundler, and postfix

## Information

This container is configured here for production.
- Mailman is set up to use gunicorn as the WSGI server.
- The web interface, the union of HyperKitty and Postorious, listens on the container's port `8000`. `docker-compose.yml` maps that to the host's port `18000` to avoid collision with OSF services.
- The API Listens on the container's port `8001`, and requires credentials. These are configured in `config/mailman3/mailman-bundler/venv-3.4/lib/python3.4/site-packages/mailman/config/schema.cfg`. This will likely change in order to promote this Docker configuration's ease of use.

Check out the Mailman Docs for more information about this application: http://pythonhosted.org/mailman/README.html, or look at the API client for ideas on how to interact with mailman: http://mailmanclient.readthedocs.io/en/latest/


## Setup

- Ensure docker and docker-compose are configured and installed correctly
- `# docker-compose up`
- To run in the background, wait until the server is running, and then `^C`,
- `# docker-compose start`



