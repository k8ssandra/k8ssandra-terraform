#!/usr/bin/env python3.7

# Copyright 2021 DataStax, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Create Google cloud storage bucket if it is not exists
from azure.common.credentials import ServicePrincipalCredentials
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.storage import StorageManagementClient
from azure.mgmt.storage.models import StorageAccountCreateParameters
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient, __version__
import os
import sys

# Create a new bucket in specific location with storage class
def create_storage_account(storage_account_name, resource_group_name, location):
    """Create a new Storage Account to store your statefiles"""
    storage_client = storage_client()
    availability = storage_client.storage_accounts.check_name_availability(storage_account_name)
    print('The account {} is available: {}'.format(storage_account_name, availability.name_available))
    print('Reason: {}'.format(availability.reason))
    storage_client = storage_client()
    storage_client.storage_accounts.create(
        resource_group_name,
        storage_account_name,
        StorageAccountCreateParameters(sku=Sku(name=SkuName.standard_ragrs), kind=Kind.storage, location=location)
    )
    # Get properties of storage account.
    keys = storage_client.storage_accounts.list_keys(resource_group_name, storage_account_name)
    conn_string = f"DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName={storage_account_name};AccountKey={keys.keys[0].value}"
    return conn_string

# List all the buckets in the remote
def list_storage_accounts():
    """ List all the Storage Accounts created in the resource group """
    storage_client = storage_client()
    storage_accounts = storage_client.storage_accounts.list()
    storage_accounts_list = []
    for storage_account in storage_accounts:
        storage_accounts_list.append(storage_account.name)
    return storage_accounts_list

# Create Storage Account, if it's not existed in the Storage Accounts list.
def create_storage_account_ifnotexist(storage_account_name, resource_group_name, location, storage_container_name):
    """ Only create the Storage Account and Storage Container, if it is not in the list of all buckets"""
    storage_accounts_list = list_storage_accounts()
    if storage_account_name not in storage_accounts_list:
        connection_string = create_storage_account(storage_account_name, resource_group_name, location)
        # Create storage account container.
        blob_service_client = BlobServiceClient.from_connection_string(connection_string)
        blob_service_client.create_container(storage_container_name)
    else:
        print("{} Storage Account Name already exists".format(storage_account_name))

# Get the environment variables.
storage_account_name=os.getenv('storage_account_name')
location=os.getenv('TF_VAR_location') 
resource_group_name=os.getenv('resource_group_name')
storage_container_name=os.getenv('storage_container_name')

# Create state files bucket if not exists.
create_storage_account_ifnotexist(storage_account_name, resource_group_name, location, storage_container_name)
