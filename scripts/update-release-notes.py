import requests

def get_latest_releases(owner, repo, num_releases=2):
    url = f'https://api.github.com/repos/{owner}/{repo}/releases'
    response = requests.get(url)
    if response.status_code == 200:
        releases = response.json()
        return releases[:num_releases]
    elif response.status_code == 403:
        error_message = response.json().get('message', '')
        if "rate limit exceeded" in error_message:
            print("Error: API rate limit exceeded. Please try again later.")
        else:
            print(f"Failed to retrieve releases. Status code: {response.status_code}")
        return []
    else:
        print(f"Failed to retrieve releases. Status code: {response.status_code}")
        return []

def generate_release_notes(releases):
    release_notes = "## Release Notes\n"
    for release in releases:
        name = release['name']
        html_url = release['html_url']
        body = release['body']
        release_notes += f"### [{name}]({html_url})\n"
        release_notes += body.strip() + "\n"
    return release_notes

def update_mdx_file(filename, release_notes):
    with open(filename, 'r') as file:
        content = file.readlines()

    # Find where Release Notes starts, if exists
    release_notes_index = None
    for i, line in enumerate(content):
        if line.strip() == "## Release Notes":
            release_notes_index = i
            break

    # If Release Notes section exists, delete everything below it
    if release_notes_index is not None:
        content = content[:release_notes_index]

    # Refresh with newest release notes
    with open(filename, 'w') as file:
        file.writelines(content)
        if release_notes_index is None:  # add a line break if it's the first run
            file.write('\n')
        file.write(release_notes)

if __name__ == "__main__":
    owner = "massdriver-cloud"
    repo = "azure-storage-account-application-assets"
    releases = get_latest_releases(owner, repo)
    release_notes = generate_release_notes(releases)
    update_mdx_file("operator.mdx", release_notes)
