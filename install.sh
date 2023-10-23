#!/bin/bash

# シンボリックリンク作成先のディレクトリを指定
link_dir=~/bin

# スクリプトへのシンボリックリンクを作成
ln -s "$(pwd)/github-repo-open-file.sh" "$link_dir/github-repo-open-file"

# 実行権限を付与（元のスクリプトに対して）
chmod +x "./github-repo-open-file.sh"

# インストールが完了したことをユーザーに通知
echo "github-repo-open-file has been linked to $link_dir"
