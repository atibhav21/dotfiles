#!/usr/bin/env bash
set -euo pipefail

install_langsmith() {
   curl -sSL https://raw.githubusercontent.com/langchain-ai/langsmith-cli/main/scripts/install.sh | sh 
}

install_langsmith