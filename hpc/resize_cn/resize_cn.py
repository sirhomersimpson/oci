import time

import click
import oci
import pprint

from oci.config import from_file, validate_config
from oci.core import ComputeManagementClient
from oci.core.models import UpdateInstancePoolDetails

config = from_file()
validate_config(config)
compute_client = oci.core.ComputeClient(config)
compute_management_client = ComputeManagementClient(config)


def update_cn_size(cn_ocid, size):
    """
    Updates the size of the Clustered network
    :param cn_ocid: Clustered Network OCID
    :param size:  size of the the new cluster
    :return: None
    """

    cluster_network_response = compute_management_client.get_cluster_network(
        cluster_network_id=cn_ocid)
    pool_id = cluster_network_response.data.instance_pools[0].id
    current_size_cn = cluster_network_response.data.instance_pools[0].size
    print(f'pool_id:{pool_id} current pool_size:{current_size_cn} next_size : {size}')
    size = int(size)
    update_details = UpdateInstancePoolDetails(size=size)
    update_instance_pool_response = compute_management_client.update_instance_pool(pool_id, update_instance_pool_details=update_details)
    lifecycle_state = update_instance_pool_response.data.lifecycle_state

    while lifecycle_state == "SCALING":
        lifecycle_state = compute_management_client.get_instance_pool(pool_id).data.lifecycle_state
        print('.....', end=' ')
        time.sleep(3)
    print(f'\ncluster network is running now with size {size}')


def get_instances_in_cn(cn_ocid):
    """
        Prints out instances in the clustered network
    :param cn_ocid: Clustered Network OCID
    :return: None
    """
    cluster_network_response = compute_management_client.get_cluster_network(
        cluster_network_id=cn_ocid)
    compartment = config['compartment']
    print(f'compartment: {compartment}')
    list_cluster_network_instances_response = compute_management_client.list_cluster_network_instances(compartment,
                                                                                                       cn_ocid)
    num_instances = len(list_cluster_network_instances_response.data)
    print("===========================")
    print(f'Instances in CN {cn_ocid}')
    for n in range(num_instances):
        print(list_cluster_network_instances_response.data[n].id)
    print("===========================")


@click.command()
@click.option("-cn", "--cluster-network", required=True,
              help='ocid of the CN e.g ocid1.clusternetwork.oc1.uk-london-1.amaaaaaa4z4h5dia4ivgilv4powh7za7jrhasep3wmcomirznczr4f3fxzoq')
@click.option("-s", "--size-cn", required=True, help='size of the CN e.g 2 ')
def cli(cluster_network, size_cn):
    update_cn_size(cluster_network, size_cn)
    get_instances_in_cn(cluster_network)


if __name__ == '__main__':
    cli()
