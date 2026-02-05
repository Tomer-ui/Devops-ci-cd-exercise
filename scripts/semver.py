import os
import re
import subprocess
import sys

def get_last_tag():
    try:
        # Get the latest tag (e.g., v1.0.1)
        cmd = "git describe --tags --abbrev=0"
        tag = subprocess.check_output(cmd.split()).decode().strip()
        return tag.replace('v', '')
    except:
        return "0.0.0"

def get_commit_message():
    # Get the last commit message
    cmd = "git log -1 --pretty=%B"
    return subprocess.check_output(cmd.split()).decode().strip()

def bump_version(current_ver, message):
    major, minor, patch = map(int, current_ver.split('.'))
    
    # Logic based on commit message keywords
    if "BREAKING" in message:
        major += 1
        minor = 0
        patch = 0
    elif "feat" in message.lower():
        minor += 1
        patch = 0
    elif "fix" in message.lower() or "bug" in message.lower():
        patch += 1
    else:
        # Default behavior for other commits
        patch += 1
        
    return f"{major}.{minor}.{patch}"

if __name__ == "__main__":
    last_ver = get_last_tag()
    msg = get_commit_message()
    
    # If starting fresh
    if last_ver == "0.0.0":
        new_ver = "1.0.0"
    else:
        new_ver = bump_version(last_ver, msg)
        
    print(new_ver)