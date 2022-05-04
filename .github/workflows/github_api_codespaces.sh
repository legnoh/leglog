create_codespace_for_pr() {
    local token=${1:?}
    local owner=${2:?}
    local repo=${3:?}
    local pr_number=${4:?}
    local location=${5:?}

    echo "Creating Codespace: ${owner}/${repo}/${pr_number}@${ws}"

    curl -f -X "POST" "https://api.github.com/repos/${owner}/${repo}/pulls/${pr_number}/codespaces" \
            -H 'Accept: application/vnd.github.v3+json' \
            -H "Authorization: Bearer ${token}" \
            -H 'Content-Type: application/json; charset=utf-8' \
            -d $'{"location": "SouthEastAsia"}'
}

get_pullreq_unused_spaces() {
    local token=${1:?}
    local owner=${2:?}
    local repo=${3:?}
    local ref=${4:?}
    target_workspaces=$(curl -f -X "GET" "https://api.github.com/repos/${owner}/${repo}/codespaces" \
            -H 'Accept: application/vnd.github.v3+json' \
            -H "Authorization: Bearer ${token}" \
            -H 'Content-Type: application/json; charset=utf-8' \
            | jq -r ".codespaces[] | select(.git_status.ref == \"${ref}\") | select (.git_status.has_unpushed_changes == false) | select (.git_status.has_uncommitted_changes == false) | .name")
    echo ${target_workspaces}
}

delete_codespace() {
    local token=${1:?}
    local owner=${2:?}
    local cs=${3:?}

    echo "Deleting Codespace: ${owner}/${cs}"
    
    curl -f -X "DELETE" "https://api.github.com/repos/${owner}/codespaces/${cs}" \
            -H 'Accept: application/vnd.github.v3+json' \
            -H "Authorization: Bearer ${token}" \
            -H 'Content-Type: application/json; charset=utf-8'
}
