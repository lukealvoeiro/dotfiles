#!/bin/bash

# Show git branch and short status for factory repos

repos=(
    "$HOME/Development/factory-mono"
    "$HOME/Development/2factory-mono"
    "$HOME/Development/3factory-mono"
    "$HOME/Development/4factory-mono"
)

for repo in "${repos[@]}"; do
    if [[ -d "$repo/.git" ]]; then
        cd "$repo" || continue
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        
        # Get counts for short status
        staged=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
        modified=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
        untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
        
        status=""
        [[ $staged -gt 0 ]] && status+="+$staged "
        [[ $modified -gt 0 ]] && status+="~$modified "
        [[ $untracked -gt 0 ]] && status+="?$untracked"
        
        printf "%-40s %s %s\n" "$(basename "$repo")" "$branch" "$status"
    else
        printf "%-40s %s\n" "$(basename "$repo")" "(not found)"
    fi
done
