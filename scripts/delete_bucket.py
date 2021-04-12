#!/usr/bin/env python3.7

# Copyright 2021 Datastax LLC
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

# Delete bucket function is used to delete the state files bucket.
# This bucket will be created at make init run.
# To delete  
from google.cloud import storage
import os
import sys

def delete_bucket(bucket_name):
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name)
    try:
        bucket.delete()
        print("Bucket {} deleted".format(bucket.name))
    except:
        print("buckeet does not exists")

bucket_name = os.getenv("bucket_name")
delete_bucket(bucket_name)
