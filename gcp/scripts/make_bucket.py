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
from google.cloud import storage
import os
import sys

# Create a new bucket in specific location with storage class
def create_bucket(bucket_name):
    """Create a new bucket in specific location with storage class"""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    bucket.storage_class = "STANDARD"
    new_bucket = storage_client.create_bucket(bucket, location="us")
    print("Created bucket {} in {} with storage class {}".format(new_bucket.name, new_bucket.location, new_bucket.storage_class))
    return new_bucket

# List all the buckets in the remote
def list_buckets():
    """ List all the buckets created """
    storage_client = storage.Client()
    buckets = storage_client.list_buckets()
    bucket_list = []
    for bucket in buckets:
        bucket_list.append(bucket.name)
    return bucket_list

# Create bucket if it's not exists in the list
def create_bucket_ifnotexist(bucket_name):
    """ Only create the bucket if it is not in the list of all buckets"""
    bucket_list = list_buckets()
    if bucket_name not in bucket_list:
        create_bucket(bucket_name)
    else:
        print("{} Bucket already exists".format(bucket_name))

# bucket_name is always starts with environment, resource name and statfiles
bucket_name=os.getenv('bucket_name')

# Create state files bucket if not exists.
create_bucket_ifnotexist(bucket_name)
