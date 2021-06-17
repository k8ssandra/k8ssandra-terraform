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
from azure.identity import ClientSecretCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.storage import StorageManagementClient
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient, _version_
from azure.mgmt.storage.models import (
    StorageAccountCreateParameters,
    StorageAccountUpdateParameters,
    Sku,
    SkuName,
    Kind
)
import os
import sys
# Following Credentials needs to be passed as environment variables.
credential = ClientSecretCredential(
        tenant_id = os.getenv('tenant_id'),
        client_id = os.getenv('client_id'),
        client_secret = os.getenv('client_secret')
    )
subscription_id = os.getenv('subscription_id')
# Create a new bucket in specific Location with storage class
def create_storage_account(storage_account_name, resource_group_name, Location):
   storage_client = StorageManagementClient(credential, subscription_id)
   availability_result = storage_client.storage_accounts.check_name_availability(
      { "name": storage_account_name }
   )
   if not availability_result.name_available:
      print(f"Storage name {storage_account_name} is already in use. Try another name.")
      exit()
   poller = storage_client.storage_accounts.begin_create(resource_group_name, storage_account_name,
       {
          "location" : Location,
          "kind": "StorageV2",
          "sku": {"name": "Standard_LRS"}
      }
   )
   account_result = poller.result()
   print(f"Provisioned storage account {account_result.name}")
   keys = storage_client.storage_accounts.list_keys(resource_group_name, storage_account_name)
   print(f"Primary key for storage account: {keys.keys[0].value}")
   conn_string = f"DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName={storage_account_name};AccountKey={keys.keys[0].value}"
   print(f"Connection string: {conn_string}")
   return conn_string

def list_storage_accounts():
    """ List all the Storage Accounts created in the resource group """
    #credential = DefaultAzureCredential()
    #subscription_id = "dc5ee5b1-4fc2-463e-a56b-ff54dd38b879"
    storage_client = StorageManagementClient(credential, subscription_id)
    storage_accounts = storage_client.storage_accounts.list()
    storage_accounts_list = []
    for storage_account in storage_accounts:
        storage_accounts_list.append(storage_account.name)
    return storage_accounts_list

# Create Storage Account, if it's not existed in the Storage Accounts list.
def create_storage_account_ifnotexist(storage_account_name, resource_group_name, Location, storage_container_name):
    """ Only create the Storage Account and Storage Container, if it is not in the list of all buckets"""
    storage_accounts_list = list_storage_accounts()
    print(storage_accounts_list)
    if storage_account_name not in storage_accounts_list:
        connection_string = create_storage_account(storage_account_name, resource_group_name, Location)
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