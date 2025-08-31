#!/bin/sh

# Reset repository.
git reset --hard HEAD

# Set up.
./setup.sh

# Create repos/ link in each application directory.
./create-repos.sh

# Create test Kraftfiles.
./create-test-kraftfiles.sh

# Build runtimes.
./build-apps.sh

# Pack runtimes.
./pack-apps.sh

# Run applications.
./run-apps.sh
