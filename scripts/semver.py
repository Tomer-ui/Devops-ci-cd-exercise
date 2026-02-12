import subprocess
import sys

def get_latest_tag():
    try:
        # Fetch tags to ensure we have the latest from origin
        subprocess.run(["git", "fetch", "--tags"], check=True, capture_output=True)
        # Get the latest tag name
        tag = subprocess.check_output(["git", "describe", "--tags", "--abbrev=0"], stderr=subprocess.STDOUT).decode('utf-8').strip()
        return tag
    except subprocess.CalledProcessError:
        return "v1.0.0"

def increment_version(version_str):
    # Remove 'v' prefix if present
    version_str = version_str.lstrip('v')
    parts = version_str.split('.')
    
    if len(parts) != 3:
        return "1.0.0"
    
    major, minor, patch = parts
    # Increment the patch version
    new_patch = int(patch) + 1
    return f"{major}.{minor}.{new_patch}"

if __name__ == "__main__":
    latest = get_latest_tag()
    new_version = increment_version(latest)
    print(new_version)