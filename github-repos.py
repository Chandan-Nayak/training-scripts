from github import Github
import os

GITHUB_TOKEN = os.environ['GITHUB_TOKEN']


g = Github(GITHUB_TOKEN)

for repo in g.get_user().get_repos():
    print(repo.name)
