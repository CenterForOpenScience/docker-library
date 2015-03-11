import invoke
import logging

logging.captureWarnings(True)


@invoke.task
def mount(volume_name, server_name, username=None, api_key=None, region=None):
    import furl
    import pyrax
    import requests

    url = furl.furl('http://{}:{}/v2/keys/rackspace'.format('127.0.0.1', 4001))

    resp = requests.get(
        url.path.segments.extend(['credentials']).url
    ).json()

    credentials = resp['node']

    username = username or credentials['username']
    api_key = api_key or credentials['apiKey']
    region = region or credentials['region']

    pyrax.set_setting('identity_type', 'rackspace')
    pyrax.set_credentials(username, api_key, region=region)

    cs = pyrax.cloudservers
    cbs = pyrax.cloud_blockstorage

    volume = cbs.find(display_name=volume_name)
    server = cs.servers.find(name=server_name)

    if volume.attachments and volume.attachments[0]['server_id'] != server.id:
        volume.detach()
        pyrax.utils.wait_until(volume, 'status', 'available', interval=3, attempts=0)

    if not volume.attachments:
        volume.attach_to_instance(server, mountpoint='')
        pyrax.utils.wait_until(volume, 'status', 'in-use', interval=3, attempts=0)

    resp = requests.put(
        url.path.segments.extend(['cbs', volume_name]).url,
        data=volume.attachments[0]['device']
    )
