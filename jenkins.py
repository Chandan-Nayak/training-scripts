'''
pip3 install jenkinsapi
'''

from jenkinsapi.jenkins import Jenkins


def get_server_instance():
    jenkins_url = 'http://localhost:8080'
    server = Jenkins(jenkins_url, username='chandan', password='nayak')
    return server


if __name__ == '__main__':

    server = get_server_instance()
    print("Version of Jenkins: ", server.version)


    jobs = list(server.get_jobs())
    print("\nList of all the jobs in local jenkins: ")
    for job in jobs:
        print(job[0])
    

    print("\ndemo1 - job info")
    job_name = "demo1"
    if (server.has_job(job_name)):
        job_instance = server.get_job(job_name)
        print("Job description: ",job_instance.get_description())
        print("First build number: ", job_instance.get_first_buildnumber())