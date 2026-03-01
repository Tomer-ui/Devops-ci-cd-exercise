import sys
import os

def get_version():
    # Fetch build number from Jenkins environment, default to 1 for local testing
    build_number = os.environ.get('BUILD_NUMBER', '1')
    return f"1.0.{build_number}"

if __name__ == "__main__":
    print(get_version())