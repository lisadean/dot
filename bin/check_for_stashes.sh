#!/bin/bash

# Change this to the path where your repositories are stored
base_dir="${1:-$PWD}"

# Loop through each subdirectory
for dir in "$base_dir"/*; do
    if [ -d "$dir/.git" ]; then
        # echo "Checking repository: $dir"
        
        # Navigate to the repository
        cd "$dir" || continue
        
        # Check if there are stashes
        stash_count=$(git stash list | wc -l)
        if [ "$stash_count" -gt 0 ]; then
            echo "🚨 $stash_count found in $dir"
        fi
        
        # Return to the base directory
        cd "$base_dir" || exit
    fi
done
