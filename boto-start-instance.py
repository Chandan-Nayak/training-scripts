import boto3

tagname = "Name"
tagvalue = "go-app"
ec2 = boto3.resource('ec2')
result = ec2.instances.filter(Filters=[
    {"Name":"tag:"+tagname, 'Values':[tagvalue]},
    {'Name': 'instance-state-name', 'Values': ['stopped']}
]).start()

print(result)
