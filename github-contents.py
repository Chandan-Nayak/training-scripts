from github import Github
import os

GITHUB_TOKEN = os.environ['GITHUB_TOKEN']

REPO_NAME = 'Chandan-Nayak/training-scripts'

g = Github(GITHUB_TOKEN)

repo = g.get_repo(REPO_NAME)

contents = repo.get_contents("")
for content_file in contents:
    print(content_file)