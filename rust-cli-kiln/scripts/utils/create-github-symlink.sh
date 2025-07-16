#!/bin/bash
set -euo pipefail

# プロジェクトルートに移動
cd "$(dirname "$0")/../.."

# mntディレクトリが存在しない場合は作成
mkdir -p mnt

# mnt以下にシンボリックリンクを作成
ln -s ../.github mnt/.github

echo "✅ シンボリックリンク作成完了: mnt/.github -> ../.github"