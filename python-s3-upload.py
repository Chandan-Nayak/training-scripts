import boto3
import json

iam = boto3.client('iam')


file = 'index.html'
bucket = 'training-july'
object_name = file

s3_client = boto3.client('s3')
response = s3_client.upload_file(file, bucket, object_name)




