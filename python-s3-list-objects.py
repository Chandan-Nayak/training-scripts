import boto3
import json




bucket = 'training-july'

s3_client = boto3.client('s3')
response = s3_client.list_objects(Bucket=bucket)
print(json.dumps(response, indent=4, sort_keys=True, default=str))