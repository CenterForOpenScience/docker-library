import furl
import pyrax
import invoke
import requests


BASE_URL = 'http://{}:{}/v2/keys/rackspace'.format('127.0.0.1', 4001)


def build_url(*segments, **query):
    url = furl.furl(BASE_URL)
    url.path.segments.extend(segments)
    url.args.update(query)
    return url.url


@invoke.task
def mount(volume_name, server_name, username=None, api_key=None, region=None):
    if not username and not api_key and not region:
        resp = requests.get(
            build_url('credentials')
        ).json()

        credentials = resp['node']
    else:
        credentials = []

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
        build_url('cbs', volume_name),
        data=volume.attachments[0]['device']
    )
