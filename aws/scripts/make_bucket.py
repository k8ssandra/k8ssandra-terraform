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

# Create AWS s3 storage bucket if it is not exists.
import logging
import boto3

# Create a new bucket in AWS
def create_bucket(bucket_name):
    """Create a new bucket in specific location with storage class"""
    s3_client = boto3.client('s3')
    s3_client.create_bucket(Bucket=bucket_name)
    print("Created bucket {} ".format(bucket_name))
    return bucket_name

# List all the buckets in the remote
def list_buckets():
    """ List all the buckets created """
    s3 = boto3.client('s3')
    buckets = s3.list_buckets()
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
