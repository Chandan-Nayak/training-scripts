import boto3
import json

iam = boto3.client('iam')


user_name = 'newuser1@cnayak.com'
user_present = True

try:
    response = iam.get_user(UserName=user_name)
except iam.exceptions.NoSuchEntityException as error:
    user_present = False


if not user_present:
    # create the user
    result = iam.create_user( UserName=user_name)
    
    # attach a policy
    iam.attach_user_policy(
    UserName = user_name,
    PolicyArn='arn:aws:iam::aws:policy/AmazonEC2FullAccess'
    )
    print(json.dumps(result, indent=4, sort_keys=True, default=str))
else:
    print('INFO: User already there, username:', user_name)





