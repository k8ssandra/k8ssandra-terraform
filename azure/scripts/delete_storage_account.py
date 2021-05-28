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

# Delete Storage Account function is used to delete the Storage Account created for the terraform state files..
from azure.identity import ClientSecretCredential
from azure.mgmt.storage import StorageManagementClient
import os
import sys

# Following Credentials needs to be passed as environment variables.
credential = ClientSecretCredential(
        tenant_id = os.getenv('tenant_id'),
        client_id = os.getenv('client_id'),
        client_secret = os.getenv('client_secret')
    )
subscription_id = os.getenv('subscription_id')

def delete_storage_account(resource_group_name, storage_account_name):
    storage_client = StorageManagementClient(credential, subscription_id)
    """ delete the Storage Account created for the terraform state files. """
    try:
        storage_client.storage_accounts.delete(resource_group_name, storage_account_name)
        print("storage Account {} deleted".format(storage_account_name))
    except:
        print("Storage Account does not exists")

# Get environment variables
resource_group_name=os.getenv('resource_group_name')
storage_account_name=os.getenv('storage_account_name')

# Delete 
delete_storage_account(resource_group_name, storage_account_name)
