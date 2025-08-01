#!/usr/bin/env bash

GHAPI="https://api.github.com"
REPO="neovim/nvim-lspconfig"

API_URL="$GHAPI/repos/$REPO/contents/lsp"

TMP_JSON="/tmp/nvim_lspconfig_lsp_files.json"

curl -s "$API_URL" -o "$TMP_JSON"

if [ ! -s "$TMP_JSON" ]; then
  echo "Failed to fetch file from api."
  exit 1
fi

NAMES=$(jq -r '.[] | select(.type == "file") | .name' "$TMP_JSON")

SELECTED=$(echo "$NAMES" | fzf --prompt="Select LSP config: " --height=~80% --layout=reverse --border --exit-0)

if [ -z "$SELECTED" ]; then
  echo "No client selected."
  exit 0
fi

# Get download_url from JSON
URL=$(jq -r --arg name "$SELECTED" '.[] | select(.name == $name) | .download_url' "$TMP_JSON")

if [ -z "$URL" ]; then
  echo "Failed to find download URL for $SELECTED"
  exit 1
fi

echo "Downloading $SELECTED..."

curl -fSL "$URL" -o "lsp/$SELECTED"

if [ $? -eq 0 ]; then
  echo "Saved as $SELECTED"
else
  echo "Failed to download $SELECTED"
  exit 1
fi

