import furl
import json
import pyrax
import invoke
import requests


def build_url(base_url, *segments, **query):
    url = furl.furl(base_url)
    url.path.segments.extend(segments)
    url.args.update(query)
    return url.url


@invoke.task
def mount(volume_name, server_name, etcd):
    resp = requests.get(
        build_url(etcd, 'rackspace', 'credentials')
    ).json()

    credentials = json.loads(resp['node']['value'])

    username = credentials['username']
    api_key = credentials['apiKey']
    region = credentials['region']

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
        build_url(etcd, 'rackspace', 'cbs', volume_name),
        data={"value": volume.attachments[0]['device']}
    )



@invoke.task
def umount(volume_name, server_name, etcd):
    resp = requests.get(
        build_url(etcd, 'rackspace', 'credentials')
    ).json()

    credentials = json.loads(resp['node']['value'])

    username = credentials['username']
    api_key = credentials['apiKey']
    region = credentials['region']

    pyrax.set_setting('identity_type', 'rackspace')
    pyrax.set_credentials(username, api_key, region=region)

    cs = pyrax.cloudservers
    cbs = pyrax.cloud_blockstorage

    volume = cbs.find(display_name=volume_name)
    server = cs.servers.find(name=server_name)

    if volume.attachments and volume.attachments[0]['server_id'] == server.id:
        volume.detach()
        pyrax.utils.wait_until(volume, 'status', 'available', interval=3, attempts=0)
