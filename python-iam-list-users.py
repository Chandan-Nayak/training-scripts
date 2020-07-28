import boto3
import json

iam = boto3.client('iam')


user_name = 'newuser@cnayak.com'
user_present = True

# fetch users from iam
response = iam.list_users(MaxItems=25)

# prints all user info
print(json.dumps(response, indent=4, sort_keys=True, default=str))
print('\n')

#  print username from userinfo
for userinfo in response['Users']:
    print(userinfo['UserName'])






